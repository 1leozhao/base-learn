// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract ErrorTriageExercise {
    /**
     * Finds the difference between each uint with it's neighbor (a to b, b to c, etc.)
     * and returns a uint array with the absolute integer difference of each pairing.
     */
    function diffWithNeighbor(
        uint _a,
        uint _b,
        uint _c,
        uint _d
    ) public pure returns (uint[] memory) {
        uint[] memory results = new uint[](3);

        // Use absolute difference to avoid underflow
        results[0] = _a > _b ? _a - _b : _b - _a;
        results[1] = _b > _c ? _b - _c : _c - _b;
        results[2] = _c > _d ? _c - _d : _d - _c;

        return results;
    }

    /**
     * Changes the _base by the value of _modifier.  Base is always >= 1000.  Modifiers can be
     * between positive and negative 100;
     */
    function applyModifier(
        uint _base,
        int _modifier
    ) public pure returns (uint) {
        // Check base requirement
        require(_base >= 1000, "Base must be >= 1000");
        
        // Check modifier range
        require(_modifier >= -100 && _modifier <= 100, "Modifier must be between -100 and 100");

        // Handle negative modifiers
        if (_modifier < 0) {
            return _base - uint(-_modifier);
        }
        
        return _base + uint(_modifier);
    }

    /**
     * Pop the last element from the supplied array, and return the popped
     * value (unlike the built-in function)
     */
    uint[] arr;

    function popWithReturn() public returns (uint) {
        // Check if array is not empty
        require(arr.length > 0, "Array is empty");

        // Store the last value before popping
        uint lastValue = arr[arr.length - 1];
        
        // Remove the last element
        arr.pop();
        
        return lastValue;
    }

    // The utility functions below are working as expected
    function addToArr(uint _num) public {
        arr.push(_num);
    }

    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function resetArr() public {
        delete arr;
    }
} 