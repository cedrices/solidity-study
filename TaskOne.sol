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

    //*************========== 整形转罗马字符串  begin ======================
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
   //*************========== 整形转罗马字符串  end ======================
  

  //*************========== 罗马字符串转整形  begin ======================
   function romanToInt(string memory roman) public pure returns (uint256) {
        bytes memory r = bytes(roman);
        uint256 result = 0;

        for (uint256 i = 0; i < r.length; i++) {
            uint256 current = charToValue(r[i]);

            // 检查下一个字符是否存在，并判断是否为“减法”情况
            if (i + 1 < r.length) {
                uint256 next = charToValue(r[i + 1]);
                if (current < next) {
                    result = next - current; // 减法情况：IV, IX, XL, XC, CD, CM
                    i = i + 1;
                } else {
                    result += current;
                }
            } else {
                result += current; // 最后一个字符，直接加
            }
        }

        return result;
    }


    function charToValue(bytes1 c) internal pure returns (uint256) {
        if (c == 'I') return 1;
        if (c == 'V') return 5;
        if (c == 'X') return 10;
        if (c == 'L') return 50;
        if (c == 'C') return 100;
        if (c == 'D') return 500;
        if (c == 'M') return 1000;
        return 0; // 无效字符（可选：revert 抛出错误）
    }
    //*************========== 罗马字符串转整形  end ======================


    //****========= 合并两个有序数组 (Merge Sorted Array) =========
    function mergeIntoNewArray(uint256[] memory nums1, uint256[] memory nums2) public pure returns (uint256[] memory) {
        uint256 m = nums1.length;
        uint256 n = nums2.length;
        uint256[] memory result = new uint256[](m + n);

        uint256 i = 0;
        uint256 j = 0;
        uint256 k = 0;

        while (i < m && j < n) {
            if (nums1[i] <= nums2[j]) {
                result[k] = nums1[i];
                i++;
            } else {
                result[k] = nums2[j];
                j++;
            }
            k++;
        }

        // 复制剩余元素
        while (i < m) {
            result[k] = nums1[i];
            i++;
            k++;
        }

        while (j < n) {
            result[k] = nums2[j];
            j++;
            k++;
        }

        return result;
    }

    //********====  二分查找 (Binary Search)在一个有序数组中查找目标值。
     function binarySearch(uint256[] memory arr, uint256 target) public pure returns (uint256) {
        uint256 left = 0;
        uint256 right = arr.length; // 注意：right 是开区间，即 arr.length

        while (left < right) {
            uint256 mid = left + (right - left) / 2; // 防止整数溢出

            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid; // 因为 right 是开区间
            }
        }

        return type(uint256).max; // 未找到，返回最大值表示 not found
    }
}