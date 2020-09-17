小白也能乘风破浪：ViewUI 使用入门经验教程（六）导航组件一

副标题：导航组件一



乔家大院闻名于世，想必就算是没有去过的小伙伴们也都应该略有耳闻吧。

说到乔家大院，如今它的名头可不小哩，既是见证历史的文物古建筑，又是网红热门的旅游打卡胜地。

不过，你知道吗，在去年（2019年）它曾一度被取消了5A旅游景区质量等级资格！

我的天呐！5A景区啊，就这么随随便便给取消了？

到底怎么肥事情？



呵呵，你先别着急，如果你看过相关报道，也就不会惊觉奇怪了。

其根本原因无外乎现今各旅游景区都有的各类通病，如过度的商业化压抑着本该熠熠生辉的厚重历史气息，又如景区配套设施以及专业工作人员的匮乏等等。

积弊太多，亟待整改，这是群众的呼声，我当举双手双脚支持！

果然，经过数日的整改，乔家大院改头换面、焕然一新！

此次整改决心之坚、力度之大、变化之多，我们都是有目共睹的。

就拿其中一项措施来说，景区重新统一设计了园区导览图和标牌标识，整改得非常到位。

这个问题不可小觑哦，以前往往因标牌标识不清甚至误导，致使游客的旅游体验极差，有甚者连景区内的厕所都找不到，可见导览图及标牌标识的重要性不言而喻。

乔家大院的导览标识整改是成功的，那么在页面系统中要想让别人也有乔家大院式的5A级体验，毋庸置疑导航标识这方面的功夫务必也要做到最好。

我们来看看怎样用 `View UI` 来实现页面导航的5A级体验吧！



## 第六弹：导航组件一



#### 一、导航菜单 - Menu

众所周知，作为导航标识，用于引导用户进入相关的内容，传统中最土的办法就是放上几个超链接。

不过你也知道，土办法好用不好看，那么我们就来点好看的，这个导航菜单就是我们最先要提到的。

它作为菜单，不仅具有导航作用，还兼具菜单作用，可收罗大量的导航指令信息，不得不说是很高大上的，反正我常用到它。



基本代码框架是这个样子的：

```html
<i-Menu mode="" theme="" active-name="">
    <Menu-Item name="1">
        菜单项一
    </Menu-Item>
    <Menu-Item name="2">
        菜单项二
    </Menu-Item>
    <Menu-Item name="3">
        菜单项三
    </Menu-Item>
</i-Menu>
```



其中的几个参数， `mode` 是指菜单水平横向放置还是垂直放置，`theme` 主题可选黑色的还是白色， `active-name` 表示当前激活的是哪个菜单项。

我们来点实际的。

```html
<i-Menu mode="horizontal" theme="light" active-name="1">
    <Menu-Item name="1">
        <Icon type="ios-paper"></Icon>
        石雕
    </Menu-Item>
    <Menu-Item name="2">
        <Icon type="ios-book"></Icon>
        砖雕
    </Menu-Item>
    <Menu-Item name="3">
        <Icon type="ios-construct"></Icon>
        木雕
    </Menu-Item>
    <Menu-Item name="4">
        <Icon type="ios-sad"></Icon>
        沙雕
    </Menu-Item>
</i-Menu>
```

图1



上面的导航菜单项是横向的，要想竖着放，其他都不用动，改个 `mode` 参数即可 `mode="vertical"` 。

图2



这里要多说一句，每个菜单项的 `name` 并不一定是数字，名字你随便起，只要你能区别开来就行，所以 `active-name` 的值也就不一定是数字了，只要和 `name` 能对得上就行。



好，有了导航菜单项，我们就可以点击它进去浏览内容了，但是你可能会想到，如果有子菜单怎么办？

是啊，对于内容丰富、层次多样的导航来说，单单这样设计显示有点太简单了不是。

还好它叫菜单，是菜单它就有子菜单，子菜单还有子子菜单......

瞧下面，子菜单来了。

```html
<i-Menu mode="vertical" theme="light" open-names="['2']" active-name="2-3">
    <Submenu name="1">
        <template slot="title">
            <Icon type="ios-construct"></Icon>
            木雕
        </template>
        <Menu-Item name="1-1">木雕</Menu-Item>
        <Menu-Item name="1-2">木雕</Menu-Item>
        <Menu-Item name="1-3">木雕</Menu-Item>
    </Submenu>
    <Submenu name="2">
        <template slot="title">
            <Icon type="ios-sad"></Icon>
            沙雕
        </template>
        <Menu-Item name="2-1">你是沙雕</Menu-Item>
        <Menu-Item name="2-2">你才是沙雕</Menu-Item>
        <Menu-Item name="2-3">你才是大沙雕</Menu-Item>
    </Submenu>
</i-Menu>
```

图3



哇，一下子变得好复杂啊！

别急，我们分析一下。

