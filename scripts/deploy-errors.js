const hre = require("hardhat");

async function main() {
  console.log("Deploying Errors contract...");

  // Deploy ErrorTriageExercise
  console.log("Deploying ErrorTriageExercise...");
  const ErrorTriageExercise = await hre.ethers.getContractFactory("ErrorTriageExercise");
  const errorTriageExercise = await ErrorTriageExercise.deploy();
  await errorTriageExercise.waitForDeployment();
  const contractAddress = await errorTriageExercise.getAddress();
  console.log("ErrorTriageExercise deployed to:", contractAddress);

  // Verify ErrorTriageExercise
  console.log("Verifying ErrorTriageExercise contract...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: []
    });
    console.log("ErrorTriageExercise verified successfully");
  } catch (error) {
    console.log("Error verifying ErrorTriageExercise:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 