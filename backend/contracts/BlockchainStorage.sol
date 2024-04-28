// I'm a comment!
// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;

contract BlockchainStorage {
    struct People {
        string email;
        string name;
    }
    // uint256[] public anArray;
    People[] public people;

    // mapping(string => uint256) public nameToFavoriteNumber;
    mapping(string => string[]) public userToPublishedCoins;
    mapping(string => string) public userToBalance;
    mapping(string => mapping(string => string)) public userToCoins;

    function register(string memory name, string memory email) public virtual {
        people.push(People({email: email, name: name}));
    }

    function publish_song(
        string memory user_id,
        string memory coin_id
    ) public virtual {
        userToPublishedCoins[user_id].push(coin_id);
    }

    function update_wallet(
        string memory user_id,
        string memory balance
    ) public virtual {
        userToBalance[user_id] = balance;
    }

    function update_portfolio_coin(
        string memory user_id,
        string memory coin_id,
        string memory amount
    ) public virtual {
        userToCoins[user_id][coin_id] = amount;
    }

    // function retrieve() public view returns (uint256) {
    //     return favoriteNumber;
    // }

    // function addPerson(string memory _name, uint256 _favoriteNumber) public {
    //     people.push(People(_favoriteNumber, _name));
    //     nameToFavoriteNumber[_name] = _favoriteNumber;
    // }
}
