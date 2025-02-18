// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Base abstract contract
abstract contract Employee {
    uint public idNumber;
    uint public managerId;

    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    function getAnnualCost() public virtual returns (uint);
}

// Salaried employee contract
contract Salaried is Employee {
    uint public annualSalary;

    constructor(
        uint _idNumber,
        uint _managerId,
        uint _annualSalary
    ) Employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }

    function getAnnualCost() public view override returns (uint) {
        return annualSalary;
    }
}

// Hourly employee contract
contract Hourly is Employee {
    uint public hourlyRate;

    constructor(
        uint _idNumber,
        uint _managerId,
        uint _hourlyRate
    ) Employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    function getAnnualCost() public view override returns (uint) {
        return hourlyRate * 2080; // 2080 is the number of working hours in a year
    }
}

// Manager contract
contract Manager {
    uint[] public employeeIds;

    function addReport(uint _employeeId) public {
        employeeIds.push(_employeeId);
    }

    function resetReports() public {
        delete employeeIds;
    }
}

// Salesperson contract
contract Salesperson is Hourly {
    constructor(
        uint _idNumber,
        uint _managerId,
        uint _hourlyRate
    ) Hourly(_idNumber, _managerId, _hourlyRate) {}
}

// Engineering Manager contract
contract EngineeringManager is Salaried, Manager {
    constructor(
        uint _idNumber,
        uint _managerId,
        uint _annualSalary
    ) Salaried(_idNumber, _managerId, _annualSalary) {}
}

// Submission contract
contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
} 