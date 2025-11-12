# Counter Smart Contract

## Overview
This is a simple Solidity smart contract that implements a counter with basic operations: increment, decrement, reset, and read. The contract demonstrates fundamental blockchain concepts including state management, visibility modifiers, and gas optimization.

## Author
Zenmisan

## Contract Details

### Features
- **Increment**: Increases the counter value by 1
- **Decrement**: Decreases the counter value by 1 (with underflow protection)
- **Reset**: Sets the counter back to 0
- **Read**: Retrieves the current counter value (gas-free when called externally)

### Technical Specifications
- **Solidity Version**: ^0.8.0
- **License**: MIT
- **State Variables**: 1 (uint256 private counterValue)
- **Functions**: 5 (4 state-changing, 2 view functions)

## Installation & Deployment

### Prerequisites
- Access to [Remix IDE](https://remix.ethereum.org)
- Basic understanding of Solidity
- MetaMask wallet (optional, for testnet deployment)

### Deployment Steps

1. **Open Remix IDE**
   - Navigate to https://remix.ethereum.org

2. **Create Contract File**
   - In File Explorer, create a new file named `Counter.sol`
   - Copy and paste the contract code

3. **Compile**
   - Go to Solidity Compiler tab
   - Select compiler version 0.8.0 or higher
   - Click "Compile Counter.sol"
   - Verify green checkmark appears

4. **Deploy**
   - Go to Deploy & Run Transactions tab
   - Select "Remix VM (Shanghai)" for testing
   - Click "Deploy"
   - Contract will appear under "Deployed Contracts"

## Usage

### Function Descriptions

#### `increment()`
```solidity
function increment() external returns (uint256)
```
- **Purpose**: Adds 1 to the counter
- **Returns**: New counter value
- **Gas Cost**: ~26,000-43,000 gas (varies based on storage state)
- **Example**: Call this function to increase counter from 5 to 6

#### `decrement()`
```solidity
function decrement() external returns (uint256)
```
- **Purpose**: Subtracts 1 from the counter
- **Returns**: New counter value
- **Reverts**: If counter is already 0
- **Gas Cost**: ~26,000-43,000 gas
- **Example**: Call this function to decrease counter from 6 to 5

#### `reset()`
```solidity
function reset() external
```
- **Purpose**: Resets counter to 0
- **Returns**: Nothing
- **Gas Cost**: ~21,000-28,000 gas (includes gas refund if clearing non-zero value)
- **Example**: Use this to start counting from scratch

#### `getCount()`
```solidity
function getCount() external view returns (uint256)
```
- **Purpose**: Returns current counter value
- **Returns**: Current counter value
- **Gas Cost**: 0 gas (when called off-chain), ~2,100 gas (when called from another contract)
- **Example**: Check counter value without modifying state

#### `readCounter()`
```solidity
function readCounter() external view returns (uint256)
```
- **Purpose**: Alternative method to read counter value
- **Returns**: Current counter value
- **Gas Cost**: Same as getCount()
- **Example**: Demonstrates multiple ways to access the same data

## Gas Cost Analysis

### Summary Table
| Function | First Call (Cold) | Subsequent Calls (Warm) | Notes |
|----------|-------------------|-------------------------|-------|
| increment() | ~43,000 gas | ~26,000 gas | Includes base tx + storage write |
| decrement() | ~43,000 gas | ~26,000 gas | Similar to increment |
| reset() | ~28,000 gas | ~28,000 gas | May receive ~15,000 gas refund |
| getCount() | 0 gas | 0 gas | Free when called externally |
| readCounter() | 0 gas | 0 gas | Free when called externally |

### Gas Cost Breakdown
- **Base Transaction Cost**: ~21,000 gas (fixed for all transactions)
- **Storage Write**: ~5,000-20,000 gas (depends on operation)
- **Cold Storage Access**: ~17,000 gas (first access in a transaction)
- **Warm Storage Access**: Significantly cheaper after first access

### Gas Refund Mechanism
When `reset()` sets a non-zero value to zero, Ethereum provides a gas refund of approximately 15,000 gas. This incentivizes clearing unused storage.

## Testing Scenarios

### Test Case 1: Basic Increment
1. Deploy contract (counter = 0)
2. Call `getCount()` → Returns 0
3. Call `increment()` → Returns 1
4. Call `getCount()` → Returns 1

### Test Case 2: Multiple Operations
1. Call `increment()` 3 times → Counter = 3
2. Call `decrement()` once → Counter = 2
3. Call `reset()` → Counter = 0

### Test Case 3: Underflow Protection
1. Deploy contract (counter = 0)
2. Call `decrement()` → Should revert with error "Cannot go below zero"
3. Counter remains at 0

## Security Considerations

### Built-in Protection
- **Overflow/Underflow**: Solidity 0.8+ automatically prevents overflow and underflow
- **Access Control**: Private state variable prevents direct external modification
- **Input Validation**: `require` statement in decrement prevents underflow

### Potential Improvements
- Add access control (only owner can modify)
- Emit events for state changes
- Add pause/unpause functionality
- Implement counter limits (maximum value)

## Learning Outcomes

This contract demonstrates:
1. **State Variables**: How to store data on the blockchain
2. **Visibility Modifiers**: `private` for state, `external` for functions, `view` for read-only
3. **Gas Optimization**: Understanding cold vs warm storage access
4. **Error Handling**: Using `require` for input validation
5. **Return Values**: Functions that modify state can also return values

## Resources

- [Solidity Documentation](https://docs.soliditylang.org/)
- [Remix IDE Documentation](https://remix-ide.readthedocs.io/)
- [Ethereum Gas Explained](https://ethereum.org/en/developers/docs/gas/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

## License
This project is licensed under the MIT License - see the SPDX identifier in the contract for details.

## Acknowledgments
- Created as part of [Course Name] assignment
- Tested on Remix IDE
- Gas costs measured on Remix VM (Shanghai)

---

**Note**: This is an educational project. Gas costs may vary on mainnet or different testnets. Always test thoroughly before deploying to production.
