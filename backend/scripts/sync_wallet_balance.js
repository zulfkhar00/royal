const hre = require("hardhat");
require("dotenv").config();

async function main() {
  try {
    // Get the ContractFactory of your SimpleContract
    const BlockchainStorage = await hre.ethers.getContractFactory(
      "BlockchainStorage"
    );

    // Connect to the deployed contract
    const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"; // Replace with your deployed contract address
    const contract = await BlockchainStorage.attach(contractAddress);

    const WALLET_BALANCE_DATA = process.env.WALLET_BALANCE_DATA;
    const [user_id, balance] = WALLET_BALANCE_DATA.split(",");

    await contract.update_wallet(user_id, balance);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

main();
