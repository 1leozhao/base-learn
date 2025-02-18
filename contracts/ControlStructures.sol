// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Custom error for after hours
error AfterHours(uint time);

contract ControlStructures {
    // FizzBuzz implementation
    function fizzBuzz(uint _number) public pure returns (string memory) {
        bool divisibleBy3 = _number % 3 == 0;
        bool divisibleBy5 = _number % 5 == 0;

        if (divisibleBy3 && divisibleBy5) {
            return "FizzBuzz";
        } else if (divisibleBy3) {
            return "Fizz";
        } else if (divisibleBy5) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }

    // Time-based control function
    function doNotDisturb(uint _time) public pure returns (string memory) {
        // Check for time overflow using assert
        assert(_time < 2400);

        // Check for after hours
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }

        // Check for lunch time
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }

        // Return appropriate time of day message
        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        } else if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        } else {
            return "Evening!";
        }
    }
} 