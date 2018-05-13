pragma solidity ^0.4.18;

contract HelloWorld {
    string m_name;

    constructor(string name){
        m_name = name;
    }

    function hello() public view returns (string) {
        return m_name;
    }
}
