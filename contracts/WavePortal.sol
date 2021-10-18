// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Smart contract over here");
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves++;
        console.log("%s has waved you!", msg.sender);
        waves.push(Wave(msg.sender, _message, block.timestamp));

        uint256 randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %s", randomNumber);
        seed = randomNumber;

        if (randomNumber < 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.00001 ether;
            
            require(prizeAmount <= address(this).balance, "Trying to withdraw more money than the contract has.");
            
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

     function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns(uint256) {
        console.log("A total of of %d people waved", totalWaves);
        return totalWaves;
    }
}

// HTTP Key: https://eth-rinkeby.alchemyapi.io/v2/8nCrQ3BdjonrbfqIvrmrAliHQwBZI7N3
// WavePortal address:  0x7F013f7089F5bf64451aB4e5FE6f88b446B42e39
