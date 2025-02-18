const hre = require("hardhat");

async function main() {
  console.log("Deploying ERC-721 contract...");

  // Deploy HaikuNFT
  const HaikuNFT = await hre.ethers.getContractFactory("HaikuNFT");
  const haikuNFT = await HaikuNFT.deploy();
  await haikuNFT.waitForDeployment();
  const contractAddress = await haikuNFT.getAddress();
  console.log("ERC-721 deployed to:", contractAddress);

  // Verify contract
  console.log("Verifying ERC-721 contract...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: [],
      contract: "contracts/ERC-721.sol:HaikuNFT"
    });
    console.log("ERC-721 contract verified successfully");
  } catch (error) {
    console.log("Error verifying ERC-721 contract:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 