manjaro

副标题：

英文：

关键字：



动物园有一块不大不小的水塘，一群火烈鸟就生活在这里。

然而周末经常来逛动物园的一个小男孩发现了它们的秘密。



就在某个周末的早上，小男孩乔治又来看火烈鸟了。

远远望去，他看见它们百无聊赖地各自在水塘里寻找着小鱼小虾。

突然，有一只白色的火烈鸟提出了一个问题：除了Windows，还能有什么好用易上手的操作系统呢？

听到了提问，有几只颜色鲜艳的火烈鸟开始了讨论。

然而不久后几乎所有的火烈鸟都参与了进来，讨论变成了争论，气氛越来越激烈。



有一只红色艳丽的火烈鸟昂着头说道：“肯定是要用 `Linux` 系统啦！开源免费还安全！”

另一只个头稍矮一点的火烈鸟抬了抬它那细长腿附合：“赞成！赞成！我看 `Ubuntu` 就挺好的！”

一旁的有点白有点红的火烈鸟斜着眼睛，一副了不起的样子：“我用 `MacOS` ！”



不远处的两只火烈鸟低着头，私下里翻起了白眼互相低声耳语。

“那还不就是 `BSD` 系统！”

“就是嘛，金将军都能‘自主’搞出个太阳系统！哈哈！”



这时，有一只不太起眼的火烈鸟站了出来。

它站到了饲养员来时站的位置，转来脸来向大家喊道：“大家请安静！请听我说两句！”

“我认为啊，不管是Windows，还是Linux，都是外国的，我们应该用我们自己的系统，我们应该用我们国产的系统！”

说完扇了扇翅膀，继续道：“我们现在已经有了国产系统，大家有兴趣的话，可以尝试尝试，可以支持多种系统构架平台，当然也包括 `x86` ，也就是一般的家用电脑。”



统信官网：

> https://www.chinauos.com



`deepin` 官网：

> https://www.deepin.org



“然而，我想说的是，这次我不是来推销刚才我说的这些。”

“因为我觉得很多人是不太懂 `Linux` 系统的，即使是国产系统它也是基于 `Linux` 的，因此我向大家推荐一款更容易从 `Windows` 转向 `Linux` 的系统！”

话音刚落，鸟群中有火烈鸟就质疑道：“你说的是鸿蒙吗？！”

“不不，别说鸿蒙系统还没正式发布，就算正式发布了，它也是基于 `Linux` 的操作习惯，所以说在将来，多多少少最好大家都要熟悉 `Linux` ，就像十数年前大家学电脑都学 `Windows `是一样一样的！”

“那你倒是说啊，别卖关子了！”

“好，我要介绍的，也是一款 `Linux` 系统，它的名字叫 `manjaro` ……”

紧接着，它侃侃而谈……



`manjaro` 是基于 `Arch Linux` 的发行版。

所谓 `Arch` 可以简单理解为 `Linux` 的一个系列，就像 `Ubuntu` 是 `Debian` 系列，`CentOS` 是 `Redhat` 系列，差不多那意思。

网上有很多关于 `manjaro` 的教程可以参考，但这里需要说的是，之所以推荐试用，是因为 `manjaro` 用起来和 `Windows` 有点类似。

比如软件丰富、安装方便，不太需要操心其他 `Linux` 发行版会遇到的那些个棘手问题。



`manjaro` 官网：

> https://manjaro.org/



简单安装过程。

从官网下载你喜欢的镜像文件。

> https://manjaro.org/download/



选择 `x86` 还是 `ARM` ，通常自己的电脑是 `x86` 的。

图d01



然后选择你喜欢的桌面版，`PLASMA` 、`XFCE` 或 `GNOME` 等桌面。

这些不同的桌面指的是系统桌面、菜单、显示风格等等不同的程序。

这也是 `Linux` 和 `Windows` 两者最大不同点之一，你可以理解为 `Windows` 的桌面程序只有一套，怎么装都是一个样，而 `Linux` 可以有好几套，看你装的是哪个，自然用起来样子就各种各样了。

当然这些不同桌面的 `manjaro` 系统还分官方版和社区版，你可以将社区版当作是爱好者们魔改后的版本。

图d02



现在的安装过程都比较简单，如果你懂得 `Linux` 原理，那么可以使用专家模式安装。

如果你是初学者，那么直接勾勾划划、填填写写，来几个下一步就OK了。



开机启动画面。

图a01



系统启动后开启安装向导程序，直接点窗口中的，或是桌面上的都行。

图a02



改下语言，中文更懂你。

图a03



修正时区，选择上海。

图a05



保持默认键盘布局。

图a06



初学者可以让程序来自动帮你分区，不用动啥。

注意备份数据，不要轻易在有系统的硬盘上尝试哦！

图a07



孩子马上就要出生，起个名字庆祝一下！

图a08



选择安装或不安装 `Office` 软件。

图a09



准备开始安装啦！

图a12



安装过程比较可爱。

图a14.GIF



安装成功，重启看到了我们 `manjaro` 新系统诞生了！

图a15

图b01



开源办公软件，和微软的大差不差。

图b03



软件很丰富，即使有些还没有安装上，也可以通过在线安装获取。

在最初安装完后，默认的终端字体比较难看，像这样。

图c01



改得好看一点吧，在终端中执行以下两条命令。

```
sudo pacman -S wqy-bitmapfont
sudo pacman -S wqy-zenhei
```

图c02

图c03



完成后重新打开终端即可，颜值飙升。

图c04



如果你有一些动手能力，可以将 `manjaro` 的软件源更新为国内，这样安装更新软件会快很多。

国内有很多这种软件源，比如中科大 `Arch` 软件源。

> https://mirrors.ustc.edu.cn/help/archlinuxcn.html



修改方法如下：

在 `/etc/pacman.conf` 文件末尾添加两行：

```
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

然后请安装 `archlinuxcn-keyring` 包以导入 `GPG key` 。



如果出现以下错误。

```
error: archlinuxcn-keyring: Signature from "Jiachen YANG (Arch Linux Packager Signing Key) " is marginal trust
```

 应该本地信任 `farseerfc` 的 `GPG key` 。

```
sudo pacman-key --lsign-key "farseerfc@archlinux.org"
```



如果你不太明白，其实也不用修改，但是动手实践也是你学习 `Linux` 的一个过程，有助于你了解熟悉 `Linux` 。



`manjaro` 安装、更新和移除软件非常简单，就一条命令。

```
# 安装
sudo pacman -S 软件名称

# 更新
sudo pacman -Syu 软件名称

# 移除
sudo pacman -R 软件名称
```



比如，安装 `Chrome` 浏览器。

```
sudo pacman -S google-chrome
```



又比如，安装深度截图软件。

```
sudo pacman -S deepin-screenshot
```



最后介绍一下 `manjaro` 中输入法的安装。

这是在 `XFCE` 桌面系统下的安装方法，其他桌面系统可能有所不同。

```
# 安装搜狗输入法、五笔、日语等
sudo pacman -S fcitx-im
sudo pacman -S fcitx-configtool
sudo pacman -S fcitx-sogoupinyin
sudo pacman -S fcitx-mozc
```



然后添加输入法配置文件 `sudo vim ~/.xprofile`，如果没有找到这个文件就新建一个。

```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
```



设定好后重启电脑即可生效，尝试一下吧！

