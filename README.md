# DeNews DApp

DeNews is a decentralized news publishing platform that allows users to publish and view articles stored on IPFS and managed through a smart contract on the blockchain.

## Features

- Publish articles using local IPFS node
- Access control with public and restricted article permissions
- Admin panel for author management
- User view for browsing published articles

## Prerequisites

- Node.js and npm
- Local IPFS node (see setup instructions below)
- MetaMask browser extension
- Hardhat for local blockchain development

## IPFS Setup

This application uses a local IPFS node for storing and retrieving article content. Follow these steps to set up your local IPFS node:

### Option 1: IPFS Desktop (Recommended for beginners)

1. Download and install IPFS Desktop from the [official website](https://docs.ipfs.tech/install/ipfs-desktop/)
2. Launch IPFS Desktop
3. Verify that the IPFS API is available at http://localhost:5001
4. Verify that the IPFS Gateway is available at http://localhost:8080

### Option 2: IPFS Command Line

1. Install IPFS CLI:
   ```bash
   npm install -g ipfs
   ```

2. Initialize IPFS:
   ```bash
   ipfs init
   ```

3. Start the IPFS daemon:
   ```bash
   ipfs daemon
   ```

4. Verify that the IPFS API and Gateway are running (the daemon output should show this information)

## Project Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd DeNewsApp
   ```

2. Install dependencies:
   ```bash
   npm install
   cd client
   npm install
   ```

3. Start your local IPFS node (see instructions above)

4. Start the development blockchain:
   ```bash
   npx hardhat node
   ```

5. In a new terminal, deploy the smart contract:
   ```bash
   npx hardhat run scripts/deploy.js --network localhost
   ```

6. Start the React client:
   ```bash
   cd client
   npm start
   ```

7. Open your browser and navigate to http://localhost:3000

## Using the DApp

1. Connect your MetaMask wallet (make sure it's configured to use your local hardhat network)
2. Navigate to the appropriate panel based on your role:
   - Author Panel: For publishing new articles
   - Admin Panel: For managing authors
   - User View: For browsing published articles

### Publishing an Article

1. Go to the Author Panel
2. Enter the article title
3. Write or paste the article content
4. Select the access level (Public or Restricted)
5. Click "Publish"
6. Approve the transaction in MetaMask

### Viewing Articles

1. Go to the User View
2. Browse the list of published articles
3. Click "Show Content" to view an article's content from IPFS
4. Click "View Raw on IPFS" to open the content directly in the IPFS gateway

## Troubleshooting

- If you see an error about IPFS not being connected, make sure your local IPFS daemon is running
- The application shows an IPFS setup guide if a connection to the local IPFS node cannot be established
- Check the browser console for detailed error messages

## License

MIT
