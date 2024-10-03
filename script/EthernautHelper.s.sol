// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract EthernautHelper is Script {
    address public ethernaut = 0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6;

    function submitLevelInstance(address instance) public {
        vm.startBroadcast();

        (bool result, bytes memory data) = ethernaut.call(abi.encodeWithSignature("submitLevelInstance(address)", instance));

        vm.stopBroadcast();

        console.log("submit instance %s, result %d", instance, result);
        console.logBytes(data);
    }

    function createLevelInstance(address level, uint256 value) public {
        vm.startBroadcast();

        (bool result, bytes memory data) = ethernaut.call{value: value}(abi.encodeWithSignature("createLevelInstance(address)", level));

        vm.stopBroadcast();

        console.log("create instance, level %s, value %d, result %d", level, value, result);
        console.logBytes(data);
    }
}