// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// So that the Votes can check membership of the sender
// membership is under the district's jurisdiction
interface IDistrictManager {
    function checkMembership(address _addr) external view returns (bool);
}

abstract contract Vote {
    // times are done in uint form as number of seconds since 1-1-1970
    uint deadline;
    IDistrictManager district;

    constructor(uint _deadline, address _district) {
        deadline = _deadline;
        district = IDistrictManager(_district);
    }

    function verifyVote() internal view {
        //make sure the sender is allowed to vote
        require(district.checkMembership(msg.sender));

        //ensure deadline hasn't passed
        require(block.timestamp <= deadline);
    }

    function hasVoted(address addr_) external virtual returns (bool) { }
}

contract Proposal is Vote {
    // how many votes must be in favor for the vote to pass
    uint8 threshhold;
    // the record of IF someone has voted. (Not what their vote was)
    mapping(address => bool) private vote_record;
    // for the Propsal type of vote, only two options: true (yes) or false (no)
    mapping(bool => uint8) private vote_count;
    
    constructor(uint _deadline, address _district, uint8 _threshhold) 
    Vote(_deadline, _district){
        threshhold = _threshhold;
    }

    function recordVote (bool vote) external returns (bool) {
        verifyVote();

        //make sure the sender has not already voted
        require(!vote_record[msg.sender]);

        //record the sender's vote
        vote_count[vote] = vote_count[vote] + 1;
        //record that they have voted
        vote_record[msg.sender] = true;

        // for the sake of MVP, when the vote passes the threshhold, we return true
        return (vote_count[vote] >= threshhold);
    }

     function hasVoted(address addr_) external view override virtual returns (bool) {
        return vote_record[addr_];
    }
}


contract DistrictManager is IDistrictManager {
    struct VoteInfo {
        string name;
        string description;
        address proposal;
        bool hasVoted;
    }

    mapping(address=>bool) membership;
    address[] members;

    VoteInfo[] votes;

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
                       1);
        createProposal("Change DAO name Vincent Van Dao", 
                       "People like puns more than they like rhymes",
                       block.timestamp + 1209600,
                       0);
    }

    function createProposal(string memory _name, string memory _description, uint _deadline, uint8 _threshhold) internal {
        uint8 threshhold = _threshhold == 0 ? (uint8)(members.length)/2 : _threshhold;

        VoteInfo memory newVote;
        newVote.name = _name;
        newVote.description = _description;
        newVote.proposal = address(new Proposal(_deadline, address(this), threshhold));
        votes.push(newVote);
    } 

    function getVotes() external returns (VoteInfo[] memory){
        VoteInfo[] memory votes_ = new VoteInfo[](votes.length);
        for (uint8 i = 0; i < votes.length; i++) {
            VoteInfo storage vote_ = votes[i];
            votes_[i] = vote_;
            votes_[i].hasVoted = ((Vote)(vote_.proposal)).hasVoted(msg.sender);
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