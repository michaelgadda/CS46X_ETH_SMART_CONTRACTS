const hre = require("hardhat");

async function main() {
  const Lending = await hre.ethers.getContractFactory("Lending");
  const lending = await Lending.deploy();

  await lending.deployed();

  console.log(`Lending contract deployed at: ${lending.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });