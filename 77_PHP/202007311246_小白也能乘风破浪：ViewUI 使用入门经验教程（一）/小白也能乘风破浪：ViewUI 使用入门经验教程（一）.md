小白也能乘风破浪：ViewUI 使用入门经验教程（一）

副标题：开篇介绍



我虽然是一个小白，但我也有梦想，无时不刻地梦想着哪天能熟练驾驭WEB开发的一切，同时跻身于WEB开发牛人行列。

但是梦想再怎么丰满，而现实依然还是那么的骨感，残酷才是现实本来的面目。

面对着众多眼花缭乱的编程语言和开发储备知识，我默默地举起了我的双手！

NO！你想多了，我不是要投降，我是想鼓掌，只不过是含泪微笑着鼓掌。

快要郁闷至死的我差点去买《平安经》，一看炒到上千元的价格吓得手又缩了回来。

我一直在思考，到底这世界上有没有可以拯救小白的救世主，他到底在哪里？

直到我幸运地遇见了 `View UI` ！





## 第一弹：开篇介绍



#### 俗套的简介

`View UI` 是一套基于 `Vue.js` 的开源 `UI` 组件库，这套组件库主要用于PC端界面，是传说中的高档前端框架之一。

这个 `View UI` 目前是 `4.x` 版本，它有个前辈 `3.x` 版本，大名叫 `iView` 。

我们这里只讲 `View UI` ，年轻就是好嘛！

如果你想用到移动端，那么它还有另外一个远房亲戚，叫做 `iView Weapp` ，不过我们是小白嘛，所以先来点简单的，这儿主要就是讲PC端界面的。

官网链接：https://www.iviewui.com/



#### 学习演示的前提必要条件

因为学习使用 `View UI` 时，往往会涉及到后台交互，所以在开始之前，强烈建议你务必先搭建个WEB环境。

如果你想在Windows下搭建LAMP式的简单WEB测试环境，那么推荐你使用 `WampServer` 。

搭建环境很难吗？

别怕，我这儿有参考链接，很容易上手的：

> [WampServer最新版一键安装](https://www.sysadm.cc/index.php/webxuexi/746-wampserver-one-click-install)
>
> [WAMPSERVER仓库镜像（中文）](https://www.sysadm.cc/index.php/xitongyunwei/720-repository-of-wampserver-files)



#### 快速上手、感性认识

打开官方网站，其中有很详细丰富的组件库使用说明。

我们学习使用它，肯定会从如何安装入手。

本教程是小白教程，所以怎么简单怎么容易实现怎么来。

我们使用 `CDN` 方式引入，按照官网说明来做。

先解释一下，所谓的 `CDN` 方式，我的理解是像传统方式一样直接引用 `js` 和 `css` 等所需的文件。

比如这个样子：

```
<!-- 引入 Vue.js -->
<script src="//vuejs.org/js/vue.min.js"></script>

<!-- 引入 stylesheet -->
<link rel="stylesheet" href="//unpkg.com/view-design/dist/styles/iview.css">

<!-- 引入 iView -->
<script src="//unpkg.com/view-design/dist/iview.min.js"></script>
```



官网给出了一个简单示例，通过CDN引入方式即可快速实现组件运用。

我来看看它的样子：

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



这个例子很简单，打开后页面只有一个按钮，按钮文字写着 `Click me!` 。

点击这个按钮，会弹出写有 `Welcome to ViewUI` 字样的对话框。

接下来我们一起做做看。



打开你喜欢的文本编辑器，对，就是你喜欢的，用记事本也是可以的，不过我喜欢 `Notepad++` ，推荐你用这个。

依葫芦画瓢，把代码原封不动地复制粘贴到文本编辑器中。

图1



我们把它保存下来，比如我这边在 `Wamp` 的 `www` 目录下新建了一个目录 `sysadm.cc` 。

然后保存在 `test01` 目录中，命名为 `01.html` 。

```
C:\Wamp\www\sysadm.cc\test01\example01.html
```



保存好了，我们来打开测试一下。

首先确保你的WEB环境运行正常，打开浏览器，在地址中输入网址 `http://127.0.0.1/sysadm.cc/test01/example01.html` 后回车。

哎，这是什么鬼？

怎么只有一串洋字码，除此之外一片空白？

按下 `F12` 打开火狐的控制台，发现其中混入了奇怪的东西。

图2



**“已阻止载入混合活动内容”** 的提示似乎已经告诉我们，`View UI` 的 `js` 和 `css` 引入已经完全失败。

所以页面只显示出英文字母，而没有任何效果。

那这个问题怎么盘它呢？

求人不如求己，只有一个笨却简单的办法，那就是把 `View UI` 保存到本地随时为我所用。



打开 `View UI` 在 `GitHub` 的链接：`https://github.com/view-design/ViewUI/releases` 。

找到最新版本 `Latest release` 字样，目前最新版为 `v4.3.2` ，我们下载那个 `zip` 文件吧。

图3



下载 `ViewUI-4.3.2.zip` 完成后，把其中的 `dist` 目录解压出来。

图4



在这个 `dist` 目录中，我们可以看到有很多文件。

其中，带有 `min` 字样的是压缩过的、可用于生产环境的文件，等会我们直接用它们。

把这个 `dist` 目录复制到我们的项目目录中，就像这样： `C:\Wamp\www\sysadm.cc\test01\dist\` 。

图5



好，我们有了 `View UI` ，不过我们还不能开始测试使用。

为啥？

原因很简单哈，因为 `View UI` 是基于 `Vue.js` 的，我们还需要找到 `Vue.js` ，否则单单有 `View UI` 也是玩不转的。

如图，我们按网页上的链接直接下载 `vue.min.js`  文件。

图6



下载完成后，我们可以打开看一下这个 `vue.min.js` 文件。

可以看到，文件版本是 `v2.6.11` ，是当前 `vue.js 2.x` 的最新版，而 `View UI` 正是需要 `2.x` 版的。

好，我们把 `vue.min.js`复制到项目目录中，就像这样： ``C:\Wamp\www\sysadm.cc\test01\vue.min.js` 。

图7



OK，各大高手到齐，我们来修改一下前面的示例文件中的引用路径。

```html
<link rel="stylesheet" type="text/css" href="dist/styles/iview.css">
<script type="text/javascript" src="vue.min.js"></script>
<script type="text/javascript" src="dist/iview.min.js"></script>
```

其他内容不变，修改好后就是这个样子：

图8



再次打开浏览器，这次不一样了哦，出现了一个按钮！

图9



点击这个按钮看看，哇，弹出了一个对话框！

图10



是不是有点小激动呢？

哈哈，这才刚刚开始呢！

今天只是做个开头，后面还有很多丰富的内容等着我们去探索学习。

打起精神来少年，做好接下来乘风破浪的准备吧。



> WeChat @网管小贾 | www.sysadm.cc











