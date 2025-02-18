const hre = require("hardhat");

async function main() {
  console.log("Deploying BasicMath contract...");

  // Get the contract factory
  const BasicMath = await hre.ethers.getContractFactory("BasicMath");
  
  // Deploy the contract
  const basicMath = await BasicMath.deploy();

  // Wait for deployment to complete
  await basicMath.waitForDeployment();

  const deployedAddress = await basicMath.getAddress();
  console.log("BasicMath deployed to:", deployedAddress);

  // Wait for a few block confirmations
  console.log("Waiting for block confirmations...");
  try {
    await basicMath.deployTransaction.wait(6);
  } catch (error) {
    console.log("Note: Waiting for block confirmations not supported on this network");
  }

  // Verify the contract on Etherscan
  console.log("Verifying contract on Etherscan...");
  try {
    await hre.run("verify:verify", {
      address: deployedAddress,
      constructorArguments: [],
    });
    console.log("Contract verified successfully");
  } catch (error) {
    console.log("Error verifying contract:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 