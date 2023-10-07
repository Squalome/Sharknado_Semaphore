import dotenv from "dotenv"
import { task, types } from "hardhat/config"
import { Contract, providers, Wallet } from "ethers"
import Sharknado from "../build/contracts/contracts/Sharknado.sol/Sharknado.json"

dotenv.config()

task("add-question", "add a question and create semaphore group")
    .addParam("contractaddress", "Contract Address of Sharknado", "", types.string)
    .addParam("groupid", "Group id", "", types.string)
    .addParam("question", "Question to ask", "", types.string)
    .addParam("eligibleholdertokencontract", "which NFT to check", "", types.string)
    .addParam("answerthreshold", "number of participants until lottery triggered", "", types.string)
    .addParam("bountyamount", "how much bounty in wei to send along", "", types.int)
    .setAction(
        async (
            { contractaddress, groupid, question, answerthreshold, eligibleholdertokencontract, bountyamount },
            { network }
        ) => {
            if (typeof process.env.INFURA_API_KEY !== "string") {
                throw new Error("Please, define INFURA_API_KEY in your .env file")
            }

            if (typeof process.env.ETHEREUM_PRIVATE_KEY !== "string") {
                throw new Error("Please, define ETHEREUM_PRIVATE_KEY in your .env file")
            }

            const ethereumPrivateKey = process.env.ETHEREUM_PRIVATE_KEY
            const infuraApiKey = process.env.INFURA_API_KEY

            const provider =
                network.name === "localhost"
                    ? new providers.JsonRpcProvider("http://127.0.0.1:8545")
                    : new providers.InfuraProvider(network.name, infuraApiKey)

            const signer = new Wallet(ethereumPrivateKey, provider)
            const contract = new Contract(contractaddress, Sharknado.abi, signer)

            const transaction = await contract.addQuestion(
                groupid,
                question,
                eligibleholdertokencontract,
                answerthreshold,
                bountyamount
            )

            await transaction.wait()

            console.log("successful transaction", transaction.hash)
        }
    )
