// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {MagicNum} from "../src/MagicNum.sol";

/*
https://medium.com/coinmonks/ethernaut-lvl-19-magicnumber-walkthrough-how-to-deploy-contracts-using-raw-assembly-opcodes-c50edb0f71a2

https://medium.com/zeppelin-blog/deconstructing-a-solidity-contract-part-i-introduction-832efd2d7737
*/

/*
cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY --create 0x600a600c600039600a6000f3602a60805260206080f3

tx: https://sepolia.etherscan.io/tx/0xb61bebd0866cb4309202d39e9c950ea9038e51011fe65b324a50dbc0b2e55ae1
*/

contract MagicNumTest is Test {
    // forge test -vvvv --match-test testMagicNum --fork-url https://ethereum-sepolia-rpc.publicnode.com
    function testMagicNum() public {
        address solver = 0x74ADFF533eC399BfFd0e5b021B3fc9155cAE0664;
//        MagicNum magicNum = MagicNum(0xf056eeD7F934EA6C9e8B9Db0d341854b3cD16Dc7);
//        address solver = magicNum.solver();

        (bool result, bytes memory data) = solver.call(abi.encodeWithSignature("whatIsTheMeaningOfLife()"));

        console.log(result);
        console.logBytes(data);
    }
}