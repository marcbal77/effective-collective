// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

//TODO: clean up these imports -- I copy-pasted from one of the classes
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
import "@openzeppelin/contracts@4.6.0/utils/Base64.sol";

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";

// this is set up specifically for yes/no proposals
// Note: should we have the opportunity/time, it would make a lot of sense to have a parent Proposal contract and then other contract types
// that inherit from Proposal (they wouldnt be very different from one another, after all)
contract Proposal {
    /* Following properties are variables that would be set by the Proposal Management contract (should we end up coding that) */
    // for the record, we could pass them into the constructor when deploying the contracts, as well, but saving effort for now
    
    // TODO: consider having this be in the parent contract instead? The parent contract could have an array of structs that contain
    // a name, description, and Proposal
    string name;

    string description;

    // who is allowed to vote in this proposal
    // (todo: consider simily initializing one of the maps in the constructor, instead? Undefinited hash values would just be unallowed addresses)
    address[] allowed_voters;

    // can functions be passed as params? 
    // maybe this is set up in a different way? 
    // we need to have _something_ for this contract to do when the vote passes
    function callback = () => {
        //do something, but what?
        //skhkafs
        //urg
    }

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

    // https://ethereum.stackexchange.com/questions/43751/does-solidity-support-passing-an-array-of-strings-to-a-contracts-constructor-ye
    constructor() public {
        allowed_voters = [
            0x834873,
            0x98274e,
            0x937942,
            0x834748,
            0x283948
        ];

        // 2 weeks from now (time of the latest block on the chain)
        deadline = now + 1209600;
        threshhold = 3;

        name = "Proposal to turn website blue";
        description = "the background is whack; let's change it."
    }

    // functions needed:
    // record vote(bool) - would also check if threshhold reached and act accordingly (maybe we can't call a function, maybe all we can do is
    //      inform the parent contract (the one we may or may not be made) of the result of the vote?
    // get name and get description -- might not be necessary? I think it could almost be *easier* to go ahead and make a parent sort of contract
    //      to represetn the DAO/district/etc and have that simply maintain a list of names and descriptions along with addresses to the vote-managing
    //      contracts like this one
    // hasVoted -- returns a bool -- tru if the caller has voted


    // Other thoughts:
    // easy: should define another type of contract that's NFT-esque for the voter confirmation and yeet it out to the world when a vote comes in
    // not as easy: as far as what should be on polygon (if we can get something on polygon: this isn't a bad option, but also the parent/district 
    //      contract would be a good choice too
}
