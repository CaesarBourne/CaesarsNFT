// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract CaesarNFT is ERC721, Ownable {
    using Strings for uint256;
    uint public constant MAX_SUUPPLY = 10;
    uint public price = 0.001 ether;
    uint public tokenId = 1;
    string _baseUri =
        "ipfs://QmTJC2ewysg9KEKQ5nGXXpRKS4z8fiJVQ4gUshRJMdRdkM/1.json";

    // constructor() ERC721("CaesarNFT", "CSR") {}

    constructor(
        address initialOwner
    ) ERC721("MyToken", "MTK") Ownable(initialOwner) {}
    event NFTMinted(address indexed minter, uint indexed tokenId);

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        // require(_exists(_tokenId), "The URI does not exist for this token ");

        require(
            ownerOf(tokenId) != address(0),
            "The URI does not exist for this token "
        );

        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length != 0
                ? string(
                    abi.encodePacked(baseURI, _tokenId.toString(), ".json")
                )
                : "";
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseUri;
    }

    function mint() public payable {
        require(msg.value >= price, "Ether sent by user is not sufficient");
        require(tokenId <= MAX_SUUPPLY, "Sold out Token");
        _safeMint(msg.sender, tokenId);
        emit NFTMinted(msg.sender, tokenId);
        tokenId++;
    }

    function setBaseURI(string memory newBaseURI) external onlyOwner {
        _baseUri = newBaseURI;
    }

    function setPrice(uint newPrice) external onlyOwner {
        price = newPrice;
    }

    function withdraw() external onlyOwner {
        require(payable(msg.sender).send(address(this).balance));
    }
}
