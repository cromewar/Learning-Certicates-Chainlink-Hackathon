//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC4671.sol";

contract Certificates is ERC4671 {
    mapping(address => uint256) public OwnerToId;

    string internal ipfsHash;

    // Events
    event newCertificateCreated(address owner, uint256 id);

    constructor(string memory _certificateName, string memory _tokenName)
        ERC4671(_certificateName, _tokenName)
    {}

    // This function creates a new Certificate and relates the owner
    // address which the corresponding id

    function createCertificate(address owner) public {
        require(_isCreator(), "You must be the contract creator");
        _mint(owner);
        OwnerToId[owner] = emittedCount();
        emit newCertificateCreated(owner, OwnerToId[owner]);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        _getTokenOrRevert(tokenId);
        bytes memory baseURI = bytes(_baseURI());
        if (baseURI.length > 0) {
            return
                string(
                    abi.encodePacked(
                        baseURI,
                        ipfsHash,
                        Strings.toString(tokenId),
                        ".json"
                    )
                );
        }
        return "";
    }

    function setTokenUri(string memory _ipfsCode) public {
        ipfsHash = _ipfsCode;
    }
}
