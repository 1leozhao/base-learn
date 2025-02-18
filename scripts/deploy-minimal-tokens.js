const hre = require("hardhat");

async function main() {
  console.log("Deploying MinimalTokens contract...");

  // Deploy UnburnableToken
  const UnburnableToken = await hre.ethers.getContractFactory("UnburnableToken");
  const unburnableToken = await UnburnableToken.deploy();
  await unburnableToken.waitForDeployment();
  const contractAddress = await unburnableToken.getAddress();
  console.log("MinimalTokens deployed to:", contractAddress);

  // Verify contract
  console.log("Verifying MinimalTokens contract...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: []
    });
    console.log("MinimalTokens contract verified successfully");
  } catch (error) {
    console.log("Error verifying MinimalTokens contract:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 