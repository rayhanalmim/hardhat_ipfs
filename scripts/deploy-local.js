const { ethers } = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  try {
    // Get the hardhat accounts
    const [deployer] = await ethers.getSigners();
    const deployerBalance = await ethers.provider.getBalance(deployer.address);
    
    console.log("-----------------------------------------------");
    console.log("Deploying DeNews contract with the account:", deployer.address);
    console.log("Account balance:", ethers.formatEther(deployerBalance), "ETH");
    console.log("-----------------------------------------------");

    // Deploy the DeNews contract
    const DeNews = await ethers.getContractFactory("DeNews");
    const denews = await DeNews.deploy();
    await denews.waitForDeployment();

    const address = await denews.getAddress();
    console.log("DeNews contract deployed to:", address);
    console.log("-----------------------------------------------");

    // Add the deployer as an author
    console.log("Adding deployer as an author...");
    const tx = await denews.addAuthor(deployer.address);
    await tx.wait();
    console.log("Deployer added as an author!");

    // Verify if the deployer is now an author
    const isAuthor = await denews.isAuthor(deployer.address);
    console.log(`Deployer author status: ${isAuthor}`);
    console.log("-----------------------------------------------");

    // Save contract address to config file
    const configPath = path.join(__dirname, "../client/src/utils/config.js");
    const configContent = `
export const CONTRACT_ADDRESS = "${address}"; // deployed at ${new Date().toISOString()}
export const ADMIN_ADDRESS = "${deployer.address}"; // account #0 from Hardhat
`;

    fs.writeFileSync(configPath, configContent);
    console.log(`Contract address updated in ${configPath}`);
    
    // Also copy the ABI to the client folder
    require('./copy-abi');
    console.log("ABI copied to client folder");
    console.log("-----------------------------------------------");
    console.log("DEPLOYMENT SUCCESSFUL!");
    
    return address;
  } catch (error) {
    console.error("Deployment failed:", error);
    throw error;
  }
}

main()
  .then((address) => {
    console.log("Contract deployed at:", address);
    process.exit(0);
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 