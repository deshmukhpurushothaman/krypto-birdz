// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 r = a + b;
        require(r >= a, "SafeMath: Addition overflow");
        return r;
    }

    function subtract(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: Subtraction overflow");
        uint256 r = a - b;
        return r;
    }

    function multiply(uint256 a, uint256 b) internal pure returns (uint256) {
        // For gas optimization
        if (a == 0 || b == 0) {
            return 0;
        }
        uint256 r = a * b;
        require(r / a == b, "SafeMath: Multiplication overflow");
        return r;
    }

    function divide(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: Division overflow");
        uint256 r = a / b;
        return r;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: Modulus overflow");
        uint256 r = a % b;
        return r;
    }
}
