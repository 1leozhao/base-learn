// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

// Custom errors
error TokensClaimed();
error AllTokensClaimed();
error NoTokensHeld();
error QuorumTooHigh(uint quorum);
error AlreadyVoted();
error VotingClosed();

contract WeightedVoting is ERC20 {
    using EnumerableSet for EnumerableSet.AddressSet;

    // Vote enum
    enum Vote {
        AGAINST,
        FOR,
        ABSTAIN
    }

    // Issue struct - order matters for unit tests
    struct Issue {
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }

    // Return type for getIssue
    struct IssueView {
        address[] voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }

    // State variables
    uint public constant maxSupply = 1_000_000;
    mapping(address => bool) private hasClaimed;
    Issue[] private issues;

    constructor() ERC20("WeightedVoting", "VOTE") {
        // Burn the zeroeth element of issues
        Issue storage dummyIssue = issues.push();
        dummyIssue.issueDesc = "";
        dummyIssue.quorum = 0;
        dummyIssue.passed = false;
        dummyIssue.closed = true;
    }

    function claim() public {
        if (hasClaimed[msg.sender]) {
            revert TokensClaimed();
        }

        if (totalSupply() + 100 > maxSupply) {
            revert AllTokensClaimed();
        }

        hasClaimed[msg.sender] = true;
        _mint(msg.sender, 100);
    }

    function createIssue(string calldata _issueDesc, uint _quorum) external returns (uint) {
        // Check token holder status first (for test compatibility)
        if (balanceOf(msg.sender) == 0) {
            revert NoTokensHeld();
        }

        // Then check quorum
        if (_quorum > totalSupply()) {
            revert QuorumTooHigh(_quorum);
        }

        Issue storage newIssue = issues.push();
        newIssue.issueDesc = _issueDesc;
        newIssue.quorum = _quorum;
        newIssue.passed = false;
        newIssue.closed = false;

        return issues.length - 1;
    }

    function getIssue(uint _id) external view returns (IssueView memory) {
        Issue storage issue = issues[_id];
        
        // Convert EnumerableSet to array for external view
        address[] memory voterArray = new address[](EnumerableSet.length(issue.voters));
        for (uint i = 0; i < EnumerableSet.length(issue.voters); i++) {
            voterArray[i] = EnumerableSet.at(issue.voters, i);
        }

        return IssueView({
            voters: voterArray,
            issueDesc: issue.issueDesc,
            votesFor: issue.votesFor,
            votesAgainst: issue.votesAgainst,
            votesAbstain: issue.votesAbstain,
            totalVotes: issue.totalVotes,
            quorum: issue.quorum,
            passed: issue.passed,
            closed: issue.closed
        });
    }

    function vote(uint _issueId, Vote _vote) public {
        Issue storage issue = issues[_issueId];
        
        if (issue.closed) {
            revert VotingClosed();
        }

        if (EnumerableSet.contains(issue.voters, msg.sender)) {
            revert AlreadyVoted();
        }

        uint voterBalance = balanceOf(msg.sender);
        if (voterBalance == 0) {
            revert NoTokensHeld();
        }

        // Add voter to the set
        EnumerableSet.add(issue.voters, msg.sender);

        // Record votes based on the voter's token balance
        if (_vote == Vote.FOR) {
            issue.votesFor += voterBalance;
        } else if (_vote == Vote.AGAINST) {
            issue.votesAgainst += voterBalance;
        } else {
            issue.votesAbstain += voterBalance;
        }

        issue.totalVotes += voterBalance;

        // Check if quorum is reached
        if (issue.totalVotes >= issue.quorum) {
            issue.closed = true;
            issue.passed = issue.votesFor > issue.votesAgainst;
        }
    }
} 