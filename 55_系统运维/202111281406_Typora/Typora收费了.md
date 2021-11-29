Typora收费了

副标题：

英文：

关键字：





`Ubuntu` 直接安装 `deb`  包。

在 `Debian` 系统上可以直接安装使用。

```
sudo apt install typora_0.11.18_amd64.deb
```

图b01

图b02

图b03



`Linux` 安装 `tar.gz` 包。

可以在各个不同发行版上使用。

```
sudo tar zxvf Typora-linux-x64.tar.gz
cd ./bin/Typora-linux-x64/
./Typora
```

图b04



再拿 `RockLinux` 来举例。

通过同样的方法，执行 `./Typora`  即可启动。

以下我是通过 `Xming` 重写向到我的 `Windows` 上显示的。

图b05



期间可能会有一些小坑。

比如不能用 `root` 用户直接运行 `typora` 。

图b06



还有就是我碰到的，少了一个共享库 `libXss.so.1` 。

图b07



这个共享库是个什么东东呢？

搞了半天它的名字叫 `libXScrnSaver` ，我怎么看怎么像屏保。

难道 `typora` 还要屏保的相关库文件？

图b08



还有，我找到了修改界面语言的设置，当我修改为简体中文时，发现下面还有一个发送匿名信息的设置。

这玩意不会是偷偷做了些小动作吧？

是时候祭出《个人信息保护法》了，我顺手就把勾给取消了。

图b09



