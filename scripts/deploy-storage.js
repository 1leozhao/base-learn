const hre = require("hardhat");

async function main() {
  console.log("Deploying Storage contract...");

  // Get the contract factory
  const Storage = await hre.ethers.getContractFactory("Storage");
  
  // Deploy the contract with initial values
  const storage = await Storage.deploy(
    1000,               // shares
    "Pat",              // name
    50000,             // salary
    "112358132134"     // idNumber (as string to handle large number)
  );

  // Wait for deployment to complete
  await storage.waitForDeployment();

  const deployedAddress = await storage.getAddress();
  console.log("Storage deployed to:", deployedAddress);

  // Wait for a few block confirmations
  console.log("Waiting for block confirmations...");
  try {
    await storage.deployTransaction.wait(6);
  } catch (error) {
    console.log("Note: Waiting for block confirmations not supported on this network");
  }

  // Verify the contract on Etherscan
  console.log("Verifying contract on Etherscan...");
  try {
    await hre.run("verify:verify", {
      address: deployedAddress,
      constructorArguments: [
        1000,               // shares
        "Pat",              // name
        50000,             // salary
        "112358132134"     // idNumber
      ],
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