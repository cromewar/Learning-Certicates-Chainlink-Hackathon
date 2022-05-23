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
        address _owner,
        string memory _tokenURI
    ) public {
        require(_isCreator(), "You must be the contract creator");
        _mint(_owner);
        OwnerToId[_owner] = emittedCount();
        _setTokenURI(OwnerToId[_owner], _tokenURI);
        emit newCertificateCreated(_owner, OwnerToId[_owner]);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }
}
