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


    //反转一个字符串。输入 "abcde"，输出 "edcba"
    function reverseStr(string memory param) public pure returns(string memory result)  {
            bytes memory bs = bytes(param);
            bytes memory dest = new bytes(bs.length);
            for (uint i = 0; i < bs.length; i ++) {
                dest[i] = bs[bs.length - 1 - i ];
            }
            return string(dest);
    }

    //
    mapping(uint => string) public romanNum;
    
    constructor () public {
     romanNum[1] = "I";
     romanNum[4] = "IV";
     romanNum[5] = "V";
     romanNum[9] = "IX";
     romanNum[10] = "X";
     romanNum[40] = "XL";
     romanNum[50] = "L";
     romanNum[90] = "XC";
     romanNum[100] = "C";
     romanNum[400] = "CD";
     romanNum[500] = "D";
     romanNum[900] = "CM";
     romanNum[1000] = "M";
    }
    
   
    
    function numToRoman(string memory param) public view returns(string memory result) {
        
        bytes memory bs = bytes(param);
        string memory four;
        string memory three;
        string memory two;
        string memory one;
        for (uint i = 0; i < bs.length; i++) {
            uint key = uint(uint8(bs[i]) - 48);
            if (key > 0) {
                //千位数
                if (bs.length - 1 - i == 3) {
                    four = numToRomanPrivate(key,1000);
                }
                //百位数
                if (bs.length - 1 - i == 2) {
                    uint numKey = uint(key * 100);
                    three = romanNum[numKey];
                    if (bytes(three).length == 0) {
                        three = numToRomanPrivate(key,100);
                    }
                }
                //十位数
                if (bs.length - 1 - i == 1) {
                    two = romanNum[key * 10];
                    if (bytes(two).length == 0) {
                        two = numToRomanPrivate(key,10);
                    }
                }
                //个位数
                if (bs.length - 1 - i == 0) {
                    one = romanNum[key];
                    if (bytes(one).length == 0) {
                        one = numToRomanPrivate(key,1);
                    }
                }
            }
        }
        result = string.concat(four,three,two,one);
         return result;
    }

    function numToRomanPrivate(uint len,uint key) private view returns(string memory result){
             string memory result;
             for (uint t = 0;  t < len; t++) {
                 result = string.concat(result,romanNum[key]);
             }
             return result;
    }
}