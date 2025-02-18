// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Arrays {
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];
    address[] public senders;
    uint[] public timestamps;

    // Return the entire numbers array
    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    // Reset numbers array to initial values (1-10)
    function resetNumbers() public {
        delete numbers;
        numbers = [1,2,3,4,5,6,7,8,9,10];
    }

    // Append array to existing numbers array
    function appendToNumbers(uint[] calldata _toAppend) public {
        for(uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    // Save timestamp and sender address
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    // Filter timestamps after Y2K and return corresponding senders
    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint count = 0;
        
        // Count valid timestamps first
        for(uint i = 0; i < timestamps.length; i++) {
            if(timestamps[i] > 946702800) {
                count++;
            }
        }

        // Create arrays of the correct size
        uint[] memory filteredTimestamps = new uint[](count);
        address[] memory filteredSenders = new address[](count);
        
        // Fill the arrays
        uint currentIndex = 0;
        for(uint i = 0; i < timestamps.length; i++) {
            if(timestamps[i] > 946702800) {
                filteredTimestamps[currentIndex] = timestamps[i];
                filteredSenders[currentIndex] = senders[i];
                currentIndex++;
            }
        }

        return (filteredTimestamps, filteredSenders);
    }

    // Reset senders array
    function resetSenders() public {
        delete senders;
    }

    // Reset timestamps array
    function resetTimestamps() public {
        delete timestamps;
    }
} 