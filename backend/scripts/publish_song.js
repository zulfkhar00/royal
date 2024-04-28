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

    const PUBLISH_SONG_DATA = process.env.PUBLISH_SONG_DATA;
    const [user_id, coin_id] = PUBLISH_SONG_DATA.split(",");

    await contract.publish_song(user_id, coin_id);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

main();
