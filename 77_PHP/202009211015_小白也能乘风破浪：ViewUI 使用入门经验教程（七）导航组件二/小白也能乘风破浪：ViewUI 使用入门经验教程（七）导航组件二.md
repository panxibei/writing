小白也能乘风破浪：ViewUI 使用入门经验教程（七）导航组件二

副标题：导航组件二



东方明珠塔，上海的地标性建筑，相信你就算没到过上海，电视上也不少见吧。

登塔是很多人的梦想，只要是到了上海，谁都希望能登上塔顶一览黄浦江的美景。

欣赏美景完全可以，但你见过有人爬到顶端品读长篇名著吗？



你尽可以发挥想像，只身屹立于雄伟的东方明珠塔顶之上，手中拽着数百米长的卷筒纸，拖着长长的鼻涕在风中摇摇欲坠......

爬得有点高，这是弄啥哩？

知道的，说你是在挑战极限冲击吉尼斯纪录，不知道的，可能惊吓到立马帮你打了个电话，号码是110！



你告诉我你手里拿的不是卷筒纸而是一本长篇名著，只是没有折叠，为了阅读更多而登高。

我嘴角呵呵哒，你还年轻，上面风大你先下来，书不是这么看滴。

为避免把阅读名著变成极限运动，就要把卷筒纸变成一本书，于是伟大的分页技术应运而生。



## 第七弹：导航组件二



#### 四、分页 - Page

现在的书本都是一页一页的，看书总算不用爬那么高了。

不过页面设计中怎么分页呢？

好办，来看看代码就知道了。

```html
<Page :total="99"></Page>
```

图1



最简单的情况，只要给出总页数 `total` 即可，它会按每页10项分页。

当你去点击任何一个按钮时，它会自动切换到指定页，当然了，这是没用的，你需要再做一些工作它才能正确执行以便显示正确的页面内容，具体的你耐心看下去就知道了。



默认每页是10条记录，那我想变成每页20条行不行呢？

当然可以了，加个 `show-sizer` 就可以。

```html
<Page :total="100" show-sizer></Page>
```

图2



我想快速跳转到我想要的那一页，好办，给它按上一部电梯 `show-elevator` 。

是的，就是电梯，可以直达的那种，像这样。

```html
<Page :total="100" show-elevator></Page>
```

图3



还可以显示记录总数，关键字 `show-total` 。

```html
<Page :total="100" show-total></Page>
```

图4



以上几个 `show` 开头的展示变量可以同时使用。

除了这些展示变量外，在实际前后端交互的情况下，还要用到以下这些变量。

| 变量属性       | 说明               |
| -------------- | ------------------ |
| current        | 当前页码           |
| total          | 数据总数           |
| page-size      | 每页条数           |
| page-size-opts | 每页条数切换的配置 |



这些变量才是最关键的，是需要动态获取或指定的。

作为演示，我只设定本地变量来演示，实际运用中应该通过前后端交互来实现变量值的变动。

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

这里要啰嗦一句，因为分页涉及到众多变量，往往在设计和调试时很容易搞混，一定要注意逻辑结果的正确性。



以上分页变量是我们手动指定的，但对于用户来说，他们只会点点点。

所以，点点点才是日常操作，那么通过对分页按钮的点点点怎么让内容真正实现翻页呢？

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

面包屑就是面包的渣渣，是可以吃的。

但我们讲的肯定不是可以吃的面包渣渣，而是页面前端设计中的导航组件的一种。

那怎么理解这个组件呢？

据说这个面包屑还是从《格林童话》中引申出来的。

童话中的两个小孩子，也就是两位小主人公为了不被继母遗弃，经过森林的时候故意扔下了面包屑作为返回的路标。

可惜面包屑是可以吃的，被鸟儿啄食。

童话其实是成年人世界的缩影，往往充斥着黑暗，并不是孩子们想像的美好。

不过还好，不用担心，我们的面包屑导航组件不会魔术般地凭空消失。



基本代码：

```html
<Breadcrumb>
    <Breadcrumb-Item to="https://www.sysadm.cc">FC游戏</Breadcrumb-Item>
    <Breadcrumb-Item to="https://www.sysadm.cc">动作游戏</Breadcrumb-Item>
    <Breadcrumb-Item to="https://www.sysadm.cc">超级玛丽</Breadcrumb-Item>
</Breadcrumb>
```



















**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test07.7z：https://o8.cn/a539KZ    密码：xp55



> WeChat @网管小贾 | www.sysadm.cc



