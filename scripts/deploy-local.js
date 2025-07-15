const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // Deploy the DeNews contract
  const DeNews = await ethers.getContractFactory("DeNews");
  const denews = await DeNews.deploy();
  await denews.waitForDeployment();

  const address = await denews.getAddress();
  console.log("DeNews contract deployed to:", address);

  // Add the deployer as an author
  console.log("Adding deployer as an author...");
  const tx = await denews.addAuthor(deployer.address);
  await tx.wait();
  console.log("Deployer added as an author!");

  // Verify if the deployer is now an author
  const isAuthor = await denews.isAuthor(deployer.address);
  console.log(`Deployer author status: ${isAuthor}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 