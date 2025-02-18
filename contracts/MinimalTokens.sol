// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Custom errors
error TokensClaimed();
error AllTokensClaimed();
error UnsafeTransfer(address to);

contract UnburnableToken {
    // State variables
    mapping(address => uint) public balances;
    uint public totalSupply;
    uint public totalClaimed;
    
    // Track who has claimed
    mapping(address => bool) private hasClaimed;
    
    // Constants
    uint constant CLAIM_AMOUNT = 1000;  // Each wallet can claim 1000 tokens

    constructor() {
        totalSupply = 100_000_000;  // 100 million tokens
        totalClaimed = 0;
    }

    // Claim tokens
    function claim() public {
        // Check if sender has already claimed
        if (hasClaimed[msg.sender]) {
            revert TokensClaimed();
        }

        // Check if all tokens have been claimed
        if (totalClaimed + CLAIM_AMOUNT > totalSupply) {
            revert AllTokensClaimed();
        }

        // Mark as claimed and update balances
        hasClaimed[msg.sender] = true;
        balances[msg.sender] += CLAIM_AMOUNT;
        totalClaimed += CLAIM_AMOUNT;
    }

    // Safe transfer function
    function safeTransfer(address _to, uint _amount) public {
        // Check for zero address
        if (_to == address(0)) {
            revert UnsafeTransfer(_to);
        }

        // Check recipient's ETH balance
        if (_to.balance == 0) {
            revert UnsafeTransfer(_to);
        }

        // Check sender's token balance
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Perform transfer
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
} 