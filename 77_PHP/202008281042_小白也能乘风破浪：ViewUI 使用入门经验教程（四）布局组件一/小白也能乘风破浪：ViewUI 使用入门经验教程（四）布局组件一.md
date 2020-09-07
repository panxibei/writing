小白也能乘风破浪：ViewUI 使用入门经验教程（四）布局组件一

副标题：布局组件



但凡提起西游记中的人物，小伙伴们脑海中第一个肯定会想到孙悟空。

孙悟空本领强、武艺精，齐天大圣伟岸形象深入人心，但你知道他为啥这么大本事吗？



某一日，菩提老祖为了搞学员扩招，但眼前苦于宿舍扩建的申请报告迟迟未获批准，于是当即在洞内下达最新指示，让那帮白吃白喝的老学员赶快结业走人。

很快轮到让孙悟空选网课搞毕设了，是学三十六般天罡术，还是七十二般地煞术呢？

那时候猴子年少懵懂无知，不过高等数学基础不错，选了个多的，也就是七十二般地煞术。

实际上这两样网课无关数量多寡，学得精都可成才，眼前让这帮学员毕业走人才是真的。

不过猴子不懂得老祖的算计，只知埋头刻苦学习，靠着一股钻劲儿，却也学到了真本事。



这个故事告诉我们，作为小白，如果你觉得没有猴子悟性高，那么就老老实实、一步一个脚印地认真学习。

何况猴子也是通过不断刻苦练习才有了现在的本事。

虽说技多不压身，但之所以是个小白往往因贪多嚼不烂，我们还是把基础学精才是正道。

上回我们介绍了布局，那么这一次我们就介绍几个基本的布局组件。



## 第四弹：布局组件一



#### 一、列表 - List

列表可用于展示数行简短的图像或文字内容，通常需要与后台交互显示。

基本用法如下：

```html
<List header="卡片标题" footer="卡片页脚" border>
	<List-Item>列表内容一</List-Item>
	<List-Item>列表内容二</List-Item>
	<List-Item>列表内容三</List-Item>
</List>
```



我们可以在此基础上稍加装饰，比如加个超链接啥的：

```html
<div>
  <strong>列表演示 - 基本</strong>
  <List header="卡片标题" footer="卡片页脚" border>
    <List-Item>微信公众号： @网管小贾</List-Item>
    <List-Item>网管小贾的博客：www.sysadm.cc</List-Item>
    <List-Item><a href="https://www.sysadm.cc/index.php/webxuexi/767-getting-started-with-viewui-1">ViewUI 使用入门经验教程</a></List-Item>
  </List>
</div>
```

效果如下：

图1



以上是固定打法，也就是有几条内容就傻傻地写几条。

但在实际运用中，还是需要动态显示列表内容。

比如我们常见的博客，不可能把所有的文章内容都显示出来，自然是给读者提供摘要简介列表，然后让读者浏览选择后再阅读具体的内容。

而实际上你可能每天都在更新你的博客，所以博客摘要列表也需要实时更新，但你懂的，不可能每次都手动维护摘要列表，否则想想都恐怖不是吗？

于是我们应该像下面这个例子一样：

```html
<div>
	<strong>列表演示 - 高级</strong>
	<br><br>
	<List item-layout="vertical" border>
		<List-Item v-for="item in data_list" :key="item.title">
			<List-Item-Meta :avatar="item.avatar" :title="item.title" :description="item.description"></List-Item-Meta>
			{{ item.content }}
			<template slot="action">
				<li>
					<Icon type="ios-star-outline"></Icon> 123
				</li>
				<li>
					<Icon type="ios-thumbs-up-outline"></Icon> 666
				</li>
				<li>
					<Icon type="ios-chatbubbles-outline"></Icon> 888
				</li>
			</template>
			<template slot="extra">
				<img src="./sysadm.cc.jpg" style="width: 280px">
			</template>
		</List-Item>
	</List>
</div>

<script>
new Vue({
	el: '#app',
	data: {
		data_list: [
			{
				title: '标题 1',
				description: '这里有详细描述 1',
				avatar: 'avatar.gif',
				content: '内容1：内容写在这里，内容写在这里，内容写在这里，内容写在这里......'
			},
			{
				title: '标题 2',
				description: '这里有详细描述 2',
				avatar: 'avatar.gif',
				content: '内容2：内容写在这里，内容写在这里，内容写在这里，内容写在这里......'
			},
			{
				title: '标题 3',
				description: '这里有详细描述 3',
				avatar: 'avatar.gif',
				content: '内容3：内容写在这里，内容写在这里，内容写在这里，内容写在这里......'
			}
		]
	},
})
</script>
```

效果如下：

图2



这个列表演示虽然变得复杂一些，但框架还是建立在前面那个基本演示代码上的，只是标题内容啥的都是通过后台读取的。

首先后台提取文章的标题及部分内容作为摘要，然后返回摘要到前台的相关变量，最后利用 `v-for` 即可遍历变量后显示为文章摘要列表。

除标题内容之外，就是在基本框架之上增加了头像、图标以及导航图片等等。

你瞧，就这个例子来看，是不是和博客摘要列表非常相似呢？

当然你可以在这个基础上，用这个例子来做出各种各样效果更丰富的列表显示。



#### 二、卡片 - Card

卡片小伙伴们都应该见过吧。

有时候走在一些偏僻的小路上，迎面会走来一个看似像和尚或尼姑的人，不由分说地塞给你一张小卡片。

看你犹豫，又快速地递上另一张卡片，然后你只好喊道：“上帝保佑！不好意思，我已经还俗了！”

有点走偏了哈，其实这个卡片虽小，但承载的信息量却不小。

