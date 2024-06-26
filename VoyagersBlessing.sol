// SPDX-License-Identifier: MIT

//    ###########   ###   ####   ##########        ##        ###     ###   ########    ###   ###  
//    #########     ### ####     ##########       ####       ####    ###   #########    ### ###   
//         ###      #####        ###             ######      ######  ###   ###    ###    #####    
//       ###  ###   #####        ###            ###  ###     ###  ######   ###    ###     ###     
//     ##########   ### ####     ##########    ### ######    ###    ####   #########      ###     
//    ###########   ###   ####   ##########   ###  #######   ###     ###   ########       ###     
//
//    LINKTR.EE/ZKCANDY            HYPERSCALING  WEB3  ENTERTAINMENT          HTTPS://ZKCANDY.IO

//    ~"~._.~"~. May your Voyage unto the ZKcandy Sepolia Testnet be a fruitful one. ~._.~"~._.~

pragma solidity ^0.8.20;

contract VoyagersBlessing {

//  address constant patronSaint = 0xfeb65CC3fe7490e71D929f37b14B516db627B877;
    address constant patronSaint = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    bool public blessingsSent;
    address[1000] public theVoyagers;

    // Initialise blessingShare to 0.25 SepETH
    uint256 private blessingShare = 250000000000000000;

//    constructor (address[1000] memory voyagersList) {
//        theVoyagers = voyagersList;
//    }

    receive() external payable {}

    modifier saintOnly() {
        require (msg.sender == patronSaint, "The power to call this function is only bestowed upon the patron saint.");
        _;
    }

    function checkBalance () public view returns (uint256) {
        return (address(this).balance);
    }

    function ponderBlessingShare (uint256 _newBlessingShare) saintOnly public {
        blessingShare = _newBlessingShare;
    }

    function checkBlessingShare () saintOnly public view returns (uint256) {
        return blessingShare;
    }

    function beforeTheBlessing () private view returns (bool) {
        bool blessingPossible;
        if ((blessingShare * 1000) <= (checkBalance())) {
            blessingPossible = true;
        } else {
            blessingPossible = false;
        }
        return blessingPossible;
    }

    function bequeathBlessings() saintOnly external returns (string memory) {
        require (beforeTheBlessing() == true, "Insufficient balance to complete the blessing. Please make adjustments.");
        for (uint256 i = 0; i < theVoyagers.length; i++) {
            (bool blessingSuccess, ) = theVoyagers[i].call{value: blessingShare}("");
          require(blessingSuccess, "The blessing was not successfully bequeathed.");
        }

        return ("The blessings have been bequeathed upon the Voyagers.");
   }

    function emptyBalance () saintOnly public {
        (bool drainSuccess, ) = patronSaint.call{value: address(this).balance}("");
        require(drainSuccess, "The blessing was not successfully bequeathed.");
    }

}