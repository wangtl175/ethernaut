// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {Shop, ShopAttack} from "../src/Shop.sol";

contract ShopTest is Test {
    function testShop() public {
        Shop shop = new Shop();
        ShopAttack attack = new ShopAttack(address(shop));

        console.log("price %d", shop.price());

        attack.buy();

        console.log("price %d", shop.price());
    }
}