// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeNews {
    address public admin;

    enum AccessType { Public, Restricted }

    struct Article {
        uint256 id;
        string title;
        address author;
        string hash; 
        uint256 timestamp;
        AccessType access;
    }

    Article[] private articles;
    mapping(address => uint256[]) private authorArticles;
    mapping(address => bool) public isAuthor;

    constructor() {
        admin = msg.sender;
        isAuthor[admin] = true;
    }
    
    modifier onlyAuthor() {
        require(isAuthor[msg.sender], "Not authorized to publish");
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    function addAuthor(address _author) external onlyAdmin {
        isAuthor[_author] = true;
    }
    
    function getArticleCount() public view returns (uint256) {
        return articles.length;
    }
    
    function publishArticle(
        string memory _title,
        string memory _offChainHash,
        AccessType _access
    ) public onlyAuthor {
        require(bytes(_offChainHash).length == 46, "Invalid IPFS hash");
        uint256 id = articles.length;

        articles.push(Article({
            id: id,
            title: _title,
            author: msg.sender,
            hash: _offChainHash,
            timestamp: block.timestamp,
            access: _access
        }));

        authorArticles[msg.sender].push(id);
    }
    
    function getArticle(uint256 _id) public view returns (
        uint256 id,
        string memory title,
        address author,
        string memory hash,
        uint256 timestamp,
        AccessType access
    ) {
        require(_id < articles.length, "Article doesn't exist");
        Article memory article = articles[_id];

        if (article.access == AccessType.Restricted) {
            require(
                msg.sender == article.author || msg.sender == admin,
                "Restricted article"
            );
        }

        return (
            article.id,
            article.title,
            article.author,
            article.hash,
            article.timestamp,
            article.access
        );
    }
    
    function getArticlesByAuthor(address _author) public view returns (uint256[] memory) {
        return authorArticles[_author];
    }

}