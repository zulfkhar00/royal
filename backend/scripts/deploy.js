const { ethers, run, network } = require("hardhat");

async function main() {
  const BlockchainStorageFactory = await ethers.getContractFactory(
    "BlockchainStorage"
  );
  console.log("Deploying contract...");
  const blockchainStorage = await BlockchainStorageFactory.deploy();
  await blockchainStorage.waitForDeployment();
  console.log(`Deployed contract to ${await blockchainStorage.getAddress()}`);

  if (network.config.chainId === 11155111 && process.env.ETHERSCAN_API_KEY) {
    await blockchainStorage.deploymentTransaction().wait(6);
    await verify(await blockchainStorage.getAddress(), []);
  }
}

async function verify(contractAddress, args) {
  console.log("Verifying contract...");
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    });
  } catch (e) {
    if (e.message.toLowerCase().includes("already verified")) {
      console.log("Already verified!");
    } else {
      console.log(e);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((e) => {
    console.log(e);
    process.exit(1);
  });
