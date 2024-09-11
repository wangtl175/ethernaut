// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";

contract NaughtCoinTest is Test {
    function testNaughtCoin() public {
        address player = makeAddr("player");
        address player1 = makeAddr("player1");

        vm.startPrank(player, player);
        NaughtCoin coin = new NaughtCoin(player);

        coin.approve(player, 1000000000000000000000000);
        coin.transferFrom(player, player1, 1000000000000000000000000);
        console.log(coin.balanceOf(player));

        vm.stopPrank();
    }
}