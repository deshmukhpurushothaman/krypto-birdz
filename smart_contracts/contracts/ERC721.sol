// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * TO build minting function:
 *  NFT to point to an address
 *  Keep track of all token ids
 *  Keep track of the owner of NFT
 *  Keep track of number of NFT's a person owns
 *  Events to emit transfer logs - contract address, minted to, id
 */

contract ERC721 {
    // Variables
    mapping(uint256 => address) private _tokenOwner; // Map tokenId to owner address
    mapping(address => uint256) private _OwnerTokenCount; // Map number of tokens owned by each user/address

    // Events
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    // Check if a NFT was already minted
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId]; // fetching token owner for the provided tokenid
        return owner != address(0); // return true owner
    }

    // Mint new NFT's or tokens
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: Minting to the zero address");
        require(!_exists(tokenId), "ERC721: Token id already exists");

        _tokenOwner[tokenId] = to; // Mapping address to tokenId
        _OwnerTokenCount[to] += 1; // Mapping number of tokens to address
        emit Transfer(address(0), to, tokenId);
    }
}
