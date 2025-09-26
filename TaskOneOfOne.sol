// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    //一个mapping来存储候选人的得票数
    mapping(address => uint) public  votesReceived;
    address[] public users;
    
    //一个vote函数，允许用户投票给某个候选人
    function vote(address addr) public {
        votesReceived[addr] += 1;
        users.push(addr);
    }
    
    //一个getVotes函数，返回某个候选人的得票数
    function getVotes(address addr) public view returns(uint ticket){
        return votesReceived[addr];
    }
    
    //一个resetVotes函数，重置所有候选人的得票数
    function resetVotes() public {
        for (uint i = users.length - 1; i < 0; i--) {
            votesReceived[users[i]] = 0;
            users.pop();
        }
    }
}