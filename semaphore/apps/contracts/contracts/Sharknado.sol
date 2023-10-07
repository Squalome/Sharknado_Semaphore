//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@semaphore-protocol/contracts/interfaces/ISemaphore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Sharknado is Ownable {
    ISemaphore public semaphore;

    uint256 questionId = 1;

    struct Question {
        uint256 questionId;
        uint256 groupId;
        string question;
        address eligibleHolderTokenContract;
        uint32 answerThreshold;
        uint256 bountyAmount;
        uint32 upVote;
        uint32 downVote;
        address[] lotteryPayoutAddresses;
        bool isPayedOut;
    }

    mapping(uint256 => mapping(uint256 => bool)) questionIdentityCommitments;

    Question[] questionList;

    event QuestionAdded(
        uint256 questionId,
        uint256 groupId,
        string question,
        address eligibleHolderTokenContract,
        uint32 answerThreshold,
        uint256 bountyAmount
    );
    event GroupJoined(uint256 groupId);
    event QuestionAnswered(
        uint256 questionId,
        uint256 groupId,
        bool isUpvote,
        uint256 totalVotes
    );
    error OnlyEligibleHoldersCanJoin();
    error CanOnlyJoinGroupOnce();
    error InvalidBountyAmount();
    error NullifierAlreadyExists();

    constructor(address semaphoreAddress) {
        semaphore = ISemaphore(semaphoreAddress);
    }

    function addQuestion(
        uint256 groupId,
        string memory question,
        address eligibleHolderTokenContract,
        uint32 answerThreshold,
        uint256 bountyAmount
    ) external payable onlyOwner {
        if (msg.value != bountyAmount) {
            revert InvalidBountyAmount();
        }

        uint256 depth = 20;
        semaphore.createGroup(groupId, depth, address(this));

        Question memory questionStruct = Question(
            questionId,
            groupId,
            question,
            eligibleHolderTokenContract,
            answerThreshold,
            bountyAmount,
            0,
            0,
            new address[](0),
            false
        );
        questionList.push(questionStruct);

        questionId += 1;
    }

    function joinGroup(
        uint256 _questionId,
        uint256 _groupId,
        uint256 _identityCommitment
    ) external {
        Question memory questionStruct = questionList[_questionId];
        IERC721 eligibleHolderTokenContract = IERC721(
            questionStruct.eligibleHolderTokenContract
        );

        if (eligibleHolderTokenContract.balanceOf(msg.sender) == 0) {
            revert OnlyEligibleHoldersCanJoin();
        }

        if (questionIdentityCommitments[_questionId][_identityCommitment]) {
            revert CanOnlyJoinGroupOnce();
        }

        // FIXME, validation: how to make sure, same user is not joining several times?
        // Is this needed?
        questionIdentityCommitments[_questionId][_identityCommitment] = true;

        semaphore.addMember(_groupId, _identityCommitment);
        emit GroupJoined(_groupId);
    }

    function sendAnswerToQuestion(
        uint256 _questionId,
        uint256 _groupId,
        bool _isUpvote,
        address _lotteryPayoutAddress,
        uint256 _merkleTreeRoot,
        uint256 _nullifierHash,
        uint256[8] calldata _proof
    ) external {
        /// @notice functionality:
        /// how does verifyProof work with additional parameters? Does it need to be proofed as well?
        /// Answer: the parameters have be meshed together, as long as this is within uin256 limits its fine
        /// and we don't need to deploy a new semaphore contract
        // TODO: check how longer params could be verified with semaphore

        /// @notice validation: how to make sure, user is not sending answer twice?
        /// Answer: this is taken care of by semaphore verification, same identity can't submit more than one answer
        /// this is signal independant
        /// no need to track nullifiers ourselves

        uint256 packedData = packData(_lotteryPayoutAddress, _isUpvote);

        // TODO, understand: using groupId twice?
        semaphore.verifyProof(
            _groupId,
            _merkleTreeRoot,
            packedData,
            _nullifierHash,
            _groupId,
            _proof
        );

        Question memory questionStruct = questionList[_questionId];
        questionStruct.upVote += _isUpvote ? 1 : 0;
        questionStruct.downVote += _isUpvote ? 0 : 1;

        questionList[_questionId] = questionStruct;
        questionList[_questionId].lotteryPayoutAddresses.push(
            _lotteryPayoutAddress
        );

        emit QuestionAnswered(
            _questionId,
            _groupId,
            _isUpvote,
            questionStruct.upVote + questionStruct.downVote
        );

        if (
            !questionStruct.isPayedOut &&
            questionStruct.upVote + questionStruct.downVote >=
            questionStruct.answerThreshold
        ) {
            startLotteryPayout(_questionId);
        }
    }

    function startLotteryPayout(uint256 _questionId) internal {
        Question memory questionStruct = questionList[_questionId];
        uint256 prize = questionStruct.bountyAmount;

        uint256 participantsLength = questionStruct
            .lotteryPayoutAddresses
            .length;
        uint256 index = random(participantsLength) % participantsLength;
        address winner = questionStruct.lotteryPayoutAddresses[index];

        questionList[_questionId].isPayedOut = true;
        payable(winner).transfer(prize);
    }

    /// @dev In the packData function, we perform a bitwise OR operation (|) between the uint256 representation of
    /// the address (uint256(_myAddress)) and the left-shifted boolean value ((uint256(_myBool ? 1 : 0) << 160)).
    /// This packs the address at the lower bits of the uint256 variable and the boolean at the 161st bit.
    function packData(
        address _address,
        bool _isUpvote
    ) public pure returns (uint256) {
        uint256 packedData = uint256(uint160(_address)) |
            (uint256(_isUpvote ? 1 : 0) << 160);
        return packedData;
    }

    /// @dev In the unpackData function, we use the bitwise AND operation (&) and the bitwise right-shift
    /// operation (>>) to extract the address and boolean from the packed uint256 variable.
    /// We use a mask ((1 << 160) - 1) to obtain the lower 160 bits for the address,
    /// and then shift right by 160 bits to get the boolean value.
    function unpackData(
        uint256 _packedData
    ) public pure returns (address, bool) {
        address _address = address(uint160(_packedData) & ((1 << 160) - 1));
        bool _isUpvote = (_packedData >> 160) & 1 == 1;
        return (_address, _isUpvote);
    }

    // FIXME, implementation: Have better implementation, using azuro
    function random(uint256 participantsLength) private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        participantsLength
                    )
                )
            );
    }
}
