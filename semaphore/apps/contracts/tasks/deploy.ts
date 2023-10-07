import { task, types } from "hardhat/config"

task("deploy-sharknado", "Deploy a Sharknado contract")
    .addOptionalParam("semaphore", "Semaphore contract address", undefined, types.string)
    .addOptionalParam("logs", "Print the logs", true, types.boolean)
    .setAction(async ({ logs, semaphore: semaphoreAddress }, { ethers, run }) => {
        const SharknadoFactory = await ethers.getContractFactory("Sharknado")

        const overrides = {
            gasPrice: ethers.utils.parseUnits("1", "gwei") // Specify a higher gas price
        }
        const sharknadoContract = await SharknadoFactory.deploy(semaphoreAddress, overrides)

        await sharknadoContract.deployed()

        if (logs) {
            console.info(`Sharknado contract has been deployed to: ${sharknadoContract.address}`)
        }

        return sharknadoContract
    })

task("deploy-semaphore-pairing", "")
    .addOptionalParam("logs", "Print the logs", true, types.boolean)
    .setAction(async ({ logs }, { ethers }) => {
        const pairingFactory = await ethers.getContractFactory("@semaphore-protocol/contracts/base/Pairing.sol:Pairing")

        const overrides = {
            gasPrice: ethers.utils.parseUnits("1", "gwei") // Specify a higher gas price
        }
        const pairingContract = await pairingFactory.deploy(overrides)

        await pairingContract.deployed()

        if (logs) {
            console.info(`Semaphore pairing contract has been deployed to: ${pairingContract.address}`)
        }

        return pairingContract
    })

task("deploy-semaphore-base", "Deploy semaphore base contracts")
    .addOptionalParam("pairingcontractaddress", "address of pairing contract", true, types.string)
    .addOptionalParam("logs", "Print the logs", true, types.boolean)
    .setAction(async ({ pairingcontractaddress, logs }, { ethers }) => {
        // const SemaphoreGroupsFactory = await ethers.getContractFactory("contracts/base/SemaphoreGroups.sol:SemaphoreGroups")
        const SemaphoreVerifierFactory = await ethers.getContractFactory(
            "@semaphore-protocol/contracts/base/SemaphoreVerifier.sol:SemaphoreVerifier",
            {
                libraries: { Pairing: pairingcontractaddress }
            }
        )

        const overrides = {
            gasPrice: ethers.utils.parseUnits("1", "gwei") // Specify a higher gas price
        }

        // const semaphoreGroupsContract = await SemaphoreGroupsFactory.deploy(overrides)
        const semaphoreVerifierContract = await SemaphoreVerifierFactory.deploy(overrides)

        // await semaphoreGroupsContract.deployed()
        await semaphoreVerifierContract.deployed()

        if (logs) {
            // console.info(`Semaphore groups contract has been deployed to: ${semaphoreGroupsContract.address}`)
            console.info(`Semaphore verifier contract has been deployed to: ${semaphoreVerifierContract.address}`)
        }

        return [semaphoreVerifierContract]
    })