其实你很容易就能看出，比前面介绍的代码中增加了 `Submenu` 的标记。

是的，它就是传说中的子菜单，然后再在 `Submenu` 中包含各种菜单项 `Menu-Item` 就欧了！

啊？你说什么，一层子菜单哪儿够？

如果一层不够那就再加一层，加一层爽一次，一直加一直爽！

```html
<Submenu>
    <template slot="title">
        ...
    </template>
    <MenuItem></MenuItem>
    <MenuItem></MenuItem>
    
    <Submenu>
        <template slot="title">
        	...
        </template>
        <MenuItem></MenuItem>
        <MenuItem></MenuItem>
    </Submenu>
</Submenu>
```



总之，子菜单就是一个菜单标题加上几个菜单项。

另外还多出来一个参数 `open-names="['2']"` ，它是指当前展开的菜单项，注意它的值的形式是数组。



有了这么多层的菜单项，我们就可以引导用户点击进入所选内容了。

哎，点击没反应呢？

呵呵哒，当然没反应了，你要给它加事件它才有反应呀，要不它也不知道要干吗！

最简单地，加个 `on-select` 事件一般就够用了。

```html
<i-Menu @on-select="name=>foo(name)">
    ...
</i-Menu>
```

图4



通过传参把菜单项的 `name` 传递给函数 `foo` 后，这个函数就可以拿着参数 `name` 的值干活了。

想要干什么活，当然是你想让用户干的事儿了，比如链接跳转等等，一般是导航用。



嘿嘿，导航菜单真强大，不过也不是哪儿都要用它的。

比如非顶部或侧边栏的一些区域，你放上一堆导航菜单项就显得有些小题大做了。

这个时候标签页 `Tabs` 可以登场了。



#### 二、标签页 - Tabs

说实话，这个标签页感觉应该属于布局方面的组件。

为什么这么说，只要你用过就知道，它完全是一种为了节省空间，把页面这种有限的2D平面世界活生生地变成了3D立体空间的布局高端利器。

这么简单地说吧，如果你一个页面放不下那么多的东西，没事儿，找标签页，妥妥地把它们都收纳进去。

毫不夸张地说，标签页正是页面设计中收纳控和强迫症者的福音。

就是这么神奇的存在，我们马上来瞄瞄。

```html
<Tabs value="name1">
	<Tab-Pane label="标签一" name="name1">标签一的内容</Tab-Pane>
	<Tab-Pane label="标签二" name="name2">标签二的内容</Tab-Pane>
	<Tab-Pane label="标签三" name="name3">标签三的内容</Tab-Pane>
</Tabs>
```



来点实际的，还带上个小图标装饰一下：

```html
<Tabs value="name1">
    <Tab-Pane label="HarmonyOS" name="name1" icon="ios-help-circle">
        HarmonyOS的内容
    </Tab-Pane>
    <Tab-Pane label="Android" name="name2" icon="logo-android">
        Android的内容
    </Tab-Pane>
    <Tab-Pane label="IOS" name="name3" icon="logo-apple">
        IOS的内容
    </Tab-Pane>
</Tabs>
```

图5



如果想要像传统的桌面应用那样的标签样式，可以把它的类型设定成卡片。

```html
<Tabs type="card">
    ...
</Tabs>
```

效果是这样：

图6



我比较喜欢卡片式的，就像看书时书中插入的书签一样，毕竟一目了然。

在此基础上，你可以给它加上一个叉叉用于关闭这个标签。

```html
<Tabs type="card" closable>
    ...
</Tabs>
```

图7



当有消息更新或内容变动时，标签上也可以附加徽标数来提醒用户。

通过绑定的标签页的 `label` 变量，然后再设置这个变量的 `Render` 函数就可以自定义标签页内容了。

```html
<Tabs value="name1">
	<TabPane :label="label1" name="name1">标签一的内容</TabPane>
	<TabPane label="标签二" name="name2">标签二的内容</TabPane>
	<TabPane label="标签三" name="name3">标签三的内容</TabPane>
</Tabs>

new Vue({
	el: '#app',
	data: {
		label: (h) => {
			return h('div', [
				h('span', '标签一'),
				h('Badge', {
					props: {
						count: 66
					}
				})
			])
		}
	},
})
```

图8



这个 `Render` 函数比较复杂，在 `View UI` 中有很多自定义场景会用到它，虽然对小白极不友善，但是不要怕，你怕它也没用，告诉你个秘诀，通常情况下你直接按代码套用即可。

另外带有徽标数这种自定义情况下，就不能再用卡片式的样式了，当然也不能带有关闭项了。

还有一些活学活用的方法，例如标签可右击弹出菜单，另外也可以拖动互换位置，这些个就属于较高阶的运用了，小白慎用哦。



#### 三、下拉菜单 - Dropdown

我们前面说了导航菜单，现在又来了个下拉菜单，它们是亲戚还是什么关系？

