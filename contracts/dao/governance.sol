// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DAO {

    event ProposalOpen(uint256 proposalId, uint256 startBlock, uint256 endBlock);
    event ProposalClosed(uint256 proposalId);
    event ProposalDone(uint256 proposalId);

    // FIXME: Use proper addresses.
    address[] public VOTERS = [
    0x1a1A1A1A1a1A1A1a1A1a1a1a1a1a1a1A1A1a1a1a,
    0x2A2a2a2a2a2A2A2a2a2a2A2a2A2A2A2a2A2A2a2a,
    0x3A3a3A3a3A3A3a3A3a3A3a3A3a3a3A3a3A3a3a3a,
    0x4a4a4A4A4A4a4a4A4a4A4a4a4a4A4a4a4A4A4a4A,
    0x5a5A5a5a5A5a5a5a5a5A5a5A5A5a5a5A5A5A5A5A,
    0x6A6A6a6A6a6a6a6A6a6A6a6a6a6A6A6a6a6a6A6A,
    0x7A7a7A7a7a7a7a7A7a7a7a7A7a7A7A7A7A7A7a7A
    ]; // Hardcoded array of voter addresses.
    uint256 public constant QUORUM = 4; // Minimum amount of votes (N/2+1).

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
    uint256 counter; // Incremental counter for proposal IDs.
    struct Proposal {
        uint256 id; // Unique ID for the proposal.
        string description; // Description of the proposal.
        string hash; // Proposal file hash on IPFS.
        uint256 startBlock; // Block from which the proposal opens.
        uint256 endBlock; // Block at which the proposal closes.
        ProposalStatus status; // Status of the proposal.
    }
    struct ProposalVote {
        uint256 for_;
        uint256 against;
        uint256 abstain;

        mapping(address => bool) voted; // Mapping to keep track of which members voted for this proposal.
    }
    mapping(uint => Proposal) public open;
    mapping(uint => Proposal) public closed;
    mapping(uint => Proposal) public done;

    mapping (uint => ProposalVote) private proposalVotes;

    function votingDelay() public pure returns (uint256) {
        return 1; // 1 block
    }

    function votingPeriod() public pure returns (uint256) {
        return 5000;
    }

    // FIXME: We assume that file was written on IPFS and the proposal is created with its hash.
    function propose(string calldata hash, string calldata description) private {
        uint256 id = counter++;

        uint256 startBlock = block.number + votingDelay();
        uint256 endBlock = startBlock + votingPeriod();

        Proposal memory p = Proposal({
            id: id,
            description: description,
            hash: hash,
            startBlock: startBlock,
            endBlock: endBlock,
            status: ProposalStatus.Open
        });

        open[id] = p;

        emit ProposalOpen(id, startBlock, endBlock);
    }

    // FIXME: Make the vote function not public but require certain privileges.
    function vote(address voterAddr, uint256 pID, VoteType voteType) private {
        // FIXME: This already changes the state, so how to make it so that it's executeVote that does the writing?
        proposalVotes[pID].voted[voterAddr] = true;

        if (voteType == VoteType.Abstain) {
            proposalVotes[pID].abstain++;
        } else if (voteType == VoteType.For) {
            proposalVotes[pID].for_++;
        } else {
            proposalVotes[pID].against++;
        }
    }

    // FIXME: Make votes effective when public function is called.
    // function executeVote(address voterAddr, uint256 pID) public {
    //     // FIXME: Implement.
    // }

    function _quorumReached(uint256 pID) internal view returns (bool) {
        ProposalVote storage pv = proposalVotes[pID];

        return QUORUM <= pv.for_;
    }
}
