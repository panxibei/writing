为了确定是否有人动过我的电脑，我用 SmartSystemMenu 偷偷记录下了程序窗口的位置和大小！

副标题：SmartSystemMenu 一款扩展程序窗口功能的小程序

英文：in-order-to-determine-if-someone-has-touched-my-pc-i-secretly-recorded-the-position-and-size-of-program-window-with-smartsystemmenu

关键字：smartsystemmenu,系统菜单,transparency,clipboard,explorer,resize,always on top



究竟是谁动了我的电脑？

哼，显然这个神秘之人伪装地极好，但是还是被我给发现了！



就在前天中午，出去吃个饭的功夫，等我回来后忽然发现桌子上的布局像是被谁动过。

当时我很吃惊，却又不敢十分地肯定，为了证明我的感觉是对的，我决定仿照侦探小说里人物的动作，刻意将桌面上的物品都按一定的规律摆放。



到了第二天中午，离开座位之前我又再次记下了各个物品的位置以及它们之间的距离。

吃完饭后等我回到工位时，我去，果不其然，我的鼠标被明显地移动过！

我猛然抬头放眼望去，午休期间的四周安静得出奇，但又似乎没有什么可疑的人员，大家休息的休息、工作的工作，并没有谁在意我这里发生的一切。



“难道我被盯上了？”

“不好！一定是有刁民想害朕！”

“不对！我的电脑......”



我立马打开了电脑，寻找着蛛丝马迹，希望能得到一些有用的线索。

看来看去总觉得一些程序窗口似乎被调整过，好像大小和位置都和之前的不太一样。

我咽了咽口水，心想谁这么大胆，竟敢翻看我的电脑，还好“重要资料”都还在！

不行，这样下去可不行，我的脑子飞速地思考着，除了修改密码外，还必须将 `SmartSystemMenu` 请出来！



`SmartSystemMenu` 是一款自定义扩展所有窗口系统菜单的小程序，利用它可以帮助我们记录和修改窗口位置大小等等状态。

我有些小激动，为了证明我不是神经过敏，于是我就通过这个 `SmartSystemMenu` 记录下所有窗口的位置和大小信息，期待着第二天能抓到那个神秘来客！

经过一番简单地学习，我获得了 `SmartSystemMenu` 的初级使用方法。



### 下载安装

通过官网下载 `SmartSystemMenu` 。

> 项目官网：https://github.com/AlexanderPro/SmartSystemMenu
>
> 中文说明：https://github.com/AlexanderPro/SmartSystemMenu/blob/master/README_CN.md



解压缩后我们得到如下几个文件。

* SmartSystemMenu.exe
* SmartSystemMenu64.exe (位于 SmartSystemMenu.exe 模块的资源中)
* SmartSystemMenuHook.dll
* SmartSystemMenuHook64.dll
* SmartSystemMenu.xml
* Language.xml



最初解压缩后我们可能看不到 `SmartSystemMenu64.exe` ，那是因为它被压缩到了主程序 `SmartSystemMenu.exe` 中了。

图01



只要我们运行了主程序 `SmartSystemMenu.exe` ，那么 `SmartSystemMenu64.exe` 便会自动被释放出来。

因此我们就可以理解了，无论当前的系统是 `64` 位还是 `32` 位，只要执行 `SmartSystemMenu.exe` 文件就对了。

图02



### 使用体验

程序一旦启动，它就已经在后台生效了。

我们随便找个程序窗口，点击一下窗口的左上角，看到了吧，居然多出了很多选项。

图03



好了，接下来找几个可能用得上的功能给小伙伴们介绍吧！



##### 信息

是指当前窗口的信息，这对于编程时操控特定窗口很有用处，一般情况下我们单纯看看就行。

图04



##### 卷起

这个功能也存在于一些 `Linux` 发行版系统中，目的是在打开多个有用窗口时为了避免遮挡其他窗口，充分利用有限的屏幕空间而不用最小化窗口。

但是吧，像下图中文件夹窗口好像并不能做到卷起后只剩一个标题栏的效果。

图05



##### 毛玻璃效果

这个效果有点鸡肋的感觉，大概在 `Win10` 里本来就有 `Aero` 的效果，因此这种做法又有点多此一举了。

图06



##### 窗口置顶

置顶功能有时很有用，并不是所有的窗口都带有置顶功能的。

另外特别是在查看一些参考资料，必须要放到所有窗口的最前面，当然你也可以随时取消置顶。



##### 移到最底层

和置顶功能正好相反，但我想不出来放到最底层是为了什么，是为了不妨碍其他窗口之间的切换吗？



##### 调整窗口大小

这正是我想用到的关键功能，除了可以指定固定分辨率尺寸外，你还可以自定义大小。

连窗口在屏幕的位置都可以调整，真正做到了如意如意随我心意！

图07

图08



##### 对齐

