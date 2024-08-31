pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {CoinFlipAttack} from "../src/CoinFlipAttack.sol";

contract CoinFlipAttackScript is Script {
    function run() public {
        vm.startBroadcast();
        CoinFlipAttack attack = new CoinFlipAttack();

        console.log("develop contract on %s", address(attack));
        vm.stopBroadcast();
    }
}