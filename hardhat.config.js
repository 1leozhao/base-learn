require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.20"
      },
      {
        version: "0.8.19"
      }
    ]
  },
  networks: {
    "base-sepolia": {
      url: process.env.SEPOLIA_RPC_URL || "https://sepolia.base.org",
      accounts: [process.env.PRIVATE_KEY || ""],
      chainId: 84532
    }
  },
  etherscan: {
    apiKey: {
      "base-sepolia": process.env.ETHERSCAN_API_KEY || ""
    },
    customChains: [
      {
        network: "base-sepolia",
        chainId: 84532,
        urls: {
          apiURL: "https://api-sepolia.basescan.org/api",
          browserURL: "https://sepolia.basescan.org"
        }
      }
    ]
  }
};
