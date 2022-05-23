//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC4671.sol";
import "./ERC4671URIStorage.sol";

contract Course is ERC4671URIStorage {
    mapping(address => uint256) public OwnerToId;

    // Events
    event newCertificateCreated(address owner, uint256 id);
    event newTokenUriSet(address owner, uint256 id, string uri);

    constructor(string memory _courseName, string memory _tokenName)
        ERC4671(_courseName, _tokenName)
    {}

    // This function creates a new Certificate and relates the owner
    // address which the corresponding id
    // Also uses the setTokenURI to set up the IPFS token URI to the ERC-4671

    function createCertificate(address owner) public {
        require(_isCreator(), "You must be the contract creator");
        _mint(owner);
        OwnerToId[owner] = emittedCount();
        emit newCertificateCreated(owner, OwnerToId[owner]);
    }

    function createTokenURI(uint256 _tokenId, string memory _tokenURI) public {
        require(_isCreator(), "You must be the contract creator");
        _setTokenURI(_tokenId, _tokenURI);
        emit newTokenUriSet(
            getOwnerBasedOnIndex(_tokenId),
            _tokenId,
            _tokenURI
        );
    }

    function createCertificateAndSetToken(
        address owner,
        string memory _tokenURI
    ) public {
        require(_isCreator(), "You must be the contract creator");
        _mint(owner);
        OwnerToId[owner] = emittedCount();
        _setTokenURI(OwnerToId[owner], _tokenURI);
        emit newCertificateCreated(owner, OwnerToId[owner]);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }
}
