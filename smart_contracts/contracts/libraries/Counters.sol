// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SafeMath.sol";

library Counters {
    using SafeMath for uint256;

    // keep track of arithmetic changes
    struct Counter {
        uint256 _value;
    }

    // memory - will remove the value once the function is over
    // storage - to keep in struct
    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function decrement(Counter storage counter) internal {
        // counter._value = counter._value.subtract(1);
        counter._value += 1;
    }

    function increment(Counter storage counter) internal {
        counter._value = counter._value.add(1);
    }
}
