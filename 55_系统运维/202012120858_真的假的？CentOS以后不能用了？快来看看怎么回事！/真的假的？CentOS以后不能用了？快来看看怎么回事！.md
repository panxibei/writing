真的假的？CentOS以后不能用了？快来看看怎么回事！

副标题：把有限的生命投入到无限的白嫖中去~





传闻 CentOS 将死，不信吧，我也不信，今年假新闻太多！

可是很遗憾，这个传闻它是真的！

CentOS 官方发布消息，称将在明年（2021年）逐步把开发工作重心从 CentOS Linux 往 CentOS Stream 转移。

官方进一步说，CentOS Stream 才是未来，什么 CentOS 7 或 8 都将被 CentOS Stream 取而代之。

什么意思？

简单地讲，就是以后没有 CentOS 7 或 8 了，CentOS 8 都将在2021年年底（原定2029年）结束维护。

而针对 CentOS 7 ，官方考虑到其用户基数较多，暂时按照原计划维护到2024年6月30日，也就是说你还可以使用它不到4年的时间。

图1



些时有的小伙伴儿们肯定会有些失落，发出“怎么会这样”的感叹吧。

实际上我们应该先搞清楚，这个 CentOS Stream 它到底是个什么东西。

以我浅薄的阅读和理解力对其研究一番，大概得出这么个结论。

* 原先的模式：Fedora > RHEL > CentOS
* 将来的模式：Fedora > CentOS Stream/RHEL



你可以将 `Fedora` 理解为测试版，`RHEL` 为正式版，`CentOS` 则为稳定版。

那么原先的模式就是先在 `Fedora` 上测试，然后测试OK则成为 `RHEL` ，最后再到 `CentOS` 。

可以说 `CentOS` 是最稳定可靠的，只是它有一个缺点，也是很多人对它不太看好的地方。

就是它虽然稳定，但它的更新来源于 `RHEL` 却需要很长时间来完成更新，这个过程通常要数天甚至20多天。

不过对于一般用户来说，这也不算太大的问题，只要它稳定就行。

可是，现在不一样了，稳定的 `CentOS` 没有了！

取而代之的是 `CentOS Stream` 这个后来者，而它一反常态，跑到了 `RHEL` 的前面去了，也就是成为测试版。

只有 `CentOS Stream` 测试OK了，才会更新到 `RHEL` 上。

这回明白了吧，官方的小心思显露无疑啊！

以往很多人认为的至理名言“CentOS就是免费版的红帽”，也就随之烟消云散了。



广大群众不禁要问：那就真的走投无路了吗？







Oracle Linux 官网：

https://linux.oracle.com/switch/centos/









尝试安装 `Oracle Linux` 。



除了左上角的标志不同，其他感觉和 `CentOS` 差不多。

左上角的标志，企鹅穿着 Oracle 的马甲，与其在官方网页上的介绍它也是REHL的翻版，这点倒是挺形象的。

图2

图3



整个安装过程毫无违和感，不看那个标志，还以为仍在安装 `CentOS` 。

安装完成后，很显然启动菜单项上的单词与 `CentOS` 不同。

官方介绍说使用的是 `Oracle` 自己的 `yum` 仓库，来看看。

查看 `yum` 仓库，果然有 `oracle-linux` 的仓库。

```shell
[root@localhost yum.repos.d]# ls
oracle-linux-ol7.repo  uek-ol7.repo  virt-ol7.repo
```





内核版本存在很大的差异

Oracle Linux Server 7.9 （内核 5.4.17）

图

CentOS 7.9 （内核 3.10.0）

图

