# Check if node_modules exists in the root directory
if (-not (Test-Path -Path "node_modules")) {
    Write-Host "Installing project dependencies..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to install dependencies. Exiting..." -ForegroundColor Red
        exit 1
    }
}

# Check if node_modules exists in the client directory
if (-not (Test-Path -Path "client/node_modules")) {
    Write-Host "Installing client dependencies..." -ForegroundColor Yellow
    cd client
    npm install
    cd ..
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to install client dependencies. Exiting..." -ForegroundColor Red
        exit 1
    }
}

# Compile the contracts first
Write-Host "Compiling smart contracts..." -ForegroundColor Cyan
npx hardhat compile
if ($LASTEXITCODE -ne 0) {
    Write-Host "Contract compilation failed. Exiting..." -ForegroundColor Red
    exit 1
}

# Start a new PowerShell window for running the Hardhat node
Write-Host "Starting Hardhat node in a separate window..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit -Command cd '$PSScriptRoot'; npx hardhat node"

# Wait for the node to start
Write-Host "Waiting for Hardhat node to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Deploy the contract
Write-Host "Deploying contract to local network..." -ForegroundColor Cyan
npx hardhat run scripts/deploy-local.js --network localhost

# Check if deployment was successful
if ($LASTEXITCODE -ne 0) {
    Write-Host "Contract deployment failed. Exiting..." -ForegroundColor Red
    exit 1
}

Write-Host "Contract deployed successfully!" -ForegroundColor Green

# Change to client directory and start the React app
Write-Host "Starting React app..." -ForegroundColor Cyan
cd client
npm start 