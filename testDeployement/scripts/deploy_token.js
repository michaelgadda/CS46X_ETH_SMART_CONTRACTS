const hre = require("hardhat");

async function main() {
  const InfToken = await hre.ethers.getContractFactory("INFToken");
  const infToken = await InfToken.deploy(100000000, 1000000000);

  await infToken.deployed();

  console.log("INF Token deployed: ", infToken.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});