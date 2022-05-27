//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC4671.sol";
import "./ERC4671URIStorage.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract Course is ERC4671URIStorage, VRFConsumerBase {
    mapping(address => uint256) public OwnerToId;

    // Events
    event newCertificateCreated(address owner, uint256 id);
    event newTokenUriSet(address owner, uint256 id, string uri);
    event RequestedRandomness(bytes32 requestId);
    event newRandomnessSetup(uint256 tokenId);

    // Owner og the course on the Factory Contract
    address public owner;
    address private newOwnerOfToken;

    // Variables for VRF
    uint256 public fee;
    bytes32 public keyhash;
    mapping(uint256 => uint256) public randomnessToId;

    constructor(
        string memory _courseName,
        string memory _tokenName,
        address _owner,
        address _vrfCoordinator,
        address _linkToken,
        uint256 _fee,
        bytes32 _keyhash
    )
        VRFConsumerBase(_vrfCoordinator, _linkToken)
        ERC4671(_courseName, _tokenName)
    {
        owner = _owner;
        fee = _fee;
        keyhash = _keyhash;
    }

    // This function creates a new Certificate and relates the owner
    // address which the corresponding id
    // Also uses the setTokenURI to set up the IPFS token URI to the ERC-4671

    function createCertificate(address ownerOfCertificate) public {
        require(owner == msg.sender, "You must be the contract owner");
        _mint(ownerOfCertificate);
        OwnerToId[ownerOfCertificate] = emittedCount();
        bytes32 requestId = requestRandomness(keyhash, fee);
        emit RequestedRandomness(requestId);

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
        newOwnerOfToken = _ownerOfCertificate;
        _setTokenURI(OwnerToId[_ownerOfCertificate], _tokenURI);
        bytes32 requestId = requestRandomness(keyhash, fee);
        emit RequestedRandomness(requestId);

        emit newCertificateCreated(
            _ownerOfCertificate,
            OwnerToId[_ownerOfCertificate]
        );
    }

    function getRandomnessBasedOnId(uint256 _indexOfToken)
        public
        view
        returns (uint256)
    {
        return randomnessToId[_indexOfToken];
    }

    function fulfillRandomness(bytes32 _requestId, uint256 _randomness)
        internal
        override
    {
        require(_randomness > 0, "Randomness not found");
        uint256 indexOfToken = OwnerToId[newOwnerOfToken];
        randomnessToId[indexOfToken] = _randomness;
        emit newRandomnessSetup(indexOfToken);
    }
}
