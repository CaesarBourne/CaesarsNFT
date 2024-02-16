// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract CaesarNFT is ERC721, Ownable {

    using Strings for uint256;
    uint public constant MAX_SUUPPLY = 10;
    uint public price = 0.001 ether;
    uint public tokenId = 1;
    string _baseUri;

    constructor () ERC721 ("CaesarNFT", "CSR"){}
    event NFTMinted(address indexed minter , uint indexed tokenId);

    function tokenURI (uint256 _tokenIfd) public view override returns(string memory){
        require(_exists(_tokenIfd), "The URI does not exist for this token ");
        string memory baseURI 
    }
}