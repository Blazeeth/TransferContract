// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract TokenAirdrop {
    address public owner;

    // Event to log successful airdrops
    event TokensAirdropped(address indexed token, address indexed recipient, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Function to airdrop tokens to multiple recipients
    function airdropTokens(address token, address[] memory recipients, uint256[] memory amounts) 
        external 
        onlyOwner 
    {
        require(recipients.length == amounts.length, "Mismatched arrays");
        require(token != address(0), "Invalid token address");

        IERC20 erc20 = IERC20(token);

        for (uint256 i = 0; i < recipients.length; i++) {
            require(recipients[i] != address(0), "Invalid recipient address");
            bool success = erc20.transfer(recipients[i], amounts[i]);
            require(success, "Token transfer failed");
            emit TokensAirdropped(token, recipients[i], amounts[i]);
        }
    }
}
