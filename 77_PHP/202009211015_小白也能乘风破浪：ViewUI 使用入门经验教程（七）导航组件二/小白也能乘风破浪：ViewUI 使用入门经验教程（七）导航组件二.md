小白也能乘风破浪：ViewUI 使用入门经验教程（七）导航组件二

副标题：导航组件二~



东方明珠塔，魔都上海的地标性建筑，相信你就算没到过上海，电视上也不少见吧。

登塔是很多人的梦想，只要是到了上海，大概率都希望能登上塔顶一览黄浦江的美景。

欣赏美景完全可以理解，但你见过有人爬到顶端，在疾风中手捧长卷品读名著吗？

呃，爬得有点高，这是弄啥哩？



此情此景你尽可以发挥想像，只身屹立于雄伟的东方明珠塔顶之上，手中拽着数百米长的卷筒纸，拖着长长的鼻涕在风中摇摇欲坠......

知道的，说你是在挑战极限冲击吉尼斯纪录，不知道的，可能惊吓到立马帮你打了个电话，号码是110！

我要是告诉你，你手里拿的不是卷筒纸而是一本长篇名著，只是无法折叠，为了纵情阅读更多而冒险登高。

你肯定会呵呵哒，心想我还年轻，上面风大我先下来，不就看书嘛，好商量......



问题来了，你见过卷筒纸式的一本书吗？

反正我是没见过，不过想像归想像，为了避免把阅读长篇名著变成极限运动，就要把卷筒纸想办法折叠起来变成一页一页的书本，于是伟大的分页技术应运而生。



## 第七弹：导航组件二



#### 四、分页 - Page

现在的书本都是一页一页的翻看，不用爬那么高。

不过在页面设计中，如何做到分页呢？

好办，来看看代码就知道了。

```html
<Page :total="99"></Page>
```

图1



最简单的情况，只要给出总页数 `total` 即可，它会按每页10项分页。

当你去点击任何一个按钮时，它会自动切换到指定页。

当然了，这只是表象，你还需要再做一些工作，它才能正确执行以便显示正确的页面内容，具体的你耐心看下去就知道了。



默认每页是10条记录，那我想变成每页20条行不行呢？

当然可以了，加个 `show-sizer` 就可以选择了。

```html
<Page :total="100" show-sizer></Page>
```

图2



我想快速跳转到我想要的那一页，这个好办，给它按上一部电梯 `show-elevator` 。

是的，就是电梯，可以选楼层直达的那种，像这样。

```html
<Page :total="100" show-elevator></Page>
```

图3



还可以显示记录总数，关键字 `show-total` 。

```html
<Page :total="100" show-total></Page>
```

图4



以上几个展示变量都是 `show` 开头的哦，它们可以被同时使用。

除了这些展示变量外，在实际前后端交互的情况下，还要用到以下这些变量。

| 变量属性       | 说明               |
| -------------- | ------------------ |
| current        | 当前页码           |
| total          | 数据总数           |
| page-size      | 每页条数           |
| page-size-opts | 每页条数切换的配置 |



这些变量才是最关键的，是需要动态获取或指定的。

作为演示，我只设定了本地变量来演示，实际运用中应该通过前后端交互来实现变量值的变动。

```html
<Page :current="current"
      :total="total"
      :page-size="page_size"
      :page-size-opts="page_size_opts"
      show-sizer
      show-total>
</Page>

<script>
    new Vue({
        el: '#app',
        data: {
			current: 6,
			total: 666,
			page_size: 30,
			page_size_opts: [10, 15, 30, 50, 100]
        },
    })
</script>
```

图5



从图中可看出，一共666条记录，当前是第6页。

而每页30条，一共23页，我们通过计算（666除以30等于22.2）结果的确没错。

**这里要啰嗦一句，因为分页涉及到众多变量，往往在设计和调试时很容易搞混，一定要注意逻辑结果的正确性。**

比如，明明一共100条记录每页50条记录，却显示有10个分页（实际应该只有2页）。



以上分页变量是我们手动指定的，但对于用户来说，他们只会点点点。

所以，点点点才是日常操作，那么通过对分页按钮的点点点怎么让页面内容真正实现翻页呢？

让我们请出分页事件 `on-change` 。

代码如下：

```html
<Page :current="current"
      :total="total"
      :page-size="page_size"
      :page-size-opts="page_size_opts"
      show-sizer
      show-total
      
      @on-change="page=>onchange(page)">
</Page>

<script>
    new Vue({
        el: '#app',
        data: {
			current: 6,
			total: 666,
			page_size: 30,
			page_size_opts: [10, 15, 30, 50, 100]
        },
        methods: {
            ......
            
			onchange (page) {
				alert(page);
                ......
			}
        }
    })
</script>
```



很容易做到，在原有代码基础上追加 `@on-change` 事件代码，通过传递参数可获取你点击的**当前页码**，并发送到后端进一步获取这一页的内容信息。

