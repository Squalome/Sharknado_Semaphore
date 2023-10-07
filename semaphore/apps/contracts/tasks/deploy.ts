import { task, types } from "hardhat/config"

task("deploy", "Deploy a Sharknado contract")
    .addOptionalParam("semaphore", "Semaphore contract address", undefined, types.string)
    .addOptionalParam("group", "Group id", "42", types.string)
    .addOptionalParam("logs", "Print the logs", true, types.boolean)
    .setAction(async ({ logs, semaphore: semaphoreAddress, group: groupId }, { ethers, run }) => {
        if (!semaphoreAddress) {
            const { semaphore } = await run("deploy:semaphore", {
                logs
            })

            semaphoreAddress = semaphore.address
        }

        if (!groupId) {
            groupId = process.env.GROUP_ID
        }

        const SharknadoFactory = await ethers.getContractFactory("Sharknado")

        const sharknadoContract = await SharknadoFactory.deploy(semaphoreAddress, groupId)

        await sharknadoContract.deployed()

        if (logs) {
            console.info(`Sharknado contract has been deployed to: ${sharknadoContract.address}`)
        }

        return sharknadoContract
    })
