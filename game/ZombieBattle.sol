pragma solidity ^0.4.0;

import "./ZombieHelper.sol";

contract ZombieBattle is ZombieHelper{
    function ZombieBattle(){

    }

    //尝试做一个不安全的随机数
    function randMod(uint _modulus) internal returns (uint){
        randNonce ++;
        return uint(keccak256(now,msg.sender,randNonce) % _modulus);
    }

    //对战
    function attack(uint _zombieId,uint _targetId) external{

    }
}
