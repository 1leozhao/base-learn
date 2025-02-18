// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// Custom errors
error HaikuNotUnique();
error NotYourHaiku(uint id);
error NoHaikusShared();

contract HaikuNFT is ERC721 {
    // Struct to store haiku details
    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    // State variables as per spec
    Haiku[] public haikus;  // Public array to store haikus
    mapping(address => uint[]) public sharedHaikus;  // Public mapping for shared haikus
    uint public counter = 1;  // Public counter starting at 1 (no id 0)

    // Track used lines to ensure uniqueness
    mapping(string => bool) private usedLines;

    constructor() ERC721("HaikuNFT", "HAIKU") {
        // No need to initialize haikus array with dummy element
        // as counter starts at 1 and we won't use index 0
    }

    function mintHaiku(
        string calldata _line1,
        string calldata _line2,
        string calldata _line3
    ) external {
        // Check for uniqueness of each line
        if (usedLines[_line1] || usedLines[_line2] || usedLines[_line3]) {
            revert HaikuNotUnique();
        }

        // Mark lines as used
        usedLines[_line1] = true;
        usedLines[_line2] = true;
        usedLines[_line3] = true;

        // Create and store the haiku at the current counter value
        while (haikus.length < counter) {
            haikus.push(); // Fill any gaps to match counter
        }
        
        haikus.push(Haiku({
            author: msg.sender,
            line1: _line1,
            line2: _line2,
            line3: _line3
        }));

        // Mint the NFT with current counter as ID
        _mint(msg.sender, counter);

        // Increment counter for next ID
        counter++;
    }

    function shareHaiku(address _to, uint _id) public {
        // Check ownership
        if (ownerOf(_id) != msg.sender) {
            revert NotYourHaiku(_id);
        }

        // Add to shared haikus
        sharedHaikus[_to].push(_id);
    }

    function getMySharedHaikus() public view returns (Haiku[] memory) {
        uint[] storage myShared = sharedHaikus[msg.sender];
        
        // Check if any haikus are shared
        if (myShared.length == 0) {
            revert NoHaikusShared();
        }

        // Create array of shared haikus
        Haiku[] memory shared = new Haiku[](myShared.length);
        for (uint i = 0; i < myShared.length; i++) {
            shared[i] = haikus[myShared[i]];
        }

        return shared;
    }
} 