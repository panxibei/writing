小白也能乘风破浪：ViewUI 使用入门经验教程（七）导航组件二

副标题：导航组件二



同村的流浪哥和我年龄相仿，是个铁杆游戏迷。

不过他是个怀旧的老年人，不同于热衷于手游的小年轻，他喜欢玩FC游戏。

FC就是 `Family Computer` 的缩写，FC游戏机又因为颜色红白相间，所以又被称为红白机。

不用我多解释，它是80后90后共同的记忆，而流浪哥对FC甚是着迷。

他经常收集各种类别的FC游戏，渐渐地数量多了起来。

一次性列出所有的游戏名单似乎太LOW了不是？

我建议他通过分页来管理名单内容。



## 第七弹：导航组件二



#### 四、分页 - Page

东方明珠，上海的地标性建筑，就算你没去过那儿，电视上也不少见吧。

你尽可以想像，你屹立在东方明珠的塔顶之上，手拿着数百米长的卷筒纸在风中摇摇欲坠......

知道的，说你是挑战极限阅读四大名著，不知道的，可能激动地帮你打了个电话，号码是110！

就不能响应一下国家节能环保的号召，把那么长的东西折叠起来看吗，也省得爬那么高啊！

为避免登高作业的危险，于是伟大的分页技术应运而生。



不错，伟大的发明，书本名著可以一页一页地慢慢品读了，但页面内容怎么整？

好办，来看看代码就知道了。

```html
<Page :total="99"></Page>
```

图1



默认情况下，只要给出总页数 `total` 即可，它会按每页10项分页。

当你去点击任何一个按钮时，它会自动切换到指定页，当然了，你要做一些工作它才能正确执行，具体要在后面讲到。



默认每页是10条记录，那我想变成每页20条行不行呢？

当然可以，加个 `show-sizer` 就可以。

```html
<Page :total="100" show-sizer></Page>
```

图2



我想快速跳转到我想要的那一页，那么就给它按上电梯 `show-elevator` 。

是的，就是电梯，可以直达的那种。

```html
<Page :total="100" show-elevator></Page>
```

图3



还可以显示记录总数，关键字 `show-total` 。

```html
<Page :total="100" show-total></Page>
```

图4



除了以上几个 `show` 开头的展示变量外，在实际前后端交互的情况下，还要用到以下这些变量。

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

所以，点点点才是日常操作，那么通过对分页的点点点怎么让内容真正实现翻页呢？

分页事件来了，请出 `on-change` 。

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

在原有代码基础上追加 `@on-change` 事件代码，通过传递参数可获取当前页，并发送到后端进一步获取前一页的内容信息。

这里要注意的是，`on-change` 事件返回的是改变后的页码，也就是你点击的新页码。



另外还有一个 `on-page-size-change` ，这个就是用来改变每页有多少条记录的，返回值是切换后的每页条数。

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



分布 `Page` 基本上就是涉及几个变量和两个事件的操作。

虽然看似还能理解，但对于小白来说，可能真正涉及到实际的代码时难免会懵圈。

通常表格是分页组件的黄金搭档，这哥儿俩搭配一起干活的情况非常多，在以后的实战教程中我们会详细说明，现在先以理解为主吧。











很简单啊，好比一本名著，把那么多的文字内容分成若干页面，然后我们就可以一页一页地读取了。





说到分页，我想小伙伴们肯定不会陌生。



我们淘宝的时候要查找某一商品，往往第一页中的内容并不会令我们满意。

那怎么办呢？

我们可以点击 `下一页` 或 `指定页` 。









**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test07.7z：https://o8.cn/a539KZ    密码：xp55



> WeChat @网管小贾 | www.sysadm.cc



