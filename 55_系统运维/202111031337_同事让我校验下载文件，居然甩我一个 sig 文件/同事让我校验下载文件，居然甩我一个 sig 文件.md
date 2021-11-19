同事让我校验下载文件，居然甩我一个 sig 文件

副标题：sig 文件是干啥的？

英文：my-colleague-asked-me-to-verify-a-downloaded-file-but-he-give-me-a-sig-file

关键字：pgp,gpg,openpgp,sig,asc,公钥,密钥,签名,数字证书



在计算机世界中，文件拷贝传输是很常见的操作，每时每刻都在发生着。

然而，即使是数字世界本身就拥有着强大的自我校验，即使是现在网络传输状况比以往好了不少，也难保所有的文件在拷贝传输过程中不出现任何差错。

说得直白一些，我们需要保持严谨态度，为了保证文件的完整性和可靠性，在每次拷贝或下载文件后最好验明正身，以防混入赝品而不自知。



有小伙伴们会说，我平时下载文件都没问题啊。

其实一般来说是没啥大问题，但如果下载的文件特别大或特别多，网络条件再差一点，那就很有可能会出现丢失或损坏文件的情况。

因此为确保能正常使用文件，我们最好养成良好习惯，将文件检查检查。



### 常见的检验方法

通常，较为常见的文件检验方法有 `MD5` 、 `SHA1` 和 `SHA256` 等等。

比如像下面，一般在下载信息附近都会给出这几种校验方法的哈希值以供参考。

图01



待文件下载后，就可以利用一些工具软件来校验所下载的文件，将生成的哈希值与下载站点提供的校验值对照即可。

`Windows` 平台如果你安装了 `7zip` ，那么它就带有 `SHA256` 等算法的校验功能。

对准下载文件以右键击之，在菜单中选择 `CRC SHA` 一项后，再选择相应的算法，很是方便。

图02



对于有些要求较高的用户，第三方软件也提供有诸如 `SHA512` 之类的更高一级的算法校验。

图03



在 `Linux` 平台上可以使用自带的哈希校验命令，使用起来也非常方便。

```
md5sum filename
sha256sum filename
```

图04



前两天在下载 `guix` 系统测试尝鲜，而官方提供的校验方式是一个 `sig` 格式的签名文件。

图05



这个 `sig` 签名文件怎么用于校验下载文件呢？

这还是头一次见识，于是上网笼统地学习一下。



### `sig` 文件是什么来头

这个 `sig` 文件实际上是个文本文件，里面记录了文件的数字签名信息，内容类似于像下面这样。

```
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEJ9WGpPiQCFQyn/CfEmDkZILmNWIFAmCbE6EACgkQEmDkZILm
NWLc/A//XI9ReKGh6Tbd6NQ3S8gGGzDiVsDeW2IOmFG/hEKoyX5e4sCylqy7rWhw
mkaGROA4A9l2CYLWQZ61D7R0+apo71230GxuNaK4al+x+EEBkZELMJXMlAmLMCn/
4w+3oghDpuyoOK4hz7N8uMkbPsiiKEtf3qjKV2lNEMv1BQF74ZGxdTbfUOzieRUv
Tqvz9LGacinzbVb9g/Sl3LeV7zsp+55J5oRifV72RbIFoMEIKk9I9VO57YVkcNW+
Wa14GKHpCzT261fZysn9UPTw0q05gQklcSom+ok0I3tQDuWy4/2JVZC0/NxTkCUr
n+JbdV7nEFAnP1KnvBVqWi/ULBwvYBFuzrcOmWkaH7wCKP4pKTlDFby+qoJ1htPj
m59TQKmu/hk2899QvPkinBeEIvKsRdzCzqYGUqRhioEcp+KZ0CpoY0/s2PRZqW1O
kD2pbHUy+arzE+0GLo13hbr6kKCGdNQffvxG7OEEjnb157PONUWEjOjLLfqrdkRY
p/F96R0ku1vw+7Z6sM0wZTcVHEOefQ5NDA7mU0lGN9RNswu2XueZ1pMOuEg6BB32
imOTUeN7s9WOlttSTWwjowJdWHswdHnkyGpi7XvdH7AApCp66QCpqrsauqgCTH1d
AqKMAvTUriSdNVnD69x2+AzYUcPs+TogMi2zDDBkHJSCDJd2Ecw=
=oTe1
-----END PGP SIGNATURE-----
```



