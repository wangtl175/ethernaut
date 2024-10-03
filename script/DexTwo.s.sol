// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {DexTwo, SwappableTokenTwo} from "../src/DexTwo.sol";

contract DexTwoScript is Script {
    function run() public {
        DexTwo dex = DexTwo(0x6dBA3F5bE61724e05761e8619ec6492605Ed9A4a);
        SwappableTokenTwo token1 = SwappableTokenTwo(0x5D7A5478bf35CD8Ba1D7f487620b52420094A450);
        SwappableTokenTwo token2 = SwappableTokenTwo(0x30Eb987261BF96D0596fBDC1761aF648f776BD94);
        address player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;

        vm.startBroadcast();

        SwappableTokenTwo token3 = new SwappableTokenTwo(address(dex), "TKN3", "", 1000);
        token3.approve(player, address(dex), 1000);

        token3.transfer(address(dex), 100);
        dex.swap(address(token3), address(token1), 100);

        dex.swap(address(token3), address(token2), 200);

        console.log("dex token1 %d token2 %d token3 %d", token1.balanceOf(address(dex)), token2.balanceOf(address(dex)), token3.balanceOf(address(dex)));

        vm.stopBroadcast();
    }
}