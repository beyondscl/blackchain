pragma solidity ^0.4.19;

/// @auth tingxue.leng
/// @dev copy from sagmentfault by hand,好像是一个打僵尸游戏?
contract ZombieFactory is ownable{
    //-----属性
    uint256 dnaDigits = 16; // 僵尸DNA
    uint dnaModulus = 10 ** dnaDigits; // 幂次方
    //僵尸[结构体]
    struct Zombie {
        string name;
        uint dna;

        uint32 level;
        uint32 readTime;
    }

    uint cooldownTime = 1 days;

    //公开的动态[数组] 类型结构体
    Zombie[] public zombies;

    //映射
    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;


    //-----事件
    event NewZombie(unit zombieId, string name, uint dna);


    //-----方法
    // 创建僵尸 非全局变量建议用_开头驼峰命名
    // function 默认为public
    //    function createZombie(string _name ,uint _dna){
    //        zombies.push(Zombie(_name,_dna));
    //    }

    //
    //除 public 和 private 属性之外，Solidity 还使用了另外两个描述函数可见性的修饰词：internal（内部） 和 external（外部）。
    //
    //internal 和 private 类似，不过， 如果某个合约继承自其父合约，这个合约即可以访问父合约中定义的“内部”函数。（嘿，这听起来正是我们想要的那样！）。
    //
    //external 与public 类似，只不过这些函数只能在合约之外调用 - 它们不能被合约内的其他函数调用。稍后我们将讨论什么时候使用 external 和 public。

    function _createZombie(string _name, uint _dna) internal {
        require(ownerZombieCount[msg.sender == 0]);

        uint id = zombies.push(Zombie(_name, _dna,1,uint32(now + cooldownTime)))-1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
        //触发事件
    }
    //函数修饰符public private
    //view 意味着它只能读取数据不能更改数据
    //pure 它的返回值完全取决于它的输入参数

    // 根据输入随机生成一个DNA数据
    //在区块链中安全地产生一个随机数是一个很难的问题
    function _generateRandomDna(string _str) private view returns (uint){
        uint rand = uint(keccak256(_str));
        //string -> uint 1.第一行代码取 _str 的 keccak256 散列值生成一个伪随机十六进制数，类型转换为 uint, 最后保存在类型为 uint 名为 rand 的变量中。
        return rand % dnaModulus;
    }
    //公开的创建方法
    function createRandomZombie(string _name) public {
        unit randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