要想搞清楚 `sig` 文件的来头，那么就不得不先提一下 **`PGP`** 的概念。

`Pretty Good Privacy` 中文为 “优良保密协议”，是一套用于消息加密、验证的应用程序。

而在前面加个 `Open` 的  **`OpenPGP`** 则是开源 `PGP` 的统一标准协议。

还有一个，**`GPG`** ( `GnuPG`) 就是符合 `OpenPGP` 标准的开源加密软件。



我们可以理解为，前两者都是协议，而最后那个是软件程序。

很明显上面的 `sig` 数字签名文件的内容就是基于 `OpenPGP` 的。

那么我们瞬间就可以明白，我们需要用到 `GPG` 应用程序来校验文件。



一会儿 `PGP` 、一会儿 `GPG` ，你把我给搞头晕啊喂！

哈哈，其实我们只要记住应用于实际的程序就行了，那就是 `GPG` 程序。

通常在 `Linux` 下操作比较方便，一般都自带有 `GPG` 命令可以直接拿来用。

那么 `Windows` 平台怎么玩呢？

其实只要安装了 `GPG` 程序，`Windows` 也照样能玩得起来。



### 安装 `Gpg4win`

开源软件从来都不会忘记 `Windows` ，在 `Windows` 平台上自然也提供了名为 `Gpg4win` 的 `GPG` 程序。

> 官网地址：https://gpg4win.org



我们来到下载页面，怎么好像要付费啊？

没事，如果你此时身无分文，那么也没关系，点击那个 `$0` ，就可以完美跳过捐赠直接下载了。

图06



下载完成后双击安装，过程比较简单就不再赘述。

安装好后，我们实际上得到了两个东西，一个是带 `GPG` 功能的 `GUI` 前端程序 `Kleopatra` ，还有一个则是 `GPG` 命令集，可以用于命令行，和 `Linux`  上操作一样。



### 命令行方式检验文件

为了给大家加深印象，我们先来说说命令行形式下 `GPG` 应该如何校验文件。

网上有一大堆教程，但我们只用最简单的方法即可。

将准备校验的文件（比如 `gpg4win-3.1.16.exe` ）与校验文件（比如 `gpg4win-3.1.16.exe.sig` ）放在同一文件夹下。

然后用下面这个命令就可以开始校验了。

```
// gpg --verify <sig文件> <被校验文件>
gpg --verify gpg4win-3.1.16.exe.sig gpg4win-3.1.16.exe
```



正常情况下，我们可以看到输出检验成功的信息。

但是有时也会出现如下问题，说签名文件过期（ `This key has expired!` ）。

那么我们可以用一个取巧的办法，就是将系统当前时间手动修改为签名文件有效期之内，然后再一次执行校验命令。

```
E:\Linux>gpg --verify gpg4win-3.1.16.exe.sig gpg4win-3.1.16.exe
gpg: Signature made 2021/6/12 0:04:11 中国标准时间
gpg:                using RSA key 13E3CE81AFEA6F683E466E0D42D876082688DA1A
gpg: Good signature from "Intevation File Distribution Key <distribution-key@intevation.de>" [expired]
gpg: Note: This key has expired!
Primary key fingerprint: 13E3 CE81 AFEA 6F68 3E46  6E0D 42D8 7608 2688 DA1A
gpg: Signature made 2021/6/12 0:04:11 й׼ʱ
gpg:                using RSA key 5B80C5754298F0CB55D8ED6ABCEF7E294B092E28
gpg: Good signature from "Andre Heinecke (Release Signing Key)" [full]
```



命令行操作基本上够用了，不过毕竟在 `Windows` 上我们主要还是要用 `GUI` 程序嘛，这样比较直观易操作。

来都来了，不打开看看怎么行？

我们打开 `Kleopatra` 来看看如何操作校验文件。



### `GUI` 方式校验文件

