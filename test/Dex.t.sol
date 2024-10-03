// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Math} from "openzeppelin-contracts-08/utils/math/Math.sol";
import {Dex, SwappableToken} from "../src/Dex.sol";

contract DexTest is Test {
    address public player;
    Dex public dex;

    address public token1;
    address public token2;

    function setUp() public {
        player = makeAddr("player");
        dex = new Dex();

        (token1, token2) = mintToken(address(dex), player);
        dex.setTokens(token1, token2);
    }

    function mintToken(address dex, address player) private returns(address, address) {
        address supplier = makeAddr("supplier");

        vm.startPrank(supplier, supplier);
        SwappableToken token1 = new SwappableToken(dex, "token1", "", 110);
        SwappableToken token2 = new SwappableToken(dex, "token2", "", 110);

        token1.transfer(player, 10);
        token2.transfer(player, 10);

        token1.transfer(dex, 100);
        token2.transfer(dex, 100);

        vm.stopPrank();
        console.log("dex token1 %d token2 %d", token1.balanceOf(dex), token2.balanceOf(dex));
        console.log("player token1 %d token2 %d", token1.balanceOf(player), token2.balanceOf(player));

        return (address(token1), address(token2));
    }

    function testDex() public {
        vm.startPrank(player, player);

        dex.approve(address(dex), 200);

        swap(token1, token2, dex, player, true);
        swap(token1, token2, dex, player, false);
        swap(token1, token2, dex, player, true);
        swap(token1, token2, dex, player, false);
        swap(token1, token2, dex, player, true);
        swap(token1, token2, dex, player, false);

        console.log("dex token 1 %d token2 %d", SwappableToken(token1).balanceOf(address(dex)), SwappableToken(token2).balanceOf(address(dex)));

        vm.stopPrank();
    }

    function swap(address token1, address token2, Dex dex, address player, bool direction) private {
        address from;
        address to;

        if (direction) {
            from = token1;
            to = token2;
        } else {
            from = token2;
            to = token1;
        }

        uint256 amount = Math.min(SwappableToken(from).balanceOf(address(player)), SwappableToken(from).balanceOf(address(dex)));
        if (amount == 0) {
            return;
        }

        dex.swap(from, to, amount);
        console.log("player token1 %d token2 %d", SwappableToken(token1).balanceOf(player), SwappableToken(token2).balanceOf(player));
    }
}