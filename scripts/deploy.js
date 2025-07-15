const hre = require("hardhat");

async function main() {
  const DeNews = await hre.ethers.getContractFactory("DeNews");
  const deNews = await DeNews.deploy();

  // ✅ Wait for the contract to be deployed
  await deNews.waitForDeployment();

  console.log("✅ DeNews contract deployed to:", await deNews.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
