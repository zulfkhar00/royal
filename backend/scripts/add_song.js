const hre = require("hardhat");

async function main() {
  try {
    // Get the ContractFactory of your SimpleContract
    const BlockchainStorage = await hre.ethers.getContractFactory(
      "BlockchainStorage"
    );

    // Connect to the deployed contract
    const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"; // Replace with your deployed contract address
    const contract = await BlockchainStorage.attach(contractAddress);

    // Set a new message in the contract
    await contract.store(7);

    // Retrieve the updated message
    const updatedMessage = await contract.retrieve();
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

main();
