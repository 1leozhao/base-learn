// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Custom error for invalid car index
error BadCarIndex(uint index);

contract GarageManager {
    // Car struct definition
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    // Mapping of address to array of cars
    mapping(address => Car[]) public garage;

    // Add a new car to the caller's garage
    function addCar(
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        Car memory newCar = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });
        garage[msg.sender].push(newCar);
    }

    // Get all cars for the calling user
    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    // Get all cars for any user
    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    // Update a car at a specific index
    function updateCar(
        uint _index,
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        // Check if the car exists
        if (_index >= garage[msg.sender].length) {
            revert BadCarIndex(_index);
        }

        // Update the car
        garage[msg.sender][_index] = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });
    }

    // Reset the caller's garage
    function resetMyGarage() public {
        delete garage[msg.sender];
    }
} 