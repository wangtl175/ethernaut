// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

import {Telephone} from "../src/Telephone.sol";
import {TelephoneAttack} from "../src/TelephoneAttack.sol";

contract TelephoneTest is Test {
    Telephone public telephone;
    TelephoneAttack public telephoneAttack;
    address public owner;
    address public player;

    function setUp() public {
        owner = makeAddr("owner");
        player = makeAddr("player");

        vm.prank(owner);
        telephone = new Telephone();

        vm.prank(player);
        telephoneAttack = new TelephoneAttack();
    }

    function testTelephone() public {
        vm.startPrank(player);

        assert(telephone.owner() != player);

        telephoneAttack.changeOwner(telephone);

        assert(telephone.owner() == player);

        vm.stopPrank();
    }
}