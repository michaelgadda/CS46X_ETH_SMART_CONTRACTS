Project Contracts in: `packages/hardhat/contracts`

`packages/hardhat/contracts/Lock.sol` (Hardhat Sample)
`packages/hardhat/contracts/lenders.sol`
`packages/hardhat/contracts/tollBasedInfrastructure.sol`
`packages/hardhat/contracts/Staker.sol`
`packages/hardhat/contracts/ExampleExternalContract.sol` (REMOVE AFTER SUCCESSFUL TESTING: STAKER > LENDERS)
`packages/hardhat/node_modules/@openzeppelin/contracts` (openzeppelin library of financial helper contracts)

```
yarn install
yarn chain   (hardhat backend)
yarn deploy  (to compile, deploy, and publish your contracts to the frontend)
yarn start   (react app frontend)
```

* View frontend at http://localhost:3000/
* Rerun `yarn deploy --reset` to deploy new contracts to the frontend.