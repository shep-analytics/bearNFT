// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Bear is Ownable, ERC721 {

    struct Metadata {
        uint256 id;
        string URI;
        uint256 rarity;
    }

    mapping(uint256 => Metadata) id_to_bear_token;

    string private _currentBaseURI;
    uint256 private _tokenIds = 0;

    constructor() ERC721("Bear", "BEAR") {
        setBaseURI("ipfs://");
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _currentBaseURI = baseURI;
        _setBaseURI(_currentBaseURI);
    }

    function _baseURI() public view virtual  returns (string memory) {
        return _currentBaseURI;
    }

     function mintNFT(string memory tokenURI, uint256 rarity) internal returns (uint256) {
       _tokenIds = _tokenIds + 1;
       uint256 newItemId = _tokenIds;
       _safeMint(msg.sender, newItemId);
    //    _fullURI = string(abi.encodePacked(_currentBaseURI,tokenURI));
       _setTokenURI(newItemId, tokenURI );
       return newItemId;
   }

    function claim(string memory tokenURI) external payable returns (uint256){
        require(msg.value == 0.01 ether, "claiming 0.01 ether");
        uint256 rarity = 2; // This should generated based on the probablity map 
        uint256 id = mintNFT(tokenURI,rarity);
        payable(owner()).transfer(0.01 ether);
        return id;
    }


   

}