# Semaphore Hardhat + Next.js + SemaphoreEthers template

Working from [contracts folder](./apps/contracts/).

# Sharknado_ethRome

We were using the [semaphore repo](https://github.com/semaphore-protocol/semaphore/blob/main/packages/contracts/tasks/deploy-semaphore.ts) to deploy to the gnosis testnet.

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

Sharknado contract has been deployed to: 0x10d7526150f4134d9B6631c8C4A6d812a91dFfA7

### NFT Contract

0xf649cb1884dcf8bac5ccfa669083c489288685bb

### Adding Questions

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