除了上面说的窗口大小中可以调整窗口位置外，在对立一项中还可以具体指定一些固定位置，比如居中，当然你还是可以随意自定义位置的。

图09



##### 透明度

我们可以给当前窗口设置一定的透明度，这样可以一定程度上使背景穿透当前窗口，方便我们察看后面多个叠加的窗口。

比如像下图这个样子，就是将当前窗口设置为 50% 透明度的效果。

图10



有一点我们需要留个心眼哈，不同的透明度有相应不同的快捷键。

比如，如果一不小心将透明度搞成了 100% ，也就是窗口变成了不可见，这可咋办呢？

其实也不用慌，先不断按下 `Alt` + `Tab` 键将窗口切换为当前聚焦窗口，然后再按下 `Ctrl` + `Num 0` 即可恢复原状。



##### 系统托盘

居然还可以将当前窗口最小化到系统托盘，这个有点意思。

图11



##### 其他窗口

通常来说，一个程序能管好自己就已经很不错了，可它偏偏不走寻常路，非要管管别人。

比如它可以将除当前窗口之外的其他窗口最小化或者干脆关闭。

我只记得系统默认情况下，可以拖动窗口来回晃动就可以将其他窗口最小化，这个倒好，除了最小化它还能将其他碍事的窗口都给关了，做得真绝啊！

图12



##### 程序退出

程序怎么退出呢？

很简单，点击系统托盘图标，选择退出即可。

图13



### 程序设置

在 `常规` 选项卡中，我们可以设置不同的界面语言。

如果你的电脑比较先进，可能会遇到高 `DPI` 显示问题（比如程序界面错乱等），那么将 `Enable High DPI` 一项勾上再试试。

另外，有些进程我们不希望用到 `SmartSystemMenu` ，那么就可以将这些进程添加到排除列表中。

图14



在 `菜单` 选项卡中，我们可以选择我们经常能用到的设置效果，使菜单更加精简便捷。

图15



在 `菜单（调整窗口大小）` 选项卡中，我们也可以精简我们常用到的几个分辨率。

图16



在 `菜单（启动程序）` 选项卡中，我们可以随意增加删除我们想要的启动程序，而且还可以加上启动参数。

图17



### 命令行接口

这个 `SmartSystemMenu` 居然还提供命令行接口，通过在后面加上参数 `--help` 即可查看。

```
SmartSystemMenu.exe --help
```



```
   --help             The help
   --title            Title
   --titleBegins      Title begins 
   --titleEnds        Title ends
   --titleContains    Title contains
   --handle           Handle (1234567890) (0xFFFFFF)
   --processId        PID (1234567890)
-d --delay            Delay in milliseconds
-l --left             Left
-t --top              Top
-w --width            Width
-h --height           Height
-i --information      Information dialog
-s --savescreenshot   Save Screenshot
-m --monitor          [0, 1, 2, 3, ...]
-a --alignment        [topleft,
                       topcenter,
                       topright,
                       middleleft,
                       middlecenter,
                       middleright,
                       bottomleft,
                       bottomcenter,
                       bottomright,
                       centerhorizontally,
                       centervertically]
-p --priority         [realtime,
                       high,
                       abovenormal,
                       normal,
                       belownormal,
                       idle]
   --transparency     [0 ... 100]
   --alwaysontop      [on, off]
-g --aeroglass        [on, off]
   --sendtobottom     No params
-o --openinexplorer   No params
-c --copytoclipboard  No params
   --clearclipboard   No params
-n --nogui            No GUI
```



命令行的使用方式通常会用在一些特殊场合，比如在我们自己的程序上调用 `SmartSystemMenu` 。

举个例子，比如我们在执行一个程序任务过程中需要将某个窗口置顶或改变移动位置。

```
# 将标题为 “无标题 - 记事本”的记事本程序窗口置顶
SmartSystemMenu.exe --title "无标题 - 记事本" --alwaysontop on --nogui

# 将标题为 “无标题 - 记事本”的记事本程序窗口对齐到左上角
SmartSystemMenu.exe --title "无标题 - 记事本" -a topleft --nogui
```



### 写在最后

在掌握了 `SmartSystemMenu` 的用法之后，经过我一番精心准备，中午离开工位之前我开启了 `SmartSystemMenu` 。

等我吃完饭，装的像没事儿人似地一边吹着口哨一边慢慢溜回到座位上。

嘿，我眼睛一亮，这电脑连屏都没锁，我刚一碰鼠标连密码都没输入就看到桌面了，铁定是刚跑没多久，这跑得急没来得及锁屏啊！

果然有人碰过我的电脑，再一看窗口真的被移动过，怎么连桌面上的图标都给换了！

这刚才是真要拿我动手啊，他是要图我点什么呢？

正当我气愤不已，突然旁边站了个人，我回头一瞧，正是隔壁工位的孔大力。

他一脸莫名其妙地看着我说，“你丫瞅我电脑干啥呢？！”

我再一看工位号当场社死......



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc