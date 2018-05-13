pragma solidity ^0.4.21;

import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";

contract ExampleToken is StandardToken, DetailedERC20 {

    mapping (address => uint) mFreezeInfo;

    modifier notFrozen(address owner) {
        require(mFreezeInfo[owner] <= now);
        _;
    }

    constructor() public
        DetailedERC20("Test token", "FTK", 18)
    {
        balances[msg.sender] = 1000000 ether;
        totalSupply_ = balances[msg.sender];
        emit Transfer(address(0),msg.sender,totalSupply_);
    }

    function freeze(uint thawTS) public notFrozen(msg.sender) {
        //require(mFreezeInfo[msg.sender] <= now);
        mFreezeInfo[msg.sender] = thawTS;
    }

    function transferFrom(address _from, address _to, uint256 _value) public notFrozen(_from) returns (bool) {
        //require(mFreezeInfo[_from] <= now);
        return super.transferFrom(_from, _to, _value);
    }

    function transfer(address _to, uint256 _value) public notFrozen(msg.sender) returns (bool) {
        //require(mFreezeInfo[msg.sender] <= now);
        return super.transfer(_to, _value);
    }

}
