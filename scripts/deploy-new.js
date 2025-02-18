const hre = require("hardhat");

async function main() {
  console.log("Deploying New contract...");

  // Deploy AddressBookFactory
  const New = await hre.ethers.getContractFactory("AddressBookFactory");
  const newContract = await New.deploy();
  await newContract.waitForDeployment();
  const contractAddress = await newContract.getAddress();
  console.log("New deployed to:", contractAddress);

  // Verify New contract
  console.log("Verifying New contract...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: []
    });
    console.log("New contract verified successfully");
  } catch (error) {
    console.log("Error verifying New contract:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 