// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract SubmitLevel is Script {
    address public ethernaut = 0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6;

    function run(address instance) public {
        vm.startBroadcast();

        (bool result, bytes memory data) = ethernaut.call{gas: 1000 wei}(abi.encodeWithSignature("submitLevelInstance(address)", instance));

        vm.stopBroadcast();

        console.log("submit instance %s, result %d", instance, result);
        console.logBytes(data);
    }
}