import { task, types } from "hardhat/config"

task("deploy", "Deploy a Sharknado contract")
    .addOptionalParam("semaphore", "Semaphore contract address", undefined, types.string)
    .addOptionalParam("logs", "Print the logs", true, types.boolean)
    .setAction(async ({ logs, semaphore: semaphoreAddress, group: groupId }, { ethers, run }) => {
        if (!semaphoreAddress) {
            const { semaphore } = await run("deploy:semaphore", {
                logs
            })

            semaphoreAddress = semaphore.address
        }

        const SharknadoFactory = await ethers.getContractFactory("Sharknado")

        const sharknadoContract = await SharknadoFactory.deploy(semaphoreAddress)

        await sharknadoContract.deployed()

        if (logs) {
            console.info(`Sharknado contract has been deployed to: ${sharknadoContract.address}`)
        }

        return sharknadoContract
    })
