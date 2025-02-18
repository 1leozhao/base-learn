const hre = require("hardhat");

async function main() {
  console.log("Deploying Structs contract...");

  // Get the contract factory
  const Structs = await hre.ethers.getContractFactory("GarageManager");
  
  // Deploy the contract
  const structs = await Structs.deploy();

  // Wait for deployment to complete
  await structs.waitForDeployment();

  const deployedAddress = await structs.getAddress();
  console.log("Structs deployed to:", deployedAddress);

  // Wait for a few block confirmations
  console.log("Waiting for block confirmations...");
  try {
    await structs.deployTransaction.wait(6);
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