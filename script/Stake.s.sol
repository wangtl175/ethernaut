// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {Stake} from "../src/Stake.sol";

// forge script ..... --evm-version shanghai

contract StakeScript is Script {
    Stake public stake = Stake(0x2dEC45dC10bfF519e83DEC103c9931b6CCfD6D54);
    address public weth = 0x42A09C3fbfb22774936B5D5d085e2FA7963b0db8;
    uint256 public stakeAmount = 0.0011 ether;

    function realStake() public {
        vm.startBroadcast();
        address(stake).call{value: stakeAmount + 1 wei}(abi.encodeWithSignature("StakeETH()"));
        vm.stopBroadcast();

        console.log("balance of stake %d", address(stake).balance);
    }

    function run() public {
        address player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;
        vm.startBroadcast();

        weth.call(abi.encodeWithSignature("approve(address,uint256)", address(stake), uint256(stakeAmount)));
        stake.StakeWETH(stakeAmount);
        stake.Unstake(stakeAmount);

        vm.stopBroadcast();

        console.log("total stake %d", stake.totalStaked());
        console.log("eth balance %d", address(stake).balance);
        console.log("staker %d", stake.Stakers(player));
        console.log("player stake balance %d", stake.UserStake(player));
    }
}