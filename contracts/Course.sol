//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC4671.sol";
import "./ERC4671URIStorage.sol";

contract Course is ERC4671URIStorage {
    mapping(address => uint256) public OwnerToId;

    // Events
    event newCertificateCreated(address owner, uint256 id);
    event newTokenUriSet(address owner, uint256 id, string uri);

    address owner;

    constructor(
        string memory _courseName,
        string memory _tokenName,
        address _owner
    ) ERC4671(_courseName, _tokenName) {
        owner = _owner;
    }

    // This function creates a new Certificate and relates the owner
    // address which the corresponding id
    // Also uses the setTokenURI to set up the IPFS token URI to the ERC-4671

    function createCertificate(address ownerOfCertificate) public {
        require(owner == msg.sender, "You must be the contract owner");
        _mint(ownerOfCertificate);
        OwnerToId[ownerOfCertificate] = emittedCount();
        emit newCertificateCreated(ownerOfCertificate, OwnerToId[owner]);
    }

    function createTokenURI(uint256 _tokenId, string memory _tokenURI) public {
        require(owner == msg.sender, "You must be the contract owner");
        _setTokenURI(_tokenId, _tokenURI);
        emit newTokenUriSet(
            getOwnerBasedOnIndex(_tokenId),
            _tokenId,
            _tokenURI
        );
    }

    function createCertificateAndSetToken(
        address _ownerOfCertificate,
        string memory _tokenURI
    ) public {
        require(owner == msg.sender, "You must be the contract owner");
        _mint(_ownerOfCertificate);
        OwnerToId[_ownerOfCertificate] = emittedCount() - 1;
        _setTokenURI(OwnerToId[_ownerOfCertificate], _tokenURI);
        emit newCertificateCreated(
            _ownerOfCertificate,
            OwnerToId[_ownerOfCertificate]
        );
    }
}
