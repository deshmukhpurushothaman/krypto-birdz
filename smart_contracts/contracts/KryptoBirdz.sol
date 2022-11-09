// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

contract KryptoBird is ERC721Connector {
    // Inherits the connector contract and passes name and symbol
    constructor() ERC721Connector("KryptoBird", "KBZ") {}

    string[] public kryptoBirdz;
    mapping(string => bool) _kryptoBirdExists;

    function mint(string memory _kryptoBird) public {
        require(!_kryptoBirdExists[_kryptoBird], "Error: Krypto Bird Exists");
        kryptoBirdz.push(_kryptoBird);
        uint256 _id = kryptoBirdz.length - 1;
        _mint(msg.sender, _id);
        _kryptoBirdExists[_kryptoBird] = true;
    }
}
