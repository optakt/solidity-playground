// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DAO {

    enum ProposalStatus{OPEN, CLOSED, DONE}

    struct Proposal {
        uint64 id; // Unique ID for the proposal.
        string description; // Description of the proposal.
        string hash; // Proposal file hash on IPFS.
        uint64 votingPeriod; // Time before the voting closes and proposal is either executed or closed.
        ProposalStatus status; // Status of the proposal.
    }

    struct Vote {
        uint64 proposalID;
        bool value;
    }

    address[] public voters = [
    0x1a1A1A1A1a1A1A1a1A1a1a1a1a1a1a1A1A1a1a1a,
    0x2A2a2a2a2a2A2A2a2a2a2A2a2A2A2A2a2A2A2a2a,
    0x3A3a3A3a3A3A3a3A3a3A3a3A3a3a3A3a3A3a3a3a,
    0x4a4a4A4A4A4a4a4A4a4A4a4a4a4A4a4a4A4A4a4A,
    0x5a5A5a5a5A5a5a5a5a5A5a5A5A5a5a5A5A5A5A5A,
    0x6A6A6a6A6a6a6a6A6a6A6a6a6a6A6A6a6a6a6A6A,
    0x7A7a7A7a7a7a7a7A7a7a7a7A7a7A7A7A7A7A7a7A
    ];

    uint64 counter;

    mapping(address => Vote) votes; // Votes that were cast for this proposal.
    mapping(uint => Proposal) public open;
    mapping(uint => Proposal) public closed;
    mapping(uint => Proposal) public done;

    // FIXME: We assume that file was written on IPFS and the proposal is created with its hash.
    function propose(string calldata hash, string calldata description) private {
        uint64 id = counter++;

        Proposal memory p = Proposal({
            id : id,
            description : description,
            hash : hash,
            votingPeriod : 24 * 60 * 60, // FIXME: Should it be in time units or block counts?
            status : ProposalStatus.OPEN
        });

        open[id] = p;
    }

    // FIXME: Make the vote function not public but require certain privileges.
    function vote(address voterAddr, uint64 pID, bool voteValue) private {
        // FIXME: This already changes the state, so how to make it so that it's executeVote that does the writing?
        Vote memory v = Vote({
            proposalID : pID,
            value : voteValue
        });

        votes[voterAddr] = v;
    }

    // FIXME: Make votes effective when public function is called.
    function executeVote(address voterAddr, uint64 pID) public {
        // FIXME: Implement.
    }

    // FIXME: Hardcode addresses of wallets that can participate in DAO and enforce it.
}
