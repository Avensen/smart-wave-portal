// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves = 0;

    constructor() {
        console.log("Smart contract over here");
    }

    function Wave() public {
            totalWaves++;
            console.log("%s has waved you!", msg.sender);
    }

    function GetTotalWaves() public view returns(uint256) {
        console.log("A total of of %d people waved", totalWaves);
        return totalWaves;
    }
}

// HTTP Key: https://eth-rinkeby.alchemyapi.io/v2/8nCrQ3BdjonrbfqIvrmrAliHQwBZI7N3