//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC4671.sol";
import "./ERC4671URIStorage.sol";

contract Certificates is ERC4671URIStorage {
    mapping(address => uint256) public OwnerToId;

    string internal ipfsHash;

    // Events
    event newCertificateCreated(address owner, uint256 id);

    constructor(string memory _certificateName, string memory _tokenName)
        ERC4671(_certificateName, _tokenName)
    {}

    // This function creates a new Certificate and relates the owner
    // address which the corresponding id
    // Also uses the setTokenURI to set up the IPFS token URI to the ERC-4671

    function createCertificate(address owner, string memory _tokenUri) public {
        require(_isCreator(), "You must be the contract creator");
        _mint(owner);
        OwnerToId[owner] = emittedCount();
        _setTokenURI(OwnerToId[owner], _tokenUri);
        emit newCertificateCreated(owner, OwnerToId[owner]);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }
}
