// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract Bear is Ownable, ERC721 {

    struct Metadata {
        string URI;
        uint256 rarity;
    }


    mapping(uint256 => Metadata) id_to_bear_token;

    string private _currentBaseURI;
    uint256 private _tokenIds = 0;


    uint256 private MAX_GIVE_AWAY = 120;
    uint256 private PRE_SALE = 1000;
    uint256 private MAX_NFTS =10000;

    bool private PRE_SALE_ON;


    constructor() ERC721("Polar Pals", "PALS") {
        // mintBatch('test', 2, MAX_GIVE_AWAY);

    }


    function startPreSale() public onlyOwner {
            PRE_SALE_ON = true;
    }

    function stopPreSale() public onlyOwner {
            PRE_SALE_ON = false;
    }

    function getCurrentNFTAmount() public  returns (uint256){
        return MAX_NFTS;
    }

    function getPreSaleNFTAmount() public   returns (uint256){
        return PRE_SALE;
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
       _setTokenURI(newItemId, tokenURI );

        if(PRE_SALE_ON){
             PRE_SALE = PRE_SALE -1 ;
        }

       else MAX_NFTS = MAX_NFTS - 1;
       return newItemId;
   }

    function claim(string memory tokenURI) external payable returns (uint256){
        require(MAX_NFTS > 0);
        require(msg.value == 0.069 ether, "claiming 0.069 ether");
        if(PRE_SALE_ON){
            require(PRE_SALE>0);
        }
        uint256 rarity = 2; // This should generated based on the probablity map 
        uint256 id = mintNFT(tokenURI,rarity);
        payable(owner()).transfer(0.069 ether);
        return id;
    }

    function claim_2(string memory tokenURI) external payable returns (uint256[] memory){
        require(MAX_NFTS > 0);
        require(msg.value == 0.138 ether, "claiming 0.138 ether");
          if(PRE_SALE_ON){
            require(PRE_SALE>0);
        }
        uint256 rarity = 2; // This should generated based on the probablity map 
        uint256[] memory id = mintBatch(tokenURI,rarity,2);
        payable(owner()).transfer(0.138 ether);
        return id;
    }

    function claim_5(string memory tokenURI) external payable returns (uint256[] memory){
        require(MAX_NFTS > 0);
        require(msg.value == 0.345 ether, "claiming 0.345 ether");
          if(PRE_SALE_ON){
            require(PRE_SALE>0);
        }
        uint256 rarity = 2; // This should generated based on the probablity map 
        uint256[] memory id = mintBatch(tokenURI,rarity,5);
        payable(owner()).transfer(0.345 ether);
        return id;
    }


    function claim_10(string memory tokenURI) external payable returns (uint256[] memory){
        require(MAX_NFTS > 0);
        require(msg.value == 0.69 ether, "claiming 0.69 ether");
          if(PRE_SALE_ON){
            require(PRE_SALE>0,"Out of PRE_SALE Tokens");
        }
        uint256 rarity = 2; // This should generated based on the probablity map 
        uint256[] memory id = mintBatch(tokenURI,rarity,10);
        payable(owner()).transfer(0.69 ether);
        return id;
    }


    function claim_20(string memory tokenURI) external payable returns (uint256[] memory){
        require(MAX_NFTS > 0);
        require(msg.value == 1.38 ether, "claiming 0.20 ether");
        require(PRE_SALE_ON == false);
        uint256 rarity = 2; // This should generated based on the probablity map 
        uint256[] memory id = mintBatch(tokenURI,rarity,20);
        payable(owner()).transfer(1.38  ether);
        return id;
    }



    function claim_10_GiveAway(string memory tokenURI) onlyOwner external returns (uint256[] memory){
        require(MAX_NFTS > 0);
        uint256 rarity = 2; // This should generated based on the probablity map 
        uint256[] memory id = mintBatch(tokenURI,rarity,10);
        return id;
    }


    function mintBatch(string memory tokenURI,uint256 rarity,uint256 numberOfTokens) private returns (uint256[] memory){
        uint256[] memory NFT_ID_ARRAY = new uint256[](numberOfTokens);
        for(uint temp = 0; temp < numberOfTokens; temp++) {
             uint256 id = mintNFT(tokenURI,rarity);
             NFT_ID_ARRAY[temp] = id;   
        }

        return NFT_ID_ARRAY;
    }

}