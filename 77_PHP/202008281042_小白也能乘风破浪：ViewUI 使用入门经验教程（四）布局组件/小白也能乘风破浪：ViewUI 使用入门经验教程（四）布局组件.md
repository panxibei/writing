小白也能乘风破浪：ViewUI 使用入门经验教程（四）布局组件

副标题：布局组件



但凡提起西游记人物，小伙伴们脑海中第一个肯定会想到孙悟空。

孙悟空本领强、武艺精，齐天大圣伟岸形象深入人心，但你知道他为啥这么大本事吗？



某一日，菩提老祖为了搞学员扩招，但眼前苦于宿舍扩建申请报告迟迟未获批准，于是当即在洞内下达最新指示，让那帮白吃白喝的老学员赶快结业走人。

很快轮到让孙悟空选网课搞毕设了，是学三十六般天罡术，还是七十二般地煞术呢？

那时候猴子年少懵懂无知，不过高等数学基础不错，选了个多的，也就是七十二般地煞术。

实际上这两样网课无关数量多寡，让这帮学员毕业走人才是真的。

不过猴子不懂得老祖的算计，只知埋头刻苦学习，却也学到了真本事。



这个故事告诉我们，作为小白，如果你觉得没有猴子悟性高，那么就老老实实、一步一个脚印地认真学习。

虽说技多不压身，但小白往往贪多嚼不烂，我们还是把基础学精才是正道。

上回我们介绍了布局，那么这一次我们就介绍几个基本的布局组件。



## 第四弹：布局组件



#### 一、列表 - List

列表可用于展示数行简短的图像或文字内容，通常需要与后台交互显示。

基本用法如下：

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

图1



我们来个复杂点的：

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

图2



这个列表演示虽然复杂一些，但框架还是建立在前面那个基本演示代码上的。

除此之外，就是在基本框架之上增加了头像、图标以及导航图片等等。

利用 `v-for` 可遍历显示指定的标题和内容等数据。

是不是有一些和博客列表内容显示相似之处，当然你可以用这个列表来做各种各样的列表显示了。



#### 二、卡片 - Card

卡片用来显示文字、图文等内容，一般作为和其他组件配合展示之用。



一般用法：

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

图3



这个样子的卡片，除了列表组件外，还挺适合用于导航页面的链接汇总。

具体的标题、链接以及其他一些附加信息都可以通过读取后台数据显示出来，同时这也大大方便了后台的统一维护。



#### 三、折叠面板 - Collapse

将部分内容区域折叠或展开，可以节省空间，适合简短的说明内容隐藏或显示。

一般用法：



























栅格可以在任意区域放置内容组件（菜单、按钮等），而布局就是用来划分不同区域的。

OK，看样子大家都了解得差不多了，收获不小吧？

至于布局的其它使用细节，如固定头部、侧边收起等等功能，可以视具体实际使用情况参考官网内容。

好了，我们有了布局模式的概念，那么就可以按照自己的想法来摆放具体的UI组件了。

接下来我们将要具体介绍各种不同的UI组件，来具体实现界面效果。

敬请期待下一回吧！



**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test02.7z：https://o8.cn/AzESBn    密码：0b93



> WeChat @网管小贾 | www.sysadm.cc



