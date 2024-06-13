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





默认终端字体比较难看，修改之。

图c01



在终端中执行以下两条命令。

```
sudo pacman -S wqy-bitmapfont
sudo pacman -S wqy-zenhei
```

图c02

图c03



完成后重新打开终端即可。

图c04



 Arch Linux CN 软件源 

> https://mirrors.ustc.edu.cn/help/archlinuxcn.html



在 `/etc/pacman.conf` 文件末尾添加两行：

```
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

然后请安装 `archlinuxcn-keyring` 包以导入 GPG key。



如果出现以下错误。

```
error: archlinuxcn-keyring: Signature from "Jiachen YANG (Arch Linux Packager Signing Key) " is marginal trust
```

 应该本地信任 farseerfc 的 GPG key 

```
sudo pacman-key --lsign-key "farseerfc@archlinux.org"
```

