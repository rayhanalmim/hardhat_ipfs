const { ethers } = require("hardhat");

async function main() {
  // Address to add as an author
  const authorAddress = "0x74fF564b68c1416227a108604bA65f747bDBbEaf"; // Replace with your current address
  
  // Get the DeNews contract
  const DeNews = await ethers.getContractFactory("DeNews");
  const contract = await DeNews.attach("0x5FbDB2315678afecb367f032d93F642f64180aa3");
  
  console.log(`Adding ${authorAddress} as an author...`);
  
  // Add the address as an author
  const tx = await contract.addAuthor(authorAddress);
  await tx.wait();
  
  console.log(`Transaction completed: ${tx.hash}`);
  console.log(`${authorAddress} is now an author!`);
  
  // Verify the author status
  const isAuthor = await contract.isAuthor(authorAddress);
  console.log(`Author status: ${isAuthor}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 