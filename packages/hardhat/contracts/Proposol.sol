// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// this is set up specifically for yes/no proposals
// Note: should we have the opportunity/time, it would make a lot of sense to have a parent Proposal contract and then other contract types
// that inherit from Proposal (they wouldnt be very different from one another, after all)
contract Proposal {
    /* Following properties are variables that would be set by the Proposal Management contract (should we end up coding that) */
    // for the record, we could pass them into the constructor when deploying the contracts, as well, but saving effort for now
   
    // how many votes must be in favor for the vote to pass
    uint8 threshhold;

    // times are done in uint form as number of seconds since 1-1-1970
    uint deadline;

    /* Properties to track votes */

    // the record of IF someone has voted. Not what their vote was (that, actually, does not need to even be recorded)
    mapping(address => bool) vote_record;

    // for the yes/no type of vote, only two options: true (yes) or false (no)
    // other types of votes would likely need names to differentiate (or something else to pass to the callback?)
    mapping(bool => uint8) vote_count;

    mapping(address=>bool) membership;

    // https://ethereum.stackexchange.com/questions/43751/does-solidity-support-passing-an-array-of-strings-to-a-contracts-constructor-ye
    constructor(uint _deadline, uint8 _threshhold) {
        deadline = _deadline;
        threshhold = _threshhold;
        membership[0x142Ab00310aaCB3E27bf06c5cB9eEbf6116b0E51] = true;
    }

    function recordVote (bool vote) external {
        //make sure the sender is allowed to vote
        require(membership[msg.sender]);
        
        //make sure the sender has not already voted
        require(!vote_record[msg.sender]);

        //ensure deadline hasn't passed
        require(block.timestamp <= deadline);

        //record the sender's vote
        vote_count[vote] = vote_count[vote] + 1;

        //record that they have voted
        vote_record[msg.sender] = true;

        // TODO: check threshhold and act?
    }

    function hasVoted() external view returns (bool) {
        return vote_record[msg.sender];
    }
}

contract DistrictManager {
    struct Vote {
        string name;
        string description;
        address proposal;
    }

    Vote[] votes;

    uint8 member_count;

    constructor() {
       // membership = MemberRecord(_membership);
       // member_count = membership.getCount();

        // could make more
    }

    function createTestProposals() external {
        createProposal("Change website color to blue", 
                       "The background is awful; let's make it better",
                       block.timestamp + 1209600,
                       0);
    }

    function createProposal (string memory _name, string memory _description, uint _deadline, uint8 _threshhold) internal {
        uint8 threshhold = _threshhold == 0 ? member_count/2 : _threshhold;

        Vote memory newVote;
        newVote.name = _name;
        newVote.description = _description;
        newVote.proposal = address(new Proposal(_deadline, threshhold));
        votes.push(newVote);
    } 

    function getVotes() external view returns (Vote[] memory){
        Vote[] memory votes_ = new Vote[](votes.length);
        for (uint8 i = 0; i < votes.length; i++) {
            Vote storage vote_ = votes[i];
            votes_[i] = vote_;
        }
      return votes_;
    }

    function ping() external view returns (string memory) {
        return "hello";
    }
}