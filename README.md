# Solidity Smart Contracts

A collection of optimized Solidity smart contracts for decentralized applications. Each contract is located inside the `contracts/` folder and includes comprehensive documentation and security best practices.

## Project Overview

This repository contains six production-ready smart contracts covering various use cases in decentralized applications, from basic token functionality to complex voting systems and crowdfunding platforms.

## List of Contracts

| # | Contract Name | Description |
|---|---------------|-------------|
| 1 | `basic_erc_20_token.sol` | ERC20-compatible token implementation with mint, burn, transfer, and approval functionality |
| 2 | `voting_system.sol` | Decentralized voting system with admin-controlled candidate management and secure voting mechanism |
| 3 | `deccentralized_notes_app.sol` | Decentralized notes storage application with create, update, delete, and retrieval functionality |
| 4 | `ether_piggy_bank.sol` | Secure Ether storage contract with owner-only withdrawal and transfer capabilities |
| 5 | `todo.sol` | Personal to-do list manager with per-wallet task management |
| 6 | `crowfunding_platform.sol` | Crowdfunding platform with campaign creation, donations, refunds, and payout mechanisms |

## Contract Details

### Basic ERC20 Token

A complete ERC20 token implementation featuring:
- Token transfers with zero address validation
- Approval and transferFrom functionality
- Mint and burn capabilities
- Comprehensive event logging
- Input validation and security checks

### Voting System

A secure voting platform with:
- Admin-controlled candidate management
- Voting start/end controls
- One vote per address enforcement
- Winner determination functionality
- Constructor-based admin initialization

### Decentralized Notes App

A blockchain-based notes application offering:
- Per-address note storage
- Create, update, and soft-delete functionality
- Timestamp tracking for each note
- Efficient retrieval of active notes only

### Ether Piggy Bank

A secure Ether storage contract providing:
- Owner-only access control
- Deposit and withdrawal functionality
- Transfer funds to other addresses
- Balance querying
- Secure transfer mechanisms using call pattern

### Todo App

A decentralized task management system with:
- Per-address task storage
- Add, update, and mark as completed functionality
- Event logging for all operations
- Input validation

### Crowdfunding Platform

A comprehensive crowdfunding solution featuring:
- Campaign creation with goals and deadlines
- Donation functionality
- Automatic refunds if goals are not met
- Payout to creators when goals are reached
- Secure fund handling with reentrancy protection

## How to Use

### Using Remix IDE

1. Open Remix IDE in your browser
2. Create a new file or upload the contract files from the `contracts/` folder
3. Select the Solidity compiler version 0.8.13 or higher
4. Compile the contract using the Solidity compiler
5. Deploy using JavaScript VM, Injected Web3, or a local development network
6. Interact with deployed contracts via the Remix interface

### Using Hardhat or Truffle

1. Install dependencies: `npm install`
2. Configure your network settings in the configuration file
3. Compile contracts: `npx hardhat compile` or `truffle compile`
4. Deploy to your network: `npx hardhat deploy` or `truffle migrate`
5. Interact with contracts using scripts or tests

## Tools and Technologies

- Solidity version 0.8.13 or higher
- Remix IDE for development and testing
- MetaMask for Web3 wallet integration
- Hardhat or Truffle for advanced development workflows

## Security Features

All contracts include:
- Input validation and zero address checks
- Access control modifiers
- Reentrancy protection where applicable
- Safe transfer patterns using call instead of transfer
- Comprehensive error messages
- Event logging for transparency

## Optimization Improvements

The contracts have been optimized with:
- Fixed logic errors and typos
- Added proper access controls
- Implemented secure transfer patterns
- Added input validation
- Improved gas efficiency
- Enhanced security checks

## Learning Objectives

This project demonstrates:
- Basic and advanced Solidity syntax
- Access control patterns with modifiers
- Mapping and struct usage
- Event emission for transparency
- Secure fund handling
- Input validation best practices
- Reentrancy protection
- ERC20 token standard implementation

## Development Notes

- All contracts use Solidity 0.8.13 or higher
- Contracts follow security best practices
- Events are emitted for all state-changing operations
- Zero address checks are implemented where applicable
- Access control is enforced through modifiers

## License

MIT License - See individual contract headers for license information
