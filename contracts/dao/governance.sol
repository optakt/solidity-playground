// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DAO {

    // FIXME: Use proper addresses.
    address[] public voters = [
    0x1a1A1A1A1a1A1A1a1A1a1a1a1a1a1a1A1A1a1a1a,
    0x2A2a2a2a2a2A2A2a2a2a2A2a2A2A2A2a2A2A2a2a,
    0x3A3a3A3a3A3A3a3A3a3A3a3A3a3a3A3a3A3a3a3a,
    0x4a4a4A4A4A4a4a4A4a4A4a4a4a4A4a4a4A4A4a4A,
    0x5a5A5a5a5A5a5a5a5a5A5a5A5A5a5a5A5A5A5A5A,
    0x6A6A6a6A6a6a6a6A6a6A6a6a6a6A6A6a6a6a6A6A,
    0x7A7a7A7a7a7a7a7A7a7a7a7A7a7A7A7A7A7A7a7A
    ]; // Hardcoded array of voter addresses.
    uint64 public constant quorum = 4; // Minimum amount of votes (N/2+1).

    enum VoteType {
        Against,
        For,
        Abstain
    }
    enum ProposalStatus{
        Open,
        Closed,
        Done
    }
    uint64 counter; // Incremental counter for proposal IDs.
    struct Proposal {
        uint64 id; // Unique ID for the proposal.
        string description; // Description of the proposal.
        string hash; // Proposal file hash on IPFS.
        uint64 votingPeriod; // Time before the voting closes and proposal is either executed or closed.
        ProposalStatus status; // Status of the proposal.
    }
    mapping(uint => Proposal) public open;
    mapping(uint => Proposal) public closed;
    mapping(uint => Proposal) public done;

    struct Vote {
        uint64 pID; // proposal ID.
        bool value; // whether this vote accepts the proposal.
    }
    mapping(uint64 => Vote[]) votes; // Votes that were cast for this proposal.

    // FIXME: We assume that file was written on IPFS and the proposal is created with its hash.
    function propose(string calldata hash, string calldata description) private {
        uint64 id = counter++;

        Proposal memory p = Proposal({
            id : id,
            description : description,
            hash : hash,
            votingPeriod : 24 * 60 * 60, // FIXME: Should it be in time units or block counts?
            status : ProposalStatus.Open
        });

        open[id] = p;
    }

    // FIXME: Make the vote function not public but require certain privileges.
    function vote(address voterAddr, uint64 pID, VoteType vote) private {
        // FIXME: This already changes the state, so how to make it so that it's executeVote that does the writing?
        Vote memory v = Vote({
            pID : pID,
            value : vote
        });

        votes[pID].push(v);
    }

    // FIXME: Make votes effective when public function is called.
    function executeVote(address voterAddr, uint64 pID) public {
        // FIXME: Implement.
    }
}
