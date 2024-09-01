// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

pragma experimental ABIEncoderV2;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Token} from "../src/Token.sol";

// run with fork sepolia
contract TokenTest is Test {
    Token public token;
    address public player;

    function setUp() public {
        player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;

        token = Token(0x0887300dfEDAc8F22e27C8024eD36B91c99642E6);
    }

    function testToken() public {
        console.log(token.balanceOf(player));

        address otherPlayer = makeAddr("other");

        vm.prank(player);
        token.transfer(otherPlayer, 21);

        console.log(token.balanceOf(player));
        console.log(token.balanceOf(otherPlayer));

        assert(token.balanceOf(player) > 20);
    }
}