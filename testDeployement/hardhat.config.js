require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/NEJmZb339yhS3kS8CzOT_YhkzxaSZgtz",
      accounts: ['e57626b3104828d417280664a462990e3950ec2d5af160d9fa3ad9c2a54fc708'],
    },
  },
};
