const hre = require("hardhat");

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const lockedAmount = hre.ethers.utils.parseEther("0");

  const Lending = await hre.ethers.getContractFactory("Lending");
  const lending = await Lending.deploy();

  await lending.deployed();

  console.log(`Lending contract deployed at: ${lending.address}`);

  const lenderAddress = "0xd365aB13F5F2Dd9dcFEd5BC9394300Cd21AEB187";
  const lendeeAddress = "0xC47e9E1b6024e45d8495dc8E48486008b150Bbc1";
  const loanAmount = hre.ethers.utils.parseEther("0.00000001");
  const cl = await lending.createLoan(lendeeAddress, lenderAddress, loanAmount, 5, 20, 5);
  const tx = await lending.lendLoan();
  /*const tx = await lending.lendLoan(); /*lendeeAddress, loanAmount, {
    from: lenderAddress,
    gasPrice: hre.ethers.utils.parseUnits("20", "gwei"),
    gasLimit: 1000000,
  });*/

  console.log(`Loan transaction mined with hash: ${tx.hash}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });