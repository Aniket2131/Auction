//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract auctionContract {
    bool public auctionStarted;

    address payable public auctioneer;
    uint public auctionEndTime;

    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public previousBidder;


    constructor(address payable _auctioneer) {
        auctioneer = _auctioneer;       
    }


    modifier onlyStartedBy {
        require(msg.sender == auctioneer, "You does not have Authority to Start the Auction! ");
        _;
    }
    function startContract(uint _auctionEndTime) public onlyStartedBy {
        auctionEndTime = _auctionEndTime + block.timestamp;
        auctionStarted = true;
    }

    modifier onlyEndedBy {
        require(msg.sender == auctioneer, "You does not have Authority to End the Contract! ");
        _;
    }
    function endContract() public onlyEndedBy {
        if(auctionStarted == false) revert("The auction is already Ended! ");
        if(block.timestamp >= auctionEndTime) revert("The auction is Ended! ");
        
        auctionStarted = false;

    }

    event highestBidChanged(address bidder, uint amount);
    function makeBid() public payable {
        if(auctionStarted == false) revert("The auction has not started! ");
        if(block.timestamp >= auctionEndTime) revert("The auction has been already Ended! ");
        require(msg.sender != auctioneer, "You are not allowed to participate in the auction");
 
        if(highestBid > msg.value) revert("Please Try to make a big bid!"); 
        if(highestBid != 0) previousBidder[highestBidder] += highestBid;

        highestBidder = msg.sender;
        highestBid = msg.value;

        emit highestBidChanged(msg.sender, msg.value); 
    }


    modifier onlyFinalisedBy {
        require(msg.sender == auctioneer, "You are not allowed to Finalised the contract! ");
        _;
    }
    modifier onlyAfter() {
        require(auctionStarted == false, "The Auction is not Ended yet");
        _;
    }
    function finaliseAuction() public onlyFinalisedBy onlyAfter {
        auctioneer.transfer(highestBid);    
    }
    function withdraw() external payable onlyAfter returns(bool) {
        uint amount = previousBidder[msg.sender];

        if(amount > 0) previousBidder[msg.sender] = 0;
        if(!payable(msg.sender).send(amount)) 
            {previousBidder[msg.sender] = amount;
            return false;
            }

        return true;    
    }
    function getAuctionDetails() public view returns(address _owner, address _highestBidder, uint _highestBid) {
        return (auctioneer, highestBidder, highestBid);
    }
}