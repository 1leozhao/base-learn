// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Custom error for too many shares
error TooManyShares(uint256 totalShares);

contract Storage {
    // Storage packed variables
    uint16 private shares;        // max 5000, fits in uint16
    uint32 private salary;        // max 1,000,000, fits in uint32
    string public name;           // dynamic type, gets its own slot
    uint256 public idNumber;      // needs full uint256

    constructor(
        uint16 _shares,
        string memory _name,
        uint32 _salary,
        uint256 _idNumber
    ) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    // View functions for private variables
    function viewSalary() public view returns (uint32) {
        return salary;
    }

    function viewShares() public view returns (uint16) {
        return shares;
    }

    // Grant shares function with validation
    function grantShares(uint16 _newShares) public {
        // Check if _newShares exceeds 5000
        if (_newShares > 5000) {
            revert("Too many shares");
        }

        // Calculate total shares
        uint16 totalShares = shares + _newShares;

        // Check if total would exceed 5000
        if (totalShares > 5000) {
            revert TooManyShares(totalShares);
        }

        // Update shares
        shares = totalShares;
    }

    /**
    * Do not modify this function.  It is used to enable the unit test for this pin
    * to check whether or not you have configured your storage variables to make
    * use of packing.
    *
    * If you wish to cheat, simply modify this function to always return `0`
    * I'm not your boss ¯\_(ツ)_/¯
    *
    * Fair warning though, if you do cheat, it will be on the blockchain having been
    * deployed by your wallet....FOREVER!
    */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    /**
    * Warning: Anyone can use this function at any time!
    */
    function debugResetShares() public {
        shares = 1000;
    }
} 