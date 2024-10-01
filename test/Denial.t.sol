// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Denial, DenialAttack} from "../src/Denial.sol";

/*
使用循环将gas完全消耗
*/

contract DenialTest is Test {
    Denial public denial;
    DenialAttack public attack;

    function setUp() public {
        denial = new Denial();
        vm.deal(address(denial), 0.001 ether);

        attack = new DenialAttack();
        denial.setWithdrawPartner(address(attack));

        console.log("denial %s, attack %s", address(denial), address(attack));
    }

    function testDenial() public {
        console.log(address(denial).balance);
        console.log(denial.owner().balance);

        address player = makeAddr("player");
        vm.deal(player, 1 ether);

        vm.prank(player);
        address(denial).call{gas: 1000 wei}(abi.encodeWithSignature("withdraw()"));

        console.log(address(denial).balance);
        console.log(address(attack).balance);
        console.log(denial.owner().balance);
    }
}