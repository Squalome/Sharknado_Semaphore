import { SemaphoreSubgraph } from "@semaphore-protocol/data"
import { task } from "hardhat/config"

task("get-groups", "My task description").setAction(async (_taskArguments, { network }) => {
    const semaphoreSubgraph = new SemaphoreSubgraph(
        "https://api.studio.thegraph.com/query/54895/sharknadosemaphoregraph/version/latest"
        // "https://api.studio.thegraph.com/query/54895/sharknadosemaphoregraph/v0.0.1"
        // network.name
    )

    const groupIds = await semaphoreSubgraph.getGroupIds()

    console.log("groupIds", groupIds)
})
