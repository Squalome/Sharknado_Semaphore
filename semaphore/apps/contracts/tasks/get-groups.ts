import { SemaphoreSubgraph } from "@semaphore-protocol/data"
import { task } from "hardhat/config"

task("get-groups", "My task description").setAction(async (_taskArguments, { network }) => {
    const semaphoreSubgraph = new SemaphoreSubgraph(network.name)

    const groupIds = await semaphoreSubgraph.getGroupIds()

    console.log("groupIds", groupIds)
})
