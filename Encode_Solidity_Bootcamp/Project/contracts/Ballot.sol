//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */

contract Ballot {
    // This declares a new complex type which will be used for variables later.
    // It will represent a "single voter".
    struct Voter {
        uint256 weight; // weight is accumulated by delegation
        bool voted; // if true, that person already voted
        address delegate; // person delegated to
        uint256 vote; // index of the voted proposal
    }

    // This is a type for a single proposal
    struct Proposal {
        bytes32 name; // Use one of bytes1 to bytes32 because they are much cheaper
        uint256 voteCount; // number of accumulated voted
    }

    address public chairperson;
    mapping(address => Voter) public voters; // Declares a state variable that stores a 'Voter' struct for each possible address
    Proposal[] public proposals; // A dynamically-sized array of 'Proposal' structs

    /**
     * @dev Create a new ballot to choose one of 'proposalNames'
     * @param proposalNames names of proposals
     */
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        // Proposal({...}) creates a temporary Propsal object, and proposals.push(...) apprends it to the end of 'proposals'
        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    /**
     * @dev Give 'voter' the right to vote on this ballot. May only be called by 'chairperson'
     * @param voter address of voter
     */
    function giveRightToVote(address voter) public {
        require(msg.sender == chairperson, "Only chairperson gives rights");
        require(!voters[voter].voted, "The voter already voted.");
        require(voters[voter].weight == 0, "Already has right to vote");
        // Give voter the right here
        voters[voter].weight = 1;
    }

    /**
     * @dev Delegate your vote to the voter "to"
     * @param to address to which vote is delegated
     */
    function delegate(address to) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You already voted");
        require(to != msg.sender, "Self-delegation is disallowed.");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            // A loop in delegation was found, not allowed
            require(to != msg.sender, "Found loop in delegation");
        }

        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];

        if (delegate_.voted) {
            // If delegate aleady voted, directly add to the number of votes
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // If delegate did not vote yet, add to her weight
            delegate_.weight += sender.weight;
        }
    }

    /**
     * @dev Give your vote (including votes delegated to you) to proposal 'proposals[proposal].name'.
     * @param proposal index of proposal in the proposals array
     */
    function vote(uint256 proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;

        // If 'proposal' is out of the range of the array, this will throw automatically and revert all changes
        proposals[proposal].voteCount += sender.weight;
    }

    /**
     * @dev Computes the winning proposal taking all previous votes into account.
     * @return winningProposal_ index of winning proposal in the proposals array
     */
    function winningProposal() public view returns (uint256 winningProposal_) {
        uint256 winningVoteCount = 0;
        for (uint256 p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    /**
     * @dev Calls winningProposal() function to get the index of the winner contained in the proposals array and then
     * @return winnerName_ the name of the winner
     */
    function winnerName() public view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }
}
