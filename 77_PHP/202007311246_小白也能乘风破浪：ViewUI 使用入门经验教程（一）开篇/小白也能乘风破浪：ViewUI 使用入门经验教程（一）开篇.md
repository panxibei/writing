小白也能乘风破浪：ViewUI 使用入门经验教程（一）开篇

副标题：开篇



我虽然是一个小白，但我也是有梦想的。

我无时不刻地梦想着哪天能熟练驾驭WEB前端开发的一切，跻身开发牛人行列。

但是梦想再怎么丰满，而现实依然还是那么的骨感，残酷才是现实本来的真面目。

图1



面对着众多眼花缭乱的编程语言和开发储备知识，我嘴角微微抽搐了一下，慢慢地举起了双手！

No No！你想多了，我不是要投降，我是想鼓掌啊，只不过是眼含两行泪水。

到底这世界上有没有可以拯救小白的救世主呢，他到底在哪里？

我从未停止寻找的步伐，直到我幸运地遇见了 `View UI` ！





## 第一弹：开篇



#### 俗套的简介

`View UI` 是一套基于 `Vue.js` 的开源 `UI` 组件库，这套组件库主要用于PC端界面，是传说中的高档前端框架之一。

这个 `View UI` 目前是 `4.x` 版本，它有个前辈 `3.x` 版本，大名叫 `iView` 。

我们这里只讲 `View UI` ，年轻就是好嘛！

如果你想用到移动端，那么它还有一个远房亲戚，叫做 `iView Weapp` ，不过我们是小白嘛，所以先来点简单的，这儿主要就是讲PC端界面的。

官网链接：https://www.iviewui.com/



#### 前提和必要条件

首先， `View UI` 是基于 `Vue.js` 的框架组件，要想学习了解 `View UI` ，就必须先了解一些 `Vue.js` 的基础知识。

各大网站上都有相关讲解教程，如果你还不懂就赶快去学习一下吧。



其次， `View UI` 作为前端框架，在运用时往往会涉及到与后台交互，所以在开始之前，强烈建议你务必先搭建个WEB环境。

如果你想在Windows下搭建LAMP式的简单WEB测试环境，那么推荐你使用 `WampServer` 。

搭建环境很难吗？

别怕，我这儿有参考链接，很容易上手的：

