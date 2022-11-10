// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC721.sol";

contract ERC721Enumerable is ERC721 {
    uint256[] private _allTokens;
    mapping(uint256 => uint256) private _allTokensIndex; // from tokenId to position in _allTokens
    mapping(address => uint256[]) private _ownedTokens; // owner to list of all owner token ids
    mapping(uint256 => uint256) private _ownedTokensIndex; // from token id to index of the owner tokens list

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId); // Executes the inherited/overriden function
        _addTokensToTotalSupply(tokenId);
    }

    function _addTokensToTotalSupply(uint256 tokenId) private {
        _allTokens.push(tokenId);
    }

    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }
}