打开 `Kleopatra` ，工具栏内点击 `解密/校验...` 一项。

图07



在弹出的浏览文件窗口中选择你要检验的文件，比如本例的 `gpg4win-3.1.16.exe` 。

当然，别忘记前面说过的，校验文件 `gpg4win-3.1.16.exe.sig` 应该已经放在一起了。

之后程序就会自动开始校验并得出结果。

图08



从图中我们可以看到，校验结果失败，具体原因我们可以点击一下那个 `显示审核日志` 来查看。

图09



具体失败的原因是由于我们当前使用的系统中缺少相应的公钥，导致无法对比计算因而失败。

说话怎么蹦出来个公钥，然后这个公钥又要去哪里找呢？



### 寻找 `OpenPGP keyserver`

这也是我一开始懵逼的地方，但我大体知道非对称加密的一些琐碎知识，因此我就在网上开始寻找公钥服务器。

由于保存庞大数量的公钥是一个极其艰巨的工作，因此能够提供存放并能查询公钥的网络服务少之又少。

经过多次尝试失败后，我终于找到了正宗合拍的公钥 `KeyServer` 了。

> https://peegeepee.com



这个网站很牛叉，页面左上角就提供了 `GPG` 对应公钥的查询功能搜索栏。

图10



搜索栏输入 **`RSA` 密钥最后8位**，即可获取到相应的公钥。

这个 `RSA` 密钥可以到前面执行校验命令时输出信息中找到。

点击那个下载按钮就可以将公钥下载下来啦。

图11



经过我自己测试，建议小伙伴们不要用 `Kleopatra` 的服务器查找功能，似乎根本就没啥用，还是将公钥下载来导入。

其实如果用命令行来导入公钥的话会非常简单。

```
// 查找公钥后直接导入系统
gpg --recv-keys 1A3B5C78
```



不过有可能会失败，猜测原因可能是 `KeyServer` 设置有问题，我是将 `Kleopatra` 设置中的密钥服务器修改成 `hkps://peegeepee.com` 后才成功的。

图12



如果你不想修改设置，那么还可以用另一个命令，指定好 `keyserver` 来尝试获取公钥证书。

```
gpg --keyserver hkps://peegeepee.com --search-keys 1A2B3C4D
```

图13



### 公钥认证

公钥通常会被保存到下面的路径中。

```
C:/Users/用户名/AppData/Roaming/gnupg/publickey.kbx
```



但是就算成功导入了公钥，仍会有未认证的问题存在。

图14



这时，我们就需要先认证导入过的公钥，然后再回来校验文件。

公钥导入后刷新 `Kleopatra` 会看到相应的公钥信息，右键点击后在菜单上选择 `认证...` 。

图15



提示需要创建一个自己的 `OpenPGP` 证书才能用来证明这些公钥证书。

图16



输入一些信息，创建就完成了。

图17

图18



接下来前面导入的公钥证书也就被正常接受了。

图19

图20



最后再回来校验我们下载的文件，就可以OK了。

图21



### 写在最后

关于 `PGP` 的内容我也接触不多，以上内容记录可能存在不少错误，请小伙伴们批评指正。

经过前面的介绍，我们也能看得出，与 `sha256` 之类的对照哈希值相比较，`PGP` 校验要麻烦得很多。

实际上 `PGP` 用来校验文件只是它的众多用途之一罢了，主要它还是用作信息的加解密、签名等等。

比如，当我们打开某个程序文件（比如 `gpg4win-3.1.16.exe` ）的属性窗口，就能看到其中多了一个数字签名的选项卡。

图22



点击详细信息我们还能看到具体的关于这个文件的数字签名信息，比如摘要算法、出自哪个组织。

一般对出身比较看中的程序文件都会带有这个数字签名信息，用以表示其来路正宗、身份可靠。

还有我们经常安装驱动程序时遇到的数字签名确认场景，所以说，数字签名彰显了一个程序文件的高贵身份！

当然了，数字签名也只是 `PGP` 的应用之一，但只要有信息的交换，就一定有它的身影。

好了，关于 `PGP` 的知识还有很多很多，以后如果有机会还会和小伙伴们一块儿来分享。



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

