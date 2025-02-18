# Base Learning Project

This repository contains a collection of smart contracts and scripts for learning Base, a secure, low-cost, developer-friendly Ethereum L2 built to bring the next billion users onchain. The project uses Hardhat as the development environment.

## Project Structure

- `contracts/`: Contains various Solidity smart contracts including:
  - ERC-20 and ERC-721 token implementations
  - Basic storage and struct examples
  - Inheritance demonstrations
  - Error handling examples
  - Minimal token implementations
  
- `scripts/`: Contains deployment scripts for each contract
- `test/`: Contains test files
- `ignition/`: Contains Hardhat Ignition deployment modules

## Getting Started

1. Clone the repository:
```shell
git clone https://github.com/1leozhao/base-learn.git
cd base-learn
```

2. Install dependencies:
```shell
npm install
```

3. Create a `.env` file with your configuration:
```shell
cp .env.example .env
# Edit .env with your values
```

4. Try running some of the following tasks:
```shell
npx hardhat help
npx hardhat test
npx hardhat node
```

## Deployment Scripts

The repository includes various deployment scripts for different contract types:
- `deploy-ERC-20.js`: Deploy ERC-20 token contracts
- `deploy-ERC-721.js`: Deploy ERC-721 NFT contracts
- `deploy-arrays.js`: Deploy array example contracts
- `deploy-structs.js`: Deploy struct example contracts
- And more...

## Contributing

Feel free to submit issues and enhancement requests!
