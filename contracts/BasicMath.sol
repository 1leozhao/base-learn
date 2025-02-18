// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract BasicMath {
    // Add two numbers and check for overflow
    function adder(uint _a, uint _b) public pure returns (uint sum, bool error) {
        // Using unchecked to handle overflow manually
        unchecked {
            uint result = _a + _b;
            // Check for overflow by comparing with one of the inputs
            if (result < _a || result < _b) {
                return (0, true); // Overflow occurred
            }
            return (result, false); // No overflow
        }
    }

    // Subtract two numbers and check for underflow
    function subtractor(uint _a, uint _b) public pure returns (uint difference, bool error) {
        // Using unchecked to handle underflow manually
        unchecked {
            // Check for underflow by comparing with input
            if (_b > _a) {
                return (0, true); // Underflow would occur
            }
            return (_a - _b, false); // No underflow
        }
    }
} 