你还别说，它们之间有点类似，但可没什么必然联系。

要说都是菜单，但导航菜单一般用在整体范围，而下拉菜单就比较灵活了，你哪儿都可以用，属于局部范围。

我看这个下拉菜单应该就是我们通常意义上说的那个菜单了。

来，我们用用看就知道了。



基本用法：

```html
<Dropdown>
	<a href="javascript:void(0)">
		我是菜单，点我试试...
		<Icon type="ios-arrow-down"></Icon>
	</a>
	<Dropdown-Menu slot="list">
		<Dropdown-Item>石雕艺术</Dropdown-Item>
		<Dropdown-Item>砖雕艺术</Dropdown-Item>
		<Dropdown-Item disabled>沙雕艺术</Dropdown-Item>
		<Dropdown-Item>木雕艺术</Dropdown-Item>
		<Dropdown-Item divided>冰雕艺术</Dropdown-Item>
	</Dropdown-Menu>
</Dropdown>
```

图9



这里先解释一下，此处的菜单标题为啥要加 `<a href="javascript:void(0)"></a>` 这个链接呢？

其实原因没你想得那么复杂，它只是单纯让鼠标放在菜单上可以显示为手形，同时如果你点击它也不会跳转而刷新页面（等于啥都不做），就是个装饰，显得上档次嘛！



我们接着讲，打开菜单的触发方式有这么几种。

一个是鼠标悬停 `hover` ，这个是默认的，鼠标放上去菜单就自动打开了。

```html
<Dropdown trigger="hover">
	......
</Dropdown>
```



另一个是鼠标点击 `click` ，不点不开，点了才开。

```html
<Dropdown trigger="click">
	......
</Dropdown>
```



还有一个是鼠标右键点击 `contextMenu` 。

```html
<Dropdown trigger="contextMenu">
	......
</Dropdown>
```



最后一个就是自定义触发 `custom` ，这时就需要你设定一个变量来控制菜单的显示和隐藏了。

如下代码，当变量 `visible` 为 `true` 时，菜单就被打开啦，任由你控制哦！

```html
<Dropdown trigger="custom" :visible="visible">
	......
</Dropdown>

<script>
    new Vue({
        el: '#app',
        data: {
			visible: false
        },
    })
</script>
```



直接使用上面的代码，你会发现点击菜单没有任何反应。

哈哈，如果有反应才有鬼呢，实际上这时是需要用不同的变量值来控制菜单的打开关闭状态的。

作为演示，我在菜单旁边放了一个按钮，这个按钮控制着显示变量的真假值。

每次点击这个按钮，变量 `visible` 的值会真假循环切换。

```html
<i-button @click="visible=!visible">点我 [打开/关闭] 菜单</i-button>
```

好了，你会欣喜地发现菜单会随着这个按钮的点击而被打开或关闭，神奇不？

图10 gif



另外，菜单还可以嵌套实现级联效果，代码大概是这样子。

```html
<Dropdown>
	<a href="javascript:void(0)">
		我是菜单，快打开看看...
		<Icon type="ios-arrow-down"></Icon>
	</a>
	<Dropdown-Menu slot="list">
		<Dropdown-Item>石雕艺术</Dropdown-Item>
		......
        
		<Dropdown placement="right-start">
			<Dropdown-Item>
				沙雕艺术
				<Icon type="ios-arrow-forward"></Icon>
			</Dropdown-Item>
			<Dropdown-Menu slot="list">
				<Dropdown-Item>讲文明</Dropdown-Item>
				<Dropdown-Item>懂礼貌</Dropdown-Item>
                <Dropdown-Item>树新风</Dropdown-Item>
				<Dropdown-Item divided>做个好孩子</Dropdown-Item>
			</Dropdown-Menu>
		</Dropdown>
		
        ......
		<Dropdown-Item>木雕艺术</Dropdown-Item>
	</Dropdown-Menu>
</Dropdown>
```

图11



怎么样？有感觉了没？

以后不管是整体概念的导航菜单还是局部具体细节的下拉菜单，你多多少少可以算是运用自如了吧。

如果还有不懂，别着急，饭要一口一口吃，慢慢消化消化，熟能生巧嘛。



最后说几句闲话，小伙伴们在家刻苦学习固然重要，但老话说的好，身体是革命的本钱，休息日也要注意放松，保证身体健康，多出去走动走动。

今年（2020年）恰逢疫情原因，国内各地旅游业也受到了不同程度的冲击，我们要响应号召，大力支持走出去看看！

学习锻炼两不误，金秋时节恰逢中秋国庆，让我们共同走进5A旅游胜地，欣赏不同时期的人文艺术，小伙伴们还等啥，还不赶快准备准备，一同走起啊！



**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test06.7z：https://o8.cn/a539KZ    密码：xp55



> WeChat @网管小贾 | www.sysadm.cc



