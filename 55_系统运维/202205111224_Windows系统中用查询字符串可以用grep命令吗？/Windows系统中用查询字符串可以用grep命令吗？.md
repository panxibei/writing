Windows系统中用查询字符串可以用grep命令吗？

副标题：Windows系统中用查询字符串可以用grep命令吗？

英文：can-i-use-grep-command-to-query-string-in-windows-system

关键字：grep,windows,findstr



话说刚一上班，我就见同组的小王一个人早早地坐在了工位上。

正想打个招呼，也不知道他忙着什么，发现他抓耳挠腮、坐卧不安。



我凑近想看看怎么回事，他倒回过头来皱着眼眉问我道：“哥，这一大早我电脑的网络就有点闹情绪，也不知道是谁老连我电脑，卡得不行。”

我笑着说：“你硬盘大资源丰富，不老少人做梦都排着队等着连你电脑呢！那家伙，锣鼓喧天、鞭炮齐鸣，队伍一眼望不到头，那家伙排场之大堪比核酸......”

“哥，哥，打住！能不能别吹牛了！赶紧帮我瞅瞅，我这 `netstat` 命令老出来一大堆结果，看得我眼都花了！”

我这么一看，可不是，什么本地的外地的，什么 `TCP` 、`UDP` 的，我去出来一大坨，这分析起来的确费劲，要是能精简一下结果就好了。

比如，我只想列出已建立 `TCP` 连接的那些地址，这样也方便快速做出判断。

还没等我说啥，小王突然很严肃地对我说：“哎，哥，你说我能用 `grep` 来过滤输出结果不？”

我稍稍愣了一下：“呃...好像 `grep` 是在 `Linux` 中使用的...”

“那 `Windows` 中可以用不？”年轻人一脸期待。

“好...好像是有叫 `Grep for Windows` 这么个玩意！”

这小子一听来了劲头，立马问我 `Grep for Windows` 怎么整。



### `grep for Windows`

`grep` 是用于查找并匹配文件里符合条件字符串或表达式的一个搜索命令。

这个命令常常出现在 `Linux` 中，然而 `Windows` 中默认是没有的。

好在 `Windows` 的爸爸在地球村里影响力比较大，方圆N公里内无人不知无人不晓，跺跺脚地面就得颤三颤。

因此，大部分村民还是图省事用的 `Windows` ，还好 `Windows` 还算好用，大家也就没多说啥。

不久之后，忽然冒出来一些爱好自由的村民，他们为了方便大伙儿，就搞出来一个叫作 `Grep for Windows` 的小玩意。

没错，就是在 `Windows` 下也可以用 `Grep` 了，这让不少玩 `Linux` 的自由村民兴奋了好一阵。



我们可以到以下官方网址中下载 `Grep for Windows` 。

> 首页：http://www.gnu.org/software/grep/grep.html
>
> 下载：http://gnuwin32.sourceforge.net/packages/grep.htm



对于和我一样的小白村民，我强烈建议直接下载那个完整安装包，可以省去手动安装依赖组件的麻烦。

图01



如果你打不开官网，我这儿也留了个备份。

**grep-2.5.4-setup.exe.7z(1.81M)**

下载链接：https://pan.baidu.com/s/10nyEtVU12fNgRwcuUo-3VQ

提取码：wy70



### 安装

既然都用 `Windows` 了，那自然就是一路耐可斯特了，没啥好多说啦，看图！

图02

图03

图04

图05

图06



这一步是询问我们是否下载源代码，我等小白不求甚解，只要能用就行哈！不用选。

图07



准备就绪，开始安装。

图08

图09



安装完成，我们还要再做一步设置。

找到 `grep` 可执行程序的所在路径，比如默认安装应该像下面这样。

```
C:\Program Files(x86)\GnuWin32\bin
```

图10



记住这个路径，然后我们编辑环境变量，将这个路径添加到 `Path` 变量中。

图11



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

图12



还有一种方法是通过管道操作符过滤。

比如，从某些命令的输出结果中匹配字符串。

```
// 查找含有指定字符 xxx 的行
netstat -ano | grep xxx
```

图13



### 写在最后

有了 `grep for Windows` ，我们过滤 `netstat` 等查询结果就方便得多了，可以去除我们不需要的干扰因素，只获取我们希望得到的结果。

小王兴奋地敲打着键盘，正准备尝试一下过滤查询的效果。

我并没有打断他，继续补充说道，实际上 `Windows` 的爸爸早已发现了这些村民的所做所为，也不知道是从什么时候开始的，在 `Windows` 系统中就带有一个名叫 `findstr` 的命令，可以说功能和 `grep` 差不多。

小王听完，回头冲我眨了眨眼，“那么这两者都有啥区别呢？”

我耸了耸肩，说实话，除了语法参数有些不一样外，就是对系统语言（中文）的支持 `findstr` 要好于 `grep` ，毕竟是自家出品，其他的好像也没有什么大的差别。

你看，`findstr` 也能过滤输出结果，支持中文查找也不赖。

图14



再送你几个常用命令行写法。

```
:: 参数 -i，匹配字符串 udp 并忽略大小写
netstat -an | findstr -i udp

:: 参数 /n，匹配字符串 tcp 并在第行前打印行数
netstat -an | findstr -i /n tcp

:: 参数 /v，只输出不包含 tcp 的行
netstat -an | findstr -i /v tcp
```



小王一看，鼻子都气歪了，直埋怨怪我不早说，绕这么大一个圈子。

呵呵，我想说是你小子先问我 `Windows` 中有没有 `Grep` 来着。

本来想搞定 `grep` 的，结果又冒出来个 `findstr` 。

哎，兜兜转转，我们又转了回来，这个世界就是不断地轮回啊！

好了，以后就用 `findstr` 吧，自带又好用，小白村民们还是老实一点儿，少折腾吧！



**扫码关注@网管小贾，个人微信：sysadmcc**

网管小贾 / sysadm.cc