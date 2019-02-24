pragma solidity ^0.4.0;

contract userstory {

    struct Story_Bakers {
        address baker;
        uint baked_sum;
        bool accept_work;

    }

    struct UserStory {
                          uint project_ID;
                          uint User_story_number;
                          //address project_token;
                          bytes32 DFS_Hash;
                          byte8 DFS_type;
                          uint Story_Amount_ANG; // number of ANG payed by bakers
                          uint Story_Amount_Tokens; //number of tokens gives from team
                          uint256 start_date; // timestamp,
                          uint duration; // timedelta,
                          uint256 Ask_end_from_project; // datetime when team say they finish work
                          // bool  project_signin; //  several team members?
                          uint256 finished; // datetime acceptwance from bakers
                          // bool project_accept;  // TODO tx transaction of acceptance
                          mapping (uint => Story_Bakers) bakers;  //# several users who baked story
                        // mapping (uint => Story_Bakers) confirm_end_from_user; // several users


                        }

    mapping (address => UserStory) public UserStories ; // AKA projectID


    event Newuserstory (uint ProjectID, uint Userstorynumber, bytes32 DFSHash, uint StoryAmountANG, uint StoryAmounttoken, uint256 Startdate, uint duration);

    function start_user_story (uint ProjectID, uint Userstorynumber, bytes32 DFSHash, byte8 DFStype, uint StoryAmountANG,
                                uint StoryAmounttoken, uint256 Startdate, uint duration) public
                                OnlyOwner(msg.sender) returns (uint){
        address storekey = keccak256(ProjectID, Userstorynumber);
        UserStories[storekey].project_ID = project_ID;
        UserStories[storekey].User_story_number = Userstorynumber;
        UserStories[storekey].duration = duration;
        UserStories[storekey].DFS_Hash = DFSHash;
        UserStories[storekey].DFS_type= DFStype;
        UserStories[storekey].Story_Amount_ANG = StoryAmountANG;
        UserStories[storekey].start_date = Startdate;
        UserStories[storekey].duration = duration;


        emit  Newuserstory (ProjectID,  Userstorynumber, DFSHash,  StoryAmountANG,  StoryAmounttoken, Startdate, Deadline);
        return  storekey;
    }

   // function add_user_story_comment () public { }


    function finish_userstory(bytes32 storekey, uint ProjectID, uint Userstorynumber) public returns (bool){
        // todo: in withdrow module check require check that userstory finished

    }
}