grep

副标题：

英文：

关键字：



grep



### `grep for Windows`

`grep` 是用于查找并匹配文件里符合条件字符串或表达式的一个搜索命令。

这个命令常常出现在 `Linux` 中，然而 `Windows` 中默认是没有的。

好在 `Windows` 的爸爸在地球村里势力比较大，方圆N公里内无人不知无人不晓，跺跺脚地面就得颤三颤。

因此，大部分村民还是用的 `Windows` ，还好 `Windows` 还算好用，大家也就没多说啥。

不久之后，忽然冒出来一些爱好自由的村民，他们为了方便大伙儿，就搞出来一个叫作 `Grep for Windows` 的小玩意。

没错，就是在 `Windows` 下也可以用 `Grep` 了，这让不少玩 `Linux` 的自由村民兴奋了好一阵。



我们可以到以下官方网址中下载 `Grep for Windows` 。

> 首页：http://www.gnu.org/software/grep/grep.html
>
> 下载：http://gnuwin32.sourceforge.net/packages/grep.htm



对于和我一样的小白村民，我强烈建议直接下载那个完整安装包，可以省去手动安装依赖组件的麻烦。

图c01



如果你打不开官网，我这儿也留了个备份。

下载链接：





### 安装

既然都用 `Windows` 了，那自然就是一路耐可斯特了，没啥好多说啦，看图！

图a01

图a02

图a03

图a04

图a05



这一步是询问我们是否下载源代码，我等小白不求甚解，只要能用就行哈！不用选。

图a06



图a07

图a08



安装完成，我们还要再做一步设置。

找到 `grep` 可执行程序的所在路径，比如默认安装应该像下面这样。

```
C:\Program Files(x86)\GnuWin32\bin
```

图b01



记住这个路径，然后我们编辑环境变量，将这个路径添加到 `Path` 变量中。

图b02



好了，如此一来我们就可以在任意目录下调用 `grep` 命令了！



### 使用

我们可以输入以下命令来查看 `grep` 的使用方法。

```
grep --help
```



简单语法帮助如下：

```
Usage: grep [OPTION]... PATTERN [FILE]...
Search for PATTERN in each FILE or standard input.
PATTERN is, by default, a basic regular expression (BRE).
Example: grep -i 'hello world' menu.h main.c

......

`egrep' means `grep -E'.  `fgrep' means `grep -F'.
Direct invocation as either `egrep' or `fgrep' is deprecated.
With no FILE, or when FILE is -, read standard input.  If less than two FILEs
are given, assume -h.  Exit status is 0 if any line was selected, 1 otherwise;
if any error occurs and -q was not given, the exit status is 2.
```



大体地使用方法一般有两种，一种是单独使用 `grep` 命令，像这样。

```
// 查找 menu.h 和 main.c 两个文件中带有 `hello world` 字符串的行
grep -i 'hello world' menu.h main.c
```



不过我测试了一下，英文没有问题，不过中文好像支持不咋地啊！

图c02



还有一种方法是通过管道操作符过滤。

比如，从某些命令的输出结果中匹配字符串。

```
// 查找含有指定字符 xxx 的行
netstat -ano | grep xxx
```

图b03







### 写在最后



实际上 `Windows` 的爸爸已经发现了这些村民的所做所为，也不知道是从什么时候开始的，在 `Windows` 系统中就带有一个 `findstr` 命令，可以说功能和 `grep` 差不多。

那么这两者都有啥区别的？

说实话，除了语法参数有些不一样外，就是对系统语言（中文）的支持 `findstr` 要好于 `grep` ，其他的没有什么大的差别。

你看，`findstr` 也能过滤输出结果，支持中文查找也不赖。

图c03



本来想搞定 `grep` 的，结果又冒出来个 `findstr` 。

哎，兜兜转转，我们又回到了过去，这个世界就是不断地轮回啊！

好了，以后就用 `findstr` 吧，自带又好用，小白村民们还是老实一点儿吧！



**扫码关注@网管小贾，个人微信：sysadmcc**

网管小贾 / sysadm.cc