> [WampServer最新版一键安装](https://www.sysadm.cc/index.php/webxuexi/746-wampserver-one-click-install)
>
> [WAMPSERVER仓库镜像（中文）](https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files)



#### 快速上手，先来个初步的感性认识

打开官方网站，其中有很详实的组件库使用说明。

作为小白的我们要开始学习和使用它，通常会从如何安装入手，对不对？

OK！本教程正是小白向教程，想小白之所想，所以怎么简单、怎么容易实现就怎么来。



官网介绍中有使用 `CDN` 方式引入 `View UI` ，这种方式简单，按照官网说明来做就是了。

这里先简单解释一下，所谓的 `CDN` 方式，我的理解是像传统方式一样直接引用 `js` 和 `css` 等所需的文件。

比如像这个样子：

```
<!-- 引入 Vue.js -->
<script src="//vuejs.org/js/vue.min.js"></script>

<!-- 引入 stylesheet -->
<link rel="stylesheet" href="//unpkg.com/view-design/dist/styles/iview.css">

<!-- 引入 iView -->
<script src="//unpkg.com/view-design/dist/iview.min.js"></script>
```



简单地讲，就是先引入 `Vue.js`  ，再引入 `View UI` 的 `css` ，最后引入 `View UI` 的 `js` 。

官网给出了一个简单示例，通过 `CDN` 引入方式即可快速实现组件运用。

我来看看它长什么样子：

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ViewUI example</title>
    <link rel="stylesheet" type="text/css" href="http://unpkg.com/view-design/dist/styles/iview.css">
    <script type="text/javascript" src="http://vuejs.org/js/vue.min.js"></script>
    <script type="text/javascript" src="http://unpkg.com/view-design/dist/iview.min.js"></script>
</head>
<body>
<div id="app">
    <i-button @click="show">Click me!</i-button>
    <Modal v-model="visible" title="Welcome">Welcome to ViewUI</Modal>
</div>
<script>
    new Vue({
        el: '#app',
        data: {
            visible: false
        },
        methods: {
            show: function () {
                this.visible = true;
            }
        }
    })
  </script>
</body>
</html>
```



这个例子所要显示的页面只有一个按钮，这个按钮上的文字写着 `Click me!` 。

点击这个按钮，会弹出写有 `Welcome to ViewUI` 字样的对话框。

怎么样？这个例子够简单吧？

接下来我们一起体验一把做做看。



打开你喜欢的文本编辑器，对，就是你喜欢的，不喜欢你也不会打开对吧。

当然啦，用记事本也是可以的，不过可能会有编码异常的问题，所以我推荐你用 `Notepad++` 之类更高级一点的编辑器。

好了，依葫芦画瓢，我们把例子中的代码原封不动地复制粘贴到文本编辑器中。

图2



我们在 `Wamp` 的 `www` 目录下新建一个名称为 `sysadm.cc` 的项目目录。

然后在其下再新建一个名称为 `test01` 的目录，将代码保存在其中并命名为 `example01.html` 。

```
C:\Wamp\www\sysadm.cc\test01\example01.html
```



保存好了，我们来打开测试一下。

在此之前，应该确保你的WEB环境运行正常。

好，打开火狐浏览器，在地址栏中输入网址 `http://127.0.0.1/sysadm.cc/test01/example01.html` 后回车。

哎，这是什么鬼？

怎么只有一串洋字码，除此之外一片空白？

按下 `F12` 打开火狐的控制台，发现其中混入了奇怪的东西。

图3



**“已阻止载入混合活动内容”** 的提示似乎已经告诉我们，`View UI` 的 `js` 和 `css` 引入已经完全失败。

故页面只显示出英文字母，而没有任何显示和功能效果。

那这个问题怎么盘它呢？

有两个办法：

1. 可能是由于 `https` 中包含引用了 `http` 的链接内容，将 `http` 修改为 `https` 即可。
2. 求人不如求己，有个笨一点儿却简单有效的办法，那就是把 `View UI` 保存到本地随时为我所用。



###### 方法一：修改 `http` 为 `https`

```html
<!-- 引入 Vue.js -->
<script src="https://vuejs.org/js/vue.min.js"></script>

<!-- 引入 stylesheet -->
<link rel="stylesheet" href="https://unpkg.com/view-design/dist/styles/iview.css">

<!-- 引入 iView -->
<script src="https://unpkg.com/view-design/dist/iview.min.js"></script>
```



###### 方法二：本地化 `View UI`

方法一修改起来虽然简便，但由于页面加载速度是个大问题，所以在今后的学习使用中更加快捷有效，可以考虑在本地磁盘上保存一份 `View UI` 引用。

打开 `View UI` 在 `GitHub` 的链接：[https://github.com/view-design/ViewUI/releases](https://github.com/view-design/ViewUI/releases)

找到最新版本 `Latest release` 字样，目前最新版为 `v4.3.2` ，我们下载那个 `zip` 文件吧。

图4



下载 `ViewUI-4.3.2.zip` 完成后，把其中的 `dist` 目录解压出来。

图5



在这个 `dist` 目录中，我们可以看到有很多文件。

其中，带有 `min` 字样的是压缩的、可用于生产环境的文件，我们演示也可以直接用它们。

把这个 `dist` 目录复制到我们的项目目录中，就像这样： `C:\Wamp\www\sysadm.cc\test01\dist\` 。

图6



好，我们有了 `View UI` ，不过我们还不能开始测试使用。

为啥子，它不香？

哈哈，别忘了， `View UI` 是基于 `Vue.js` 的，我们还需要找到 `Vue.js` ，否则单单有 `View UI` 也是玩不转的。

如图，我们按网页上的链接直接下载 `vue.min.js`  文件。

图7



下载完成后，我们可以打开看一下这个 `vue.min.js` 文件。

可以看到，文件版本是 `v2.6.11` ，是当前 `vue.js 2.x` 的最新版，而 `View UI` 正是需要 `2.x` 版的。

好，我们把 `vue.min.js`复制到项目目录中，就像这样： `C:\Wamp\www\sysadm.cc\test01\vue.min.js` 。

图8



OK，各大高手到齐，最后应该像这个样子。

图9





我们来修改一下示例文件中的引用路径。

```html
<link rel="stylesheet" type="text/css" href="dist/styles/iview.css">
<script type="text/javascript" src="vue.min.js"></script>
<script type="text/javascript" src="dist/iview.min.js"></script>
```

其他内容不变，修改好后就是这个样子：

图10



再次打开浏览器，这次不一样了哦，出现了一个按钮！

图11



赶快点击这个按钮看看，哇，太酷了，弹出了一个对话框！

图12



是不是有点小激动呢？

哈哈，这才刚刚开始呢！

今天只是做个开头，后面还有很多丰富的内容等着我们去探索学习。

示例中的按钮也好、对话框也好，都是 `View UI` 的基本组件，以后我们会更加深入地去了解。

打起精神来哦骚年，做好接下来乘风破浪的准备吧。



**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test01.7z：https://o8.cn/fP8wcG    密码：1zn0



> WeChat @网管小贾 | www.sysadm.cc

