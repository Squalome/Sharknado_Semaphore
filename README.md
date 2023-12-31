# Sharknado_ethRome

This is an implementation of the [EthRome Hackathon](https://ethrome.org/).

You can find [the submission here](https://taikai.network/ethrome/hackathons/ethrome-23/projects/clnfyh1ya00gmye01j19ob1rz/idea).

[Sharknado deployed website](https://sharknado.vercel.app)

[Sharknado deployed contract on Gnosis Mainnet](https://gnosisscan.io/address/0xefb23e1a4573eba1385d2730a4ddb9aeeb6ea20f)

[Related Repo for the frontend and subgraphs](https://github.com/Squalome/sharknado)

We were using the [semaphore repo](https://github.com/semaphore-protocol/semaphore/blob/main/packages/contracts/tasks/deploy-semaphore.ts) to deploy to the gnosis testnet.

Check out our [Figma prototype](https://www.figma.com/proto/Sharknado) and [TAIKAI submission](https://taikai.network/ethrome/hackathons/ethrome-23/projects/clnfyh1ya00gmye01j19ob1rz/idea)!

Working from [contracts folder](./apps/contracts/).

## DESCRIPTION

A platform where you can take surveys anonymously, authenticate your NFT ownership with zk proofs, and win cash prizes in a pseudo-annonomized & randomized bounty system.

## Bounties (provide a description or explanation on how you integrated any bounty sponsors technology)

### PSE/Semaphore:

Utilized Semaphore from PSE to authenticate NFT ownership through ZK proofs and signaling in groups to participate in the survey.

We also take on the challenge to deploy semaphore on Gnosis mainnet: 0xee5cF4Cc94bb97E2bA0d0a115b69c6075Ce42DD1 and deployed subgraphs on gnosis mainnet: https://thegraph.com/studio/subgraph/sharknadosemaphoregraph

Information leaks challenges & possible solutions going forward:

-   The voting signal includes a boolean (vote) + a sudo-annonymous fresh wallet address of the user to recieve bounty when won in the lottery. When a winner moves their funds and makes onchain traces to reveal their identity (RIP TornadoCash's freedom), their vote will be public linked to their identity. SOLUTION: Creating a series circuit (2nd group) which only those who got the proof to send a signal in the first group can join and send their fresh new address as signal seperatly from their vote. Creating a series circuit to the first template circuit by Semaphore requires us to implement it from scratch with was out of the scope of time in this hackathon.

-   The process of joining a group creates an onchain transaction which reveals who joined a group. Therefore one can know who is in the group, but can not know what each individual vote.

### Gnosis:

We intended to implement Survey with Swansky platform, however given we didn't have any experience with Swansky, and lack of interoprobablity with other bounties & technology stacks that we decided for this hackathon, we went with a different approach.

We tried on testnet, however subgraphs could not be deployed there, as well as other toolings, therefore we went and deployed on the mainnet. The reason we needed to implement subgraphs, was that for using Semaphore package, there was a dependency of using subgraphs in client.

On the positive side, we are live on mainnet :) Enjoy playing, or implement client to publish surveys.

### The Graph:

We deployed subgraphs for two contracts:

1. Semaphore.sol contract on gnosis mainnet: https://thegraph.com/studio/subgraph/sharknadosemaphoregraph
   Build completed: QmcxFkVPtMBtiH6a8yWFQk9nt8h5cr4Um4eGcWG46ds8QB
   Queries (HTTP): https://api.studio.thegraph.com/query/54895/sharknadosemaphoregraph/v0.0.1

2. Sharknado.sol contract on gnosis mainnet:
   https://api.studio.thegraph.com/query/54895/sharknadograph/version/latest

3. SharkToken.sol contract on gnosis mainnet:
   https://api.studio.thegraph.com/query/54895/sharktokengraph/v0.0.1

### BUIDLGUIDL:

We used Scaffold-ETH2 it as a boiler plate to leverage the prebuilt components integrating with smart contracts via Hot Reload & integration with wallet providers.

Thanks for making our life easier: https://sharknado.vercel.app/

### Interface:

The entire design concept of Sharknado draws inspiration from the world of sharks and ocean waves.

Brand Concept:
In our brand vision, we have strived to infuse a contemporary energy with vibrant electric colors: "Navy Blue" and "Aquagreen". "Otto Attack Wide" was the perfect matching font, because it is contrasting serif typeface featuring sharp angles reminiscent of shark teeth to create a visually captivating effect. This balanced design exudes an assertive and dynamic vibe, ideal for a such web3 projects.

UX Mechanics:
We have implemented an onboarding process to facilitate educational purposes, ensuring users can easily get acquainted with our product. Our gamification strategy on the success page aims to boost users' engagement and involvement metrics, making the product experience a rewarding one. To enhance user Retention, we provide recommendations after users complete their flow. Progress bars are judiciously utilized whenever necessary to keep users informed and prevent any undue stress. We streamline and bundle transactions into cohesive steps to ensure users navigate the process without feeling overwhelmed or fatigued.

We are not able to complete pixelperfect design with out Frontend part, so you can check the design flow in our team Figma
You can check the clickable prototype Figma here
And the Design itself in Figma here

Business value of Interface for Sharknado:
Interface provides onchain feed of happenings and Sharknado provides offchain opinions. We see this a match made in the ocean, given the value of such data COMBINED for web3 market research is many folds higher.

### Screens

![sharknadoscreen quests](./docs/sharknado_screen.jpg)

![sharknadoscreen winners](./docs/sharknado_screen_ii.jpg)

## Gnosis Mainnet

### Semaphore on Gnosis-Mainnet

`hh deploy:semaphore --network gnosis`

Pairing library has been deployed to: 0x148B94D622c2Ac3abfb550AEaF48F25F105EA18b  
SemaphoreVerifier contract has been deployed to: 0x53D4D0FFf2d9c62Ac51f15856eaB323802845A6b  
Poseidon library has been deployed to: 0x3706a43642eC170E9E5e57fa3929FAD854A8fC4E  
IncrementalBinaryTree library has been deployed to: 0x4bd2c593ebDe58aE306EcEbEF11017A6E302d883  
Semaphore contract has been deployed to: 0xee5cF4Cc94bb97E2bA0d0a115b69c6075Ce42DD1

### Sharknado on Gnosis-Mainnet

`hh deploy-sharknado --semaphore 0xee5cF4Cc94bb97E2bA0d0a115b69c6075Ce42DD1 --network gnosis`

Sharknado contract has been deployed to: 0xeFB23e1a4573eBA1385D2730A4ddB9aeeb6ea20F

### Eligible NFT Contract

[0xf649cb1884dcf8bac5ccfa669083c489288685bb](https://gnosisscan.io/address/0xf649cb1884dcf8bac5ccfa669083c489288685bb)

### Adding Questions

"As an Italian, do you think pineapple is an acceptable pizza topping? Yes/No"

"Do you consider your Pixel Hipster face your true profile pic? Yes / No"

"Would you drop your banana for a Boat Monkey-only yacht party? Yes / No"

"Do you think your pixelated doodles will hang in the 'Museum of the Internet' one day? Yes / No"

"Is your virtual lawn better maintained than your real one? Yes / No"

#### 1

question="Do you consider your Pixel Hipster face your true profile pic? Yes / No"
sharknadoAddress=0x10d7526150f4134d9B6631c8C4A6d812a91dFfA7
eligibleholdertokencontract=0xf649cb1884dcf8bac5ccfa669083c489288685bb

`hh add-question --contractaddress $sharknadoAddress --groupid 2 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`
successful transaction 0xd4db33a4dc632d54a1ef39ad58a6bef6479ae309a2f89bff42a83322332829e5

#### 2

question="Would you drop your banana for a Boat Monkey-only yacht party? Yes / No"

`hh add-question --contractaddress $sharknadoAddress --groupid 3 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`
successful transaction 0xbbb31a92819fef42deeff9e6dcb125e4cecf1b9a148019aacb3920eb3d14f172

#### 3

question="Do you think your pixelated doodles will hang in the 'Museum of the Internet' one day? Yes / No"

`hh add-question --contractaddress $sharknadoAddress --groupid 4 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0xa0f5190fa9eba6a3618696276cc00536ed92935a3bb68e101b1551918a44311c

#### 4

question="Is your virtual lawn better maintained than your real one? Yes / No"

`hh add-question --contractaddress $sharknadoAddress --groupid 5 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x89d6aa8d11f8f563e22781ce44f3567e9b873ba870a4257d58eb5c4dd2d16d87

#### 5

`hh add-question --contractaddress $sharknadoAddress --groupid 6 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x56683b39b60e3a41337fb2fdb9baf095dbefbdd7291756dab896696d261a42fd

#### 6

`hh add-question --contractaddress $sharknadoAddress --groupid 7 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x793d1dc2bf5f348977a176fb995d0654b15c33122596907aafca06b04a0df600

#### 7

`hh add-question --contractaddress $sharknadoAddress --groupid 8 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x1803c7e4acaf57f06d2e7f3df9a73757685a643b7d5ed0dcd6dae9b653980632

#### 8

`hh add-question --contractaddress $sharknadoAddress --groupid 9 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x07798460596b24eb05f7c4e0e0f4c190b7a53659e78b2adbe8cdf6efc238eeed

#### 9

`hh add-question --contractaddress $sharknadoAddress --groupid 10 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x6fc55f424c9db3444f9b99e232ce148e73e5e04529a01bbe7a3672470d898131

#### 10

`h add-question --contractaddress $sharknadoAddress --groupid 11 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x90685123038f09b05f6a6cb48e994d6bf8c68fd102d8c5f4b811ed3b6c3cfc96

#### 11

`hh add-question --contractaddress $sharknadoAddress --groupid 12 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x4d185343afe809c33e0602183bc81e05fc07c546956a89481590eb9f10e6305e

#### 12

`hh add-question --contractaddress $sharknadoAddress --groupid 13 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x258a7293106a82655adab306e6fe9df376e42175c587f2e01418c1f05b5f654d

#### 13

`hh add-question --contractaddress $sharknadoAddress --groupid 14 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x66f662cd18ba47597f92294c182e87489cf5e5ac2b2720dae0e7b3fd73eea1a8

#### 14

`hh add-question --contractaddress $sharknadoAddress --groupid 15 --question $question --eligibleholdertokencontract $eligibleholdertokencontract --answerthreshold 3 --bountyamount 1 --network gnosis`

successful transaction 0x4f33235447f1ec07f8c81d6c1e9bd68b82f51d3ed167b2acb0b8ed58083eaf94

## Gnosis-Chiado

### Semaphore on Gnosis-Chiado

`hh deploy:semaphore --network gnosis-chiado`

Pairing library has been deployed to: 0x148B94D622c2Ac3abfb550AEaF48F25F105EA18b  
SemaphoreVerifier contract has been deployed to: 0x53D4D0FFf2d9c62Ac51f15856eaB323802845A6b  
Poseidon library has been deployed to: 0x3706a43642eC170E9E5e57fa3929FAD854A8fC4E  
IncrementalBinaryTree library has been deployed to: 0x4bd2c593ebDe58aE306EcEbEF11017A6E302d883  
Semaphore contract has been deployed to: 0xee5cF4Cc94bb97E2bA0d0a115b69c6075Ce42DD1

### Sharknado on Gnosis-Chiado

`hh deploy-sharknado --semaphore 0xee5cF4Cc94bb97E2bA0d0a115b69c6075Ce42DD1 --network gnosis-chiado`

Sharknado contract has been deployed to: 0x63b9F0DFa2a6a3604Fb301b376Dc3a5b133EDd3a

`hh get-groups --network arbitrum-goerli`

groupIds [
'1',
'102311641944902526096460474100010278060726240402945964730937105032924181153172',
'102774439462635995736574175749750381764021366967395515882755527252850571587472',
'111',
'111883545609594655246229514782439047747605767371063964596741815761212595725626',
'1314',
'15849008261241381139635373273234861964995703808233252681222658593802767495134',
'22788915214580367044908340290073286349427000665542980538615928646896200808383',
'23532587172813775988042870439966527107699983609246009006238984316994516199819',
'2525',
'256',
'27870788609736775133878493568907516411317867956208510823107663120721120320029',
'29565394379771225033311741395955329405917795422236856196546106163401079855775',
'31951213651197339166102967387615613340273500518810479122614413747274727278905',
'42',
'4210',
'43816705306257777801603683277339071856260146317827116539577379726632390283382',
'44',
'516',
'61784462634421273737878570409620440958699887966177521342310175912949418816117',
'62742923822733591049165603322992786934635929282582646451858180453029170361193',
'64972856678839236027500883209040066357520728692354125957351541586326545339528',
'70480675249767083577729639110425153643073772853894593687429109004276222432515',
'71862430433896991442296728973989117736395938601034992437781099084485874426096',
'78076723699124835419650797493320950193910532576088846530510427025157648989669',
'81025144883794298401150738933553577901798061699390359873741395050294640426473',
'81325890360476415256204910973705348927617752579887679767167528752182870403247',
'93720852170230838495412316087963880205528478266863139143136161919790509171650',
'96244815880709129195655909435871972476757207260231386236370285577757536126385'
]

`hh add-question --contractaddress 0x5FbDB2315678afecb367f032d93F642f64180aa3 --groupid 113 --question "why are we here?" --eligibleholdertokencontract "0x5FbDB2315678afecb367f032d93F642f64180aa3" --answerthreshold 1 --bountyamount 0 --network arbitrum-goerli`

successful transaction: 0x45c45f764af4316c94bc83f009f87e3b280a7fe6ba6c9f82130a051ab8098564

## Deploying base contracts

deprecated as semaphore already has scripts, see above

`hh deploy-semaphore-pairing --network gnosis-chiado --logs true`
Semaphore pairing contract has been deployed to: 0xEf6d29dDFf75C3aC09C7AA37B3ea58aA2Bb24EB5

`hh deploy-semaphore-base --network gnosis-chiado --pairingcontractaddress 0xEf6d29dDFf75C3aC09C7AA37B3ea58aA2Bb24EB5`
Semaphore verifier contract has been deployed to: 0xB9Fb2370AE80B34CAC5b29CE0B98531A218b9FD0
