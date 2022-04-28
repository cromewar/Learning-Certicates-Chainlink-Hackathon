//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC4671.sol";

contract Certificates is ERC4671 {
    constructor() ERC4671("Certificates", "CERT") {}

    uint256 public tokenID;

    function mintNewCertificate(address _newOwner) public {
        require(_isCreator(), "You must be the contract creator");
        tokenID = _mint(_newOwner);
    }

    function getTokenId() public view returns (uint256) {
        return tokenID;
    }

    function _baseURI() internal pure override returns (string memory) {
        return
            "ipfs://Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json";
    }
}
