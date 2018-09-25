pragma solidity ^0.4.0;

contract ZombieHelper {

    uint levlelUpFee = 0.001 ether;

    function ZombieHelper(){

    }

    modifier aboveLevel(uint _level ,uint _zombieId){
        require(zombies[_zombieId].level >= _level);
        _;
    }

    // 在这里创建你的函数
    function getZombiesByOwner (address _owner) external view returns (uint []) {

    }

    //
    function withdraw() external onlyOwner{
        owner.transfer(this.balance);
    }
    //
    function setLevelUpFee(uint _fee) external onlyOwner{
        levelUpFee = _fee;
    }
}
