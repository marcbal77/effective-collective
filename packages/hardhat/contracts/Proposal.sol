// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IDistrictManager {
    function checkMembership(address _addr) external view returns (bool);
}
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

    // the record of IF someone has voted. (Not what their vote was)
    mapping(address => bool) vote_record;

    // for the yes/no type of vote, only two options: true (yes) or false (no)
    // other types of votes would likely need names to differentiate
    mapping(bool => uint8) vote_count;

    IDistrictManager district;

    constructor(uint _deadline, uint8 _threshhold, address _district) {
        deadline = _deadline;
        threshhold = _threshhold;
        district = IDistrictManager(_district);
    }

    function recordVote (bool vote) external {
        //make sure the sender is allowed to vote
        require(district.checkMembership(msg.sender));
        
        //make sure the sender has not already voted
        require(!vote_record[msg.sender]);

        //ensure deadline hasn't passed
        require(block.timestamp <= deadline);

        //record the sender's vote
        vote_count[vote] = vote_count[vote] + 1;

        //record that they have voted
        vote_record[msg.sender] = true;
    }

    function hasVoted(address addr_) external view returns (bool) {
        return vote_record[addr_];
    }
}

contract DistrictManager is IDistrictManager {
    struct Vote {
        string name;
        string description;
        address proposal;
        bool hasVoted;
    }

    mapping(address=>bool) membership;
    address[] members;

    Vote[] votes;

    constructor() {}

    function restartDemo(address[] memory _members) external {
        // clear current members of their membership
        for(uint8 i = 0; i < members.length; i++){
            membership[members[i]] = false;
        }

        // clear current members list
        delete members;
        // clear existing proposals
        delete votes;

        // add new members
        for(uint8 i = 0; i < _members.length; i++){
            membership[_members[i]] = true;
            members.push(_members[i]);
        }



        // create test proposals
        createProposal("Change website color to blue", 
                       "The background is awful; let's make it better",
                       block.timestamp + 1209600,
                       0);
        createProposal("Change DAO name Vincent Van Dao", 
                       "People like puns more than they like rhymes",
                       block.timestamp + 1209600,
                       0);
    }

    function createProposal(string memory _name, string memory _description, uint _deadline, uint8 _threshhold) internal {
        uint8 threshhold = _threshhold == 0 ? (uint8)(members.length)/2 : _threshhold;

        Vote memory newVote;
        newVote.name = _name;
        newVote.description = _description;
        newVote.proposal = address(new Proposal(_deadline, threshhold, address(this)));
        votes.push(newVote);
    } 

    function getProposals() external view returns (Vote[] memory){
        Vote[] memory votes_ = new Vote[](votes.length);
        for (uint8 i = 0; i < votes.length; i++) {
            Vote storage vote_ = votes[i];
            votes_[i] = vote_;
            votes_[i].hasVoted = ((Proposal)(vote_.proposal)).hasVoted(msg.sender);
        }
        return votes_;
    }

    function checkMembership(address _addr) external view returns (bool) {
        return membership[_addr];
    }

    function ping() external pure returns (string memory) {
        return "hello";
    }
}