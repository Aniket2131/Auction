Contract Deployed at:
Etherscan url:

https://goerli.etherscan.io/tx/0xa27add9b273d76d1313193daa8a26a2a53919aa29172ae674453e47cb275295d

steps for Auction contract:

1. Before deploying one need to add an address of the owner of auction which is asked in the constructor at line 16, which will be set on the global variable named ayctioneer.
2. After Deploying one need to run start contract function of line 25 by giving the time interval in second, till which the auction will be live. This function will make the global variable named auction Started to be true as it was false by default.
3. start contract function is only run by the auctioneer which is stated in the modifiew at line 21.
4. Now any one can place a bid and its name and value is going to store in the global variable higgesh bidder and highest bid respectively.
5. There are certain condition which need to be fulfill in order to place a bid:
   1. One should not be the owner or auctioneer of the contract: line - 46
   2. the auction started global variable must be true. line - 44
   3. Also once bid amount must be higher than the previous bids. line - 48
      If the bid amount is more than the previous bid amounts then an event is fired which will change the highest Bid and highest Bidder. line - 42
6. As the time limit of the contract will be more than the set time than bidding will be stoped.
7. The end contract function will stop the bidding at any time interval but this can be only called by the auctioneer as stated in modifier. line - 30
8. After ending the contract an auctioneer need to run the function named finalise Auction which will transfer the highest bidding amount to the auctioner.
9. withdraw function will let other participent to get their bidding amount back except the highest bidder, once the contract is ended.
10. At the end any one can see the auctioneer, highest Bid and the Higestbidder of the auction by running the getAuctionDetails function.
