UEFIGame（上）

副标题：

英文：

关键字：





一共五款迷你游戏，可以在 `UEFI` 环境下运行。

如果游戏通过，则可顺利启动电脑，否则直接就关机了。

这些游戏都有啥呢？



* **User Evaluation For Ineptness**

  呈现一个简单的数学问题，即0到99之间的两个随机数的和。

  如果你的答案不正确，系统会嘲笑你并关闭电脑。

  图f01

  

* **Insult Sword Fighting** 

  灵感源自猴岛，选择正确回怼才能继续启动系统。

  图f02

  

* **Fall To Boot**

  程序会生成垂直滚动隧道，一定要到达底部，否则启动将失败。

  图f03

  

* **Age Verification**

  回答80年代流行文化小问题，以证明你是成年人。

  答错的话，系统会判定你年龄太小，无法使用此电脑。

  图f04

  

* **UEFI Says**

  这是一个内存测试……但并非针对电脑。

  采用类似西蒙游戏的设计，胜利则启动，失败则关机。

  图f05





虚拟机模拟 `QEMU` + `OVMF` （文末程序包有下载）。



首先，新建一个文件夹 `UEFTGame` （名称随意，只要你喜欢）。

其次，将 `RELEASEX64_OVMF.fd` 文件放到这个新建的文件夹中（ `OVMF` 是 `Tianocore` 用于虚拟机的 `UEFI Firmware` ）。 

图e01



再次，在 `UEFTGame` 文件夹中新建一个 `EFI` 文件夹。

然后在这个 `EFI` 文件中再新建一个 `Boot` 文件夹和一个 `UEFIGame` 文件夹。

文件夹结构应该是这样的。

```
UEFIGame
	|__EFI
		|__Boot
		|__UEFIGame
```

图e02



最后，将相应的文件放到前面建立的各个文件夹中。

1、`OVMF` 文件放到 `UEFIGame/EFI` 文件夹中（文末有程序包下载）。

2、任意一个游戏 `xxx.efi` 文件放到 `UEFIGame/EFI/Boot` 中，注意，一定要将它重命名为 `BOOTX64.efi` 。

3、 将相应游戏的附加文本文件放到 `UEFIGame/EFI/UEFIGame` 文件夹中，比如 `insults.txt` 等。

请注意，游戏 `xxx.efi` 和所需的附加文本文件，这两者不是放在一起的哦！



所以，最后你看到的可能是这个样子。

```
UEFIGame------------------RELEASEX64_OVMF.fd
	|__EFI
		|__Boot-----------BOOTX64.efi（比如由InsultSwordFighting.efi重命名）
		|__UEFIGame-------insults.txt
```





游戏附加文本文件到底是个什么？

它们是怎样的一种存在呢？

具体请看下面。



**`User Evaluation For Ineptness` 所需附加文件 `phrases.txt` 。**

这个文件是可选的，如果没有提供这个文件，游戏会返回和这个文件默认相同的内容。（文末下载包里有）

如果用户回答问题失败，游戏将从该文件中随机选择一个短语（水库抽样法）作为回答。



`phrases.txt` 文件格式：

* 文件必须是 `UTF-16` 编码
* 短语可以是多行的
* 短语之间用 1 个空行（ `\n\n` ）分隔



**`Insult Sword Fighting` 所需附加文件 `insults.txt` 。**

这个文件是必需要有的，并且必须是 `UTF-16` 格式。 （文末下载包里有）

游戏将随机选择一条侮辱性言论及其对应的回复。



`insults.txt` 文件格式：

```
Insult（怼）
Correct comeback（恰当的回击）
incorrect comeback（不恰当的回击）
another incorrect comeback（其他不恰当的回击）
...
as many incorrects comebacks as you want（更多不恰当的回击）

Another insult（怼）
Correct comeback（恰当的回击）
...
```



**`Age Verification` 所需附加文件 `questions.txt` 和 `failmessages.txt` 。**

此文件为可选文件，若不存在，游戏将使用备用问题。（文末下载包里有）

游戏将随机选择一个关于70年代/80年代流行文化的知识问答问题（水库抽样法）。



`questions.txt` 文件格式：

```
Question text（问题文本）
Correct answer（正确回答）
Wrong answer（错误回答）
Wrong answer（错误回答）
Wrong answer（错误回答）

Another question（另一个问题文本）
Correct answer（正确回答）
...
```

* 文件必须是 `UTF-16` 编码
* 问题后的第一个答案总是正确答案（答案在显示时被打乱顺序）
* 问题之间用 1 个空行隔开



`failmessages.txt` 文件格式：

此文件为可选文件，包含您失败时显示的具有嘲笑讽刺意味的消息。

* 文件必须是 `UTF-16` 格式
* 消息之间用 1 个空行分隔



好了，准备了这么多，现在就启动一下 `QEMU` 来看看吧！

命令行如下：

```shell
qemu-system-x86_64 -drive if=pflash,format=raw,readonly=on,file=C:/UEFIGame/RELEASEX64_OVMF.fd -drive file=fat:rw:C:/UEFIGame,format=raw,if=virtio -cpu qemu64,+rdrand
```

图d01



运行效果是这样子的。

图d02

图d03



如何在物理计算机上跑呢？

看下篇。



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc