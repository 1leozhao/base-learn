// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

// Custom error for contact not found
error ContactNotFound(uint id);

contract AddressBook is Ownable {
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
        bool exists;  // To track if contact exists
    }

    // Mapping from id to Contact
    mapping(uint => Contact) private contacts;
    uint[] private contactIds;  // To keep track of all contact IDs
    uint private nextId = 1;    // For generating unique IDs

    constructor(address initialOwner) Ownable(initialOwner) {}

    // Add a new contact (only owner)
    function addContact(
        string memory _firstName,
        string memory _lastName,
        uint[] memory _phoneNumbers
    ) public onlyOwner returns (uint) {
        uint id = nextId++;
        
        contacts[id] = Contact({
            id: id,
            firstName: _firstName,
            lastName: _lastName,
            phoneNumbers: _phoneNumbers,
            exists: true
        });
        
        contactIds.push(id);
        return id;
    }

    // Delete a contact (only owner)
    function deleteContact(uint _id) public onlyOwner {
        if (!contacts[_id].exists) {
            revert ContactNotFound(_id);
        }

        delete contacts[_id];
        
        // Remove id from contactIds array
        for (uint i = 0; i < contactIds.length; i++) {
            if (contactIds[i] == _id) {
                contactIds[i] = contactIds[contactIds.length - 1];
                contactIds.pop();
                break;
            }
        }
    }

    // Get a specific contact
    function getContact(uint _id) public view returns (Contact memory) {
        if (!contacts[_id].exists) {
            revert ContactNotFound(_id);
        }
        return contacts[_id];
    }

    // Get all contacts
    function getAllContacts() public view returns (Contact[] memory) {
        Contact[] memory allContacts = new Contact[](contactIds.length);
        
        for (uint i = 0; i < contactIds.length; i++) {
            allContacts[i] = contacts[contactIds[i]];
        }
        
        return allContacts;
    }
}

contract AddressBookFactory {
    // Event to track new address books
    event AddressBookCreated(address indexed owner, address addressBook);

    // Deploy a new AddressBook
    function deploy() public returns (address) {
        AddressBook newAddressBook = new AddressBook(msg.sender);
        
        emit AddressBookCreated(msg.sender, address(newAddressBook));
        return address(newAddressBook);
    }
} 