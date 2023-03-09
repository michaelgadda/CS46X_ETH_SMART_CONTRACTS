require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: "https://goerli.infura.io/v3/301f6dde56fe4ab0ad1a1558e9dc6459",
      accounts: ["e57626b3104828d417280664a462990e3950ec2d5af160d9fa3ad9c2a54fc708"],
    },
  },
};
