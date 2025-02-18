// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./SillyStringUtils.sol";

contract ImportsExercise {
    using SillyStringUtils for string;

    SillyStringUtils.Haiku public haiku;

    // Save the haiku lines
    function saveHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) public {
        haiku.line1 = _line1;
        haiku.line2 = _line2;
        haiku.line3 = _line3;
    }

    // Get the complete haiku
    function getHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    // Get haiku with shruggie at the end of line3
    function shruggieHaiku() public view returns (SillyStringUtils.Haiku memory) {
        SillyStringUtils.Haiku memory modifiedHaiku = haiku;
        modifiedHaiku.line3 = SillyStringUtils.shruggie(haiku.line3);
        return modifiedHaiku;
    }
} 