这里要注意哦，`on-change` 事件返回的是改变后的页码，也就是你点击的新页码。



另外还有一个 `on-page-size-change` ，这个就是用来改变每页有多少条记录的，返回值是**切换后的每页条数**。

和 `on-change` 事件代码差不多，回调切换后的每页条数，然后就可以尽情发挥你的想像了。

```html
<Page :current="current"
      :total="total"
      :page-size="page_size"
      :page-size-opts="page_size_opts"
      show-sizer
      show-total
      
      @on-page-size-change="pagesize=>onpagesizechange(pagesize)">
</Page>

<script>
    new Vue({
        el: '#app',
        data: {
			current: 6,
			total: 666,
			page_size: 30,
			page_size_opts: [10, 15, 30, 50, 100]
        },
        methods: {
            ......
            
			onpagesizechange (pagesize) {
				alert(pagesize);
                ......
			}
        }
    })
</script>
```



分页 `Page` 基本上就是涉及几个变量和两个事件的操作。

虽然看似还算简单能够理解，但对于小白来说，可能真正涉及到实际项目的代码时难免会懵圈。

通常表格是分页组件的黄金搭档，这哥儿俩搭配在一起干活的情况非常多，在以后的实战教程中我们会详细掰扯，现在先以理解熟悉为主吧。



#### 五、面包屑 - Breadcrumb

面包屑就是面包的碎渣渣，是可以吃的哦。

但在这里，我们讲的肯定不是可以吃的面包渣渣，而是页面前端设计中的导航组件的一种。

那怎么来认识和理解这个组件呢？



据说这个面包屑还和《格林童话》有那么一段渊源。

《格林童话》中有两个小孩子，也就是两位小主人公，为了不被继母遗弃，走过森林的时候故意扔下了面包屑作为回家的路标。

可惜面包屑是可以吃的，被鸟儿啄食，干净得连渣都不剩。

童话其实是成年人世界的缩影，童话本真往往充斥着黑暗，并不是一般情况下人们想像的那么美好。

不过还好，小伙伴们不用担心哈，我们的面包屑导航组件并不会魔术般地凭空消失。



基本代码：

```html
<Breadcrumb>
    <Breadcrumb-Item to="https://www.sysadm.cc">FC游戏</Breadcrumb-Item>
    <Breadcrumb-Item to="https://www.sysadm.cc">动作游戏</Breadcrumb-Item>
    <Breadcrumb-Item>超级玛丽</Breadcrumb-Item>
</Breadcrumb>
```

图6



小伙伴们也看到了吧，在 `to` 的后面加上链接，点击它就会跳转哦。

通常情况下，最后一项也就当前页面是不需要跳转链接的，所以也就没有那个 `to` 了。

此外，如果你想让链接跳转到新窗口中，那么给它加个 `target="_blank"`  属性即可。

```html
<Breadcrumb>
    <Breadcrumb-Item to="https://www.sysadm.cc" target="_blank">FC游戏</Breadcrumb-Item>
    ......
</Breadcrumb>
```



光有文字干巴巴、太枯燥，一点儿也不童话，来点图标点缀一下吧。

```html
<Breadcrumb>
	<Breadcrumb-Item to="https://www.sysadm.cc">
		<Icon type="ios-game-controller-b"></Icon> FC游戏
	</Breadcrumb-Item>
	<Breadcrumb-Item to="https://www.sysadm.cc">
		<Icon type="ios-game-controller-a"></Icon> 动作游戏
	</Breadcrumb-Item>
	<Breadcrumb-Item>
		<Icon type="logo-octocat"></Icon> 超级玛丽
	</Breadcrumb-Item>
</Breadcrumb>
```

图7



好看多了不是？

嗯，默认的分隔符 `/` 有点丑，换个口味儿？

利用 `separator` 属性来自定义分隔符，喜欢什么就用什么。

```html
<Breadcrumb separator="=>">
    ...
</Breadcrumb>
```

图8



有个性，挺好玩吧。

合理使用面包屑导航组件，会使得页面布局看上去更加正规上档次，不信你可以尝试用用看。



到此今天介绍的内容就这些了，不多哦，小伙伴们可以少做点作业啦，可以多出去玩玩了。

正值金秋时节，难得的秋高气爽，过几天就是中秋国庆，再不外出活动活动游玩一番，错过了时间天气可就真的快要变冷了。

据说今年中秋国庆全国各旅游景区总游客流量预估可能超6亿人次。

多么振奋人心的好消息啊！

小伙伴们还不鼓掌祝贺，如此大好形势，赶快与家人朋友们约好走起吧！

我能想到的最浪漫的事儿，就是和你一起去看人海！





**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test07.7z：https://www.90pan.com/b2119551    密码：rphr



> WeChat @网管小贾 | www.sysadm.cc



