const hre = require("hardhat");

async function main() {
  console.log("Deploying Inheritance contracts...");

  // Deploy Salesperson
  console.log("Deploying Salesperson...");
  const Salesperson = await hre.ethers.getContractFactory("Salesperson");
  const salesperson = await Salesperson.deploy(
    55555,      // Id number
    12345,      // Manager Id
    20          // Hourly rate ($20/hour)
  );
  await salesperson.waitForDeployment();
  const salespersonAddress = await salesperson.getAddress();
  console.log("Salesperson deployed to:", salespersonAddress);

  // Deploy EngineeringManager
  console.log("Deploying EngineeringManager...");
  const EngineeringManager = await hre.ethers.getContractFactory("EngineeringManager");
  const engineeringManager = await EngineeringManager.deploy(
    54321,      // Id number
    11111,      // Manager Id
    200000      // Annual salary ($200,000)
  );
  await engineeringManager.waitForDeployment();
  const engineeringManagerAddress = await engineeringManager.getAddress();
  console.log("EngineeringManager deployed to:", engineeringManagerAddress);

  // Deploy InheritanceSubmission
  console.log("Deploying InheritanceSubmission...");
  const InheritanceSubmission = await hre.ethers.getContractFactory("InheritanceSubmission");
  const inheritanceSubmission = await InheritanceSubmission.deploy(
    salespersonAddress,
    engineeringManagerAddress
  );
  await inheritanceSubmission.waitForDeployment();
  const submissionAddress = await inheritanceSubmission.getAddress();
  console.log("InheritanceSubmission deployed to:", submissionAddress);

  // Verify Salesperson
  console.log("Verifying Salesperson contract...");
  try {
    await hre.run("verify:verify", {
      address: salespersonAddress,
      constructorArguments: [55555, 12345, 20],
    });
    console.log("Salesperson verified successfully");
  } catch (error) {
    console.log("Error verifying Salesperson:", error.message);
  }

  // Verify EngineeringManager
  console.log("Verifying EngineeringManager contract...");
  try {
    await hre.run("verify:verify", {
      address: engineeringManagerAddress,
      constructorArguments: [54321, 11111, 200000],
    });
    console.log("EngineeringManager verified successfully");
  } catch (error) {
    console.log("Error verifying EngineeringManager:", error.message);
  }

  // Verify InheritanceSubmission
  console.log("Verifying InheritanceSubmission contract...");
  try {
    await hre.run("verify:verify", {
      address: submissionAddress,
      constructorArguments: [salespersonAddress, engineeringManagerAddress],
    });
    console.log("InheritanceSubmission verified successfully");
  } catch (error) {
    console.log("Error verifying InheritanceSubmission:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 