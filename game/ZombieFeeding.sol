pragma solidity ^0.4.19;

import "./ZombieFactory1.sol"; // ./ 表示当前目录
import "./KittyInterface.sol"; //注意是双引号

/// @auth
/// @dev 继承
contract ZombieFeeding is ZombieFactory {
    //状态变量一般存储在区块链上 storage
    //function .. { memory } 临时的

    //！特殊情况 主要用于处理函数内的 结构体和数组 必须手动声明


    //拒绝死代码
    //外部的调用
    //    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    //初始化外部合约
    //    KittyInterface kittyContract = KittyInterface(ckAddress);
    KittyInterface kittyContract;

    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    //僵尸的猎食和繁殖
    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];

        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;

        if (keccak256(_species) == keccak256("kitty")) {
            newDna = newDna - newDna % 100 + 99;
        }

        _createZombie("NoName", newDna);
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,, kittyDna) = kittyContract.getKitty(_kittyId);
        //处理多返回值，类似erlang
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

    //1 触发器
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    }
    //2
    function _isReady(Zombie storage _zombie) internal view returns (bool){
        return (_zombie.readyTime <= now);
    }

}