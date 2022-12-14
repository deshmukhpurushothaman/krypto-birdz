// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";
import "./libraries/Counters.sol";

/**
 * TO build minting function:
 *  NFT to point to an address
 *  Keep track of all token ids
 *  Keep track of the owner of NFT
 *  Keep track of number of NFT's a person owns
 *  Events to emit transfer logs - contract address, minted to, id
 */

contract ERC721 is ERC165, IERC721 {
    using SafeMath for uint256;
    using Counters for Counters.Counter;
    // Variables
    mapping(uint256 => address) private _tokenOwner; // Map tokenId to owner address
    mapping(address => Counters.Counter) private _OwnerTokenCount; // Map number of tokens owned by each user/address
    mapping(address => Counters.Counter) private _ownedTokensCount;
    mapping(uint256 => address) private _tokenApprovals;

    constructor() {
        _registerInterface(
            bytes4(keccak256("balanceOf(bytes4)")) ^
                bytes4(keccak256("ownerOf(bytes4)")) ^
                bytes4(keccak256("transferFrom(bytes4)"))
        );
    }

    // Returns the number of tokens or NFT's owned by the address/owner
    function balanceOf(address _owner) public view returns (uint256) {
        require(
            _owner != address(0),
            "ERC721: balanceOf owner query for non-existent token"
        );
        return _OwnerTokenCount[_owner].current();
    }

    // Returns the owner of the tokenId
    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(
            owner != address(0),
            "ERC721: ownerOf owner query for non-existent token"
        );
        return owner;
    }

    // Check if a NFT was already minted
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId]; // fetching token owner for the provided tokenid
        return owner != address(0); // return true owner
    }

    // Mint new NFT's or tokens
    function _mint(address to, uint256 tokenId) internal virtual {
        // virtual - method that is going to be overridden
        require(to != address(0), "ERC721: Minting to the zero address");
        require(!_exists(tokenId), "ERC721: Token id already exists");

        _tokenOwner[tokenId] = to; // Mapping address to tokenId
        _OwnerTokenCount[to].increment(); // Mapping number of tokens to address
        emit Transfer(address(0), to, tokenId);
    }

    function _transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        require(_to != address(0), "ERC721: Error transfer to zero address");
        require(
            ownerOf(_tokenId) == _from,
            "ERC721: Trying to tranfer a token with address code"
        );
        _ownedTokensCount[_from].decrement();
        _ownedTokensCount[_from].increment();
        _tokenOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public override {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);
        require(_to != owner, "ERC721: Trying to approve to current owner"); // Shouldn't transfer to owner itself
        require(msg.sender == owner, "ERC721: Unauthorized approval"); // Called by owner
        _tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
    }

    function isApprovedOrOwner(address spender, uint256 tokenId)
        internal
        view
        returns (bool)
    {
        require(_exists(tokenId), "ERC721: token does not exist");
        address owner = ownerOf(tokenId);
        require(spender == owner, "ERC721: Unauthorized approval"); // Called by owner
        // Write getApproved function on own similar to openzeppelin
    }
}
