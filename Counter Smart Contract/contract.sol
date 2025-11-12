// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Counter
 * @author Zenmisan
 * @notice This contract implements a simple counter with basic operations
 */
contract Counter {
    
    // State variable storing the counter value
    uint256 private counterValue;
    
    /**
     * @notice Adds one to the counter
     * @return The new counter value after incrementing
     * 
     * Gas Cost Analysis:
     * - First increment (cold storage): ~43,000 gas
     * - Subsequent increments (warm storage): ~26,000 gas
     * - Breakdown: 21,000 base + ~5,000 storage update + ~17,000 cold access
     */
    function increment() external returns (uint256) {
        counterValue = counterValue + 1;
        return counterValue;
    }
    
    /**
     * @notice Subtracts one from the counter
     * @return The new counter value after decrementing
     * @dev Will revert if counter is already at zero (Solidity 0.8+ underflow protection)
     * 
     * Gas Cost Analysis:
     * - Similar to increment: ~26,000-43,000 gas depending on storage state
     * - Additional gas if require check fails: ~23,000 gas (then reverts)
     */
    function decrement() external returns (uint256) {
        require(counterValue > 0, "Cannot go below zero");
        counterValue = counterValue - 1;
        return counterValue;
    }
    
    /**
     * @notice Sets the counter back to zero
     * 
     * Gas Cost Analysis:
     * - Cost: ~21,000-28,000 gas
     * - Gas refund of ~15,000 when clearing storage (setting non-zero to zero)
     * - Net cost can be lower due to refund mechanism
     */
    function reset() external {
        counterValue = 0;
    }
    
    /**
     * @notice Retrieves the current counter value
     * @return The current value stored in the counter
     * 
     * Gas Cost Analysis:
     * - External call (wallet/dApp): 0 gas (view functions are free off-chain)
     * - Internal call (from another function): ~2,100 gas
     */
    function getCount() external view returns (uint256) {
        return counterValue;
    }
    
    /**
     * @notice Alternative getter using Solidity's implicit getter
     * @dev Could also make counterValue public instead of having this function
     */
    function readCounter() external view returns (uint256) {
        return counterValue;
    }
}