通常卡片用来显示简短的文字、图文等内容，在页面设计中一般作为和其他组件配合展示之用。



基本的框架像这个样子：

```html
<Card>
	<p slot="title">
		标题
	</p>
	<p>
		内容一
	</p>
	<p>
		内容二
	</p>
    <p>
		内容三
	</p>
</Card>
```



在此基础上，我们整个复杂一些的用法：

```html
<Card style="width:650px">
	<p slot="title">
		<Icon type="ios-laptop"></Icon>
		ViewUI 使用入门经验教程
		<span style="float:right">
			<a href="https://www.sysadm.cc" slot="extra">
				<Icon type="ios-person"></Icon>
				@网管小贾
			</a>
		</span>
	</p>
	<p v-for="item in data_card">
		<a :href="item.url" target="_blank"><Icon type="ios-link"></Icon>&nbsp;&nbsp;{{ item.name }}</a>
		<span style="float:right">
			阅读进度: {{ item.rate }}%
		</span>
	</p>
</Card>

<script>
    new Vue({
        el: '#app',
        data: {
			data_card: [
				{
					name: '小白也能乘风破浪：ViewUI 使用入门经验教程（一）开篇',
					url: 'https://www.sysadm.cc/index.php/webxuexi/767-getting-started-with-viewui-1',
					rate: 9.6
				},
				{
					name: '小白也能乘风破浪：ViewUI 使用入门经验教程（二）栅格',
					url: 'https://www.sysadm.cc/index.php/webxuexi/768-getting-started-with-viewui-2',
					rate: 9.4
				},
				{
					name: '小白也能乘风破浪：ViewUI 使用入门经验教程（三）布局',
					url: 'https://www.sysadm.cc/index.php/webxuexi/769-getting-started-with-viewui-3',
					rate: 9.5
				},
				{
					name: '小白也能乘风破浪：ViewUI 使用入门经验教程（四）布局组件',
					url: 'https://www.sysadm.cc/index.php/webxuexi/770-getting-started-with-viewui-4',
					rate: 9.4
				},
			],
		},
    })
</script>
```

效果如下：

图3



这个样子的卡片，除了前面说到的列表组件外，还是挺适合用于导航页面的链接汇总的。

具体的标题、链接以及其他一些附加信息都可以通过读取后台数据显示出来，同时这也大大方便了后台的统一维护。

换个思维，博客的摘要列表是不是也可以别出心裁做成小卡片这样的呢？

就看你的艺术细胞了！



#### 三、折叠面板 - Collapse

有时候想给展示的内容加点说明，但说明的内容较长，同时又不想让它占用太多的空间。

在实际页面布局中，经常会发生这样的事情，怎么办呢？

让折叠面板来拯救你！

它将部分内容区域折叠或展开，可以大大节省空间，非常适合简短或附加内容的隐藏或显示。



它通常长这个样子：

```html
<Collapse>
	<Panel name="1">
		标题一
		<p slot="content">内容一</p>
	</Panel>
	<Panel name="2">
		标题二
		<p slot="content">内容二</p>
	</Panel>
	<Panel name="3">
		标题三
		<p slot="content">内容三</p>
	</Panel>
</Collapse>
```



我们把它具体一点儿看看：

```html
<Collapse>
	<Panel name="1">
		小白也能乘风破浪：ViewUI 使用入门经验教程（一）开篇
		<p slot="content">我虽然是一个小白，但我也是有梦想的。<br>
            我无时不刻地梦想着哪天能熟练驾驭WEB前端开发的一切，跻身开发牛人行列。 </p>
	</Panel>
	<Panel name="2">
		小白也能乘风破浪：ViewUI 使用入门经验教程（二）栅格
		<p slot="content">俗话说，人要脸，树要皮。<br>
        古往今来从未像现如今这样全民热衷于看脸，没点颜值差点姿色你都不好意思直播带货。</p>
	</Panel>
	<Panel name="3">
		小白也能乘风破浪：ViewUI 使用入门经验教程（三）布局
		<p slot="content">《战神金刚》是上个世纪众多经典动画片之一，80后90后的小伙伴们应该都有印象吧。<br>
            虽然童年时光已逝，经典似乎离我们越来越遥远，但是那句经典台词我想一定有小伙伴仍能脱口而出：“组成脚和腿，组成躯干和手臂， 我来组成头部！”。 </p>
	</Panel>
</Collapse>
```

效果如下：

图4



有个简洁模式，只要加个 `simple` 即可，超级简单啊！

```html
<Collapse simple>
    ...
</Collapse>
```

效果如下：

图5



另外，可以通过变量指定当前需要展开的面板，只要给这个变量赋予面板的名称即可。

注意是面板的名称（name），如果面板未指定具体的名称，则按索引值来确定。

```html
<Collapse v-model="value1">
    <Panel name="1">
    	...
    </Panel>
    <Panel name="2">
        ...
    </Panel>
</Collapse>    

<script>
    new Vue({
        el: '#app',
        data: {
            value1: '1'
		},
    })
</script>
```



像一些诸如查询条件区域、评论区域或计算公式演示说明等等，都可以有折叠面板的用武之地。

简简单单地点开查看，不需要时再隐藏，只要充分发挥你的设计想像力，折叠面板应用场景还是很丰富的。



这一弹给小伙伴们介绍了三个布局组件：列表、卡片和折叠面板。

虽然内容不多，但它们各有各的特点，务必要熟练掌握，在实际运用中才可以发挥想像充分利用好它们的特点。

下一弹我们会继续介绍其他的布局组件。

好了，准备下课啦！





**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test04.7z：https://o8.cn/AzESBn    密码：0b93



> WeChat @网管小贾 | www.sysadm.cc


