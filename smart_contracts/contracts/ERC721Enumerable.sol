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
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    // Add data for tracing with the help of token
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    // Add data for tracing with the helop of owner
    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    // Get token by index
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(
            index < totalSupply(),
            "ERC721Enumerable: index out of bounds for _tokenByIndex"
        );
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256)
    {
        require(
            index < balanceOf(owner),
            "ERC721Enumerable: owner index out of bounds for _tokenOfOwnerByIndex"
        );
        return _ownedTokens[owner][index];
    }

    // Get number of tokens/NFT's minted
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }
}
