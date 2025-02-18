// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Custom error for non-approved records
error NotApproved(string recordName);

contract Mappings {
    // Mappings for approved records and user favorites
    mapping(string => bool) public approvedRecords;
    mapping(address => mapping(string => bool)) public userFavorites;
    
    // Array to store approved record names for getApprovedRecords
    string[] private approvedRecordsList;

    constructor() {
        // Initialize approved records
        string[9] memory records = [
            "Thriller",
            "Back in Black",
            "The Bodyguard",
            "The Dark Side of the Moon",
            "Their Greatest Hits (1971-1975)",
            "Hotel California",
            "Come On Over",
            "Rumours",
            "Saturday Night Fever"
        ];

        // Add each record to both mapping and array
        for(uint i = 0; i < records.length; i++) {
            approvedRecords[records[i]] = true;
            approvedRecordsList.push(records[i]);
        }
    }

    // Return list of all approved records
    function getApprovedRecords() public view returns (string[] memory) {
        return approvedRecordsList;
    }

    // Add record to user's favorites
    function addRecord(string memory recordName) public {
        if (!approvedRecords[recordName]) {
            revert NotApproved(recordName);
        }
        userFavorites[msg.sender][recordName] = true;
    }

    // Get user's favorite records
    function getUserFavorites(address user) public view returns (string[] memory) {
        // Count user's favorites first
        uint count = 0;
        for(uint i = 0; i < approvedRecordsList.length; i++) {
            if(userFavorites[user][approvedRecordsList[i]]) {
                count++;
            }
        }

        // Create array of correct size
        string[] memory favorites = new string[](count);
        
        // Fill array with user's favorites
        uint currentIndex = 0;
        for(uint i = 0; i < approvedRecordsList.length; i++) {
            if(userFavorites[user][approvedRecordsList[i]]) {
                favorites[currentIndex] = approvedRecordsList[i];
                currentIndex++;
            }
        }

        return favorites;
    }

    // Reset user's favorites
    function resetUserFavorites() public {
        for(uint i = 0; i < approvedRecordsList.length; i++) {
            if(userFavorites[msg.sender][approvedRecordsList[i]]) {
                userFavorites[msg.sender][approvedRecordsList[i]] = false;
            }
        }
    }
} 