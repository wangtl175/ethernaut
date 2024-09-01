// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

pragma experimental ABIEncoderV2;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    Token public token;
    address public player;

    function setUp() public {
        token = Token(0x0887300dfEDAc8F22e27C8024eD36B91c99642E6);
        player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;
    }

    function run() public {
        vm.startBroadcast();
        console.log(token.balanceOf(player));

        address other = makeAddr("other");
        token.transfer(other, 21);

        console.log(token.balanceOf(player));

        vm.stopBroadcast();
    }
}