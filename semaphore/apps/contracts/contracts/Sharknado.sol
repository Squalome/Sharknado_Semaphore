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
        // mapping(uint256 => bool) nullifierHashAnswers;
    }

    Question[] questionList;

    event QuestionAdded(
        uint256 questionId,
        uint256 groupId,
        string question,
        address eligibleHolderTokenContract,
        uint32 answerThreshold,
        uint256 bountyAmount
    );
    error OnlyEligibleHoldersCanJoin();
    error InvalidBountyAmount();

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

        // FIXME, validation: how to make sure, same user is not joining several times?

        semaphore.addMember(_groupId, _identityCommitment);
    }

    function sendAnswerToQuestion(
        uint256 _questionId,
        uint256 _groupId,
        uint256 _isUpvote,
        address _lotteryPayoutAddress,
        uint256 _merkleTreeRoot,
        uint256 _nullifierHash,
        uint256[8] calldata _proof
    ) external {
        // FIXME, functionality:
        // how does verifyProof work with additional parameters?
        // do we have to deploy a new semaphore version in order to account for `bool _isUpvote`?

        // FIXME, validation: how to make sure, user is not sending answer twice?
        // using nullifier?

        // TODO, understand: using groupId twice?
        semaphore.verifyProof(
            _groupId,
            _merkleTreeRoot,
            _isUpvote,
            _nullifierHash,
            _groupId,
            _proof
        );

        Question memory questionStruct = questionList[_questionId];
        if (_isUpvote == 1) {
            questionStruct.upVote++;
        } else {
            questionStruct.downVote++;
        }

        questionList[_questionId] = questionStruct;
        questionList[_questionId].lotteryPayoutAddresses.push(
            _lotteryPayoutAddress
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
