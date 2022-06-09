// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Proposal {
    enum ProposalStatus{OPEN, CLOSED, DONE}

    uint64 id; // Unique ID for the proposal.
    string description; // Description of the proposal.
    string hash; // Proposal file hash on IPFS.
    uint64 votingPeriod; // Time before the voting closes and proposal is either executed or closed.
    ProposalStatus status; // Status of the proposal.

    mapping(address => bool) votes; // Votes that were cast for this proposal.
}

contract DAO {

    address[] public voters = [
        0x1a1a1a1a1a1a1a1a1a1a1a1a1,
        0x2a2a2a2a2a2a2a2a2a2a2a2a2,
        0x3a3a3a3a3a3a3a3a3a3a3a3a3,
        0x4a4a4a4a4a4a4a4a4a4a4a4a4,
        0x5a5a5a5a5a5a5a5a5a5a5a5a5,
        0x6a6a6a6a6a6a6a6a6a6a6a6a6,
        0x7a7a7a7a7a7a7a7a7a7a7a7a7
    ];

    uint64 counter;

    mapping(uint => Proposal) public open;
    mapping(uint => Proposal) public closed;
    mapping(uint => Proposal) public done;

    // FIXME: We assume that file was written on IPFS and the proposal is created with its hash.
    function propose(string hash, string description) public {
        Proposal p;

        p.id = counter++;
        p.description = description;
        p.hash = hash;
        p.votingPeriod = 24*60*60; // FIXME: Should it be in time units or block counts?
        p.status = OPEN;

        open[p.id] = p;
    }

    // FIXME: Make the vote function not public but require certain privileges.
    function vote(address voterAddr, uint64 pID, bool voteValue) public {
        pending[pID].votes[voterAddr] = voteValue;
    }

    // FIXME: Make votes effective when public function is called.

    // FIXME: Hardcode addresses of wallets that can participate in DAO and enforce it.
}