# blackchain

segmentfault 基础文件 + 高级理论
https://segmentfault.com/a/1190000015241199

审计合约的学习地址
OpenZeppelin

基本优化
1. 将数据类型放在结构体中 struct {...}
2. unit32 unit32 uint uint 会消耗较少的gas
3. 标记为 view 的函数只有在外部调用时才是免费
4. Solidity 使用 storage(存储)是相当昂贵的，”写入“操作尤其贵。


其他:
1. 内存数组 必须 用长度参数
uint[] memory values = new uint[](3);
values.push(1);

2.
1、我们有决定函数何时和被谁调用的可见性修饰符:
private 意味着它只能被合约内部调用；
internal 就像 private 但是也能被继承的合约调用；
external 只能从合约外部调用；
最后 public 可以在任何地方调用，不管是内部还是外部。
我们也有状态修饰符， 告诉我们函数如何和区块链交互:
view 告诉我们运行这个函数不会更改和保存任何数据；
pure 告诉我们这个函数不但不会往区块链写数据，它甚至不从区块链读取数据。这两种在被从合约外部调用的时候都不花费任何gas
（但是它们在被内部其他函数调用的时候将会耗费gas）。

3.payable

4.内建函数
msg.value
msg.sender
owner.transfer(this.balance)


5. 重构通用逻辑 modify
一般是验证判断检查条件等
assert | require 会返回gas

6. 使用安全数字计算