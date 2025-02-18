const hre = require("hardhat");

async function main() {
  console.log("Deploying ERC-20 contract...");

  // Deploy WeightedVoting
  const WeightedVoting = await hre.ethers.getContractFactory("WeightedVoting");
  const weightedVoting = await WeightedVoting.deploy();
  await weightedVoting.waitForDeployment();
  const contractAddress = await weightedVoting.getAddress();
  console.log("ERC-20 deployed to:", contractAddress);

  // Verify contract
  console.log("Verifying ERC-20 contract...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: [],
      contract: "contracts/ERC-20.sol:WeightedVoting"
    });
    console.log("ERC-20 contract verified successfully");
  } catch (error) {
    console.log("Error verifying ERC-20 contract:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 