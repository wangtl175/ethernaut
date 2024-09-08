// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Privacy} from "../src/Privacy.sol";

contract PrivacyTest is Test {
    /*
    实例地址: 0xb28122989a9D47ddeAe19552B149f675186387a2
    创建实例: https://sepolia.etherscan.io/tx/0xc861bfe23852f9f034151e83a03d28eea40ab270071f2ed15f84872bc396c8c5#statechange
    根据Privacy的内存布局，data的三个元素应该是:
    0xf09788cb9886f9f8ecd7a3b0703683470a011112604d3650168f1636ba05158b
    0x1bca9d3714f48221ae03de60d835cd630012801628b37868c572a4e7f7e3a323
    0x3136b39c831718cf5c66c320860e00ca9a6038e462ac6f2680d3c2ece289f69f
    */


    function testPrivacy() public {
        Privacy privacy = Privacy(0xb28122989a9D47ddeAe19552B149f675186387a2);
        bytes32 data2 = 0x3136b39c831718cf5c66c320860e00ca9a6038e462ac6f2680d3c2ece289f69f;

        console.log("privacy lock %d", privacy.locked());
        privacy.unlock(bytes16(data2));
        console.log("privacy lock %d", privacy.locked());
    }
}