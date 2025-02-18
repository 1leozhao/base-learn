const hre = require("hardhat");

async function main() {
  console.log("Deploying Imports contract...");

  // Deploy ImportsExercise
  console.log("Deploying ImportsExercise...");
  const ImportsExercise = await hre.ethers.getContractFactory("contracts/imports/Imports.sol:ImportsExercise");
  const importsExercise = await ImportsExercise.deploy();
  await importsExercise.waitForDeployment();
  const contractAddress = await importsExercise.getAddress();
  console.log("ImportsExercise deployed to:", contractAddress);

  // Verify ImportsExercise
  console.log("Verifying ImportsExercise contract...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: [],
      contract: "contracts/imports/Imports.sol:ImportsExercise"
    });
    console.log("ImportsExercise verified successfully");
  } catch (error) {
    console.log("Error verifying ImportsExercise:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 