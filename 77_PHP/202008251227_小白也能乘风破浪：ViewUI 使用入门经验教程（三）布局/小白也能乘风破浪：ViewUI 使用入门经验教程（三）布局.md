小白也能乘风破浪：ViewUI 使用入门经验教程（三）布局

副标题：布局



但凡提起西游记人物，小伙伴们脑海中第一个肯定会想到孙悟空。

孙悟空本领强、武艺精的伟岸形象深入人心，但你知道他为啥这么大本事吗？

某一日，菩提老祖为了想搞学员扩招，苦于宿舍扩建申请迟迟未获批准，于是当即下达最新指示，让那帮白吃白喝的老学员赶快毕业走人。

很快轮到让孙悟空选网课搞毕设了，是学三十六般天罡术，还是七十二般地煞术呢？

那时候猴子年少懵懂无知，不过高等数学基础不错，于是选了个多的，也就是七十二般地煞术。

实际上这两样网课无关数量多寡，让这帮学员毕业走人才是真的。

不过猴子不懂，还是埋头刻苦学习，却也学到了真本事。

这个故事告诉我们，作为小白的我们，如果你觉得没有猴子悟性高，那么就老老实实、一步一个脚印认真学习。

贪多嚼不烂，我们把基础学精才是正道。



话说回来，前文书我们简述了一个很重要的概念：栅格系统。

> [小白也能乘风破浪：ViewUI 使用入门经验教程（二）栅格](https://www.sysadm.cc/index.php/webxuexi/767-getting-started-with-viewui-1)

现在，我们在此基础知识之上再整点大的，来聊一聊布局的概念。

我们先来看一张图哈：

图1



这张图不复杂吧？

这正是一张简单的布局示意图，你应该能看出来，页面布局其实它就和一个完整的人一样，是有头、身体、手和脚的。

* 人就是布局容器 `Layout` ；
* 头就是页头 `Header` ；
* 身体就是内容 `Content` ；
* 手就是侧边栏 `Sider` ；
* 脚就是底部页脚 `Footer`  。



那么它们之间存在着什么样的关系呢？

从图中我们就可以看出，整个布局容器 `Layout` 包含着 `Header` 、 `Content` 、`Sider` 和 `Footer`  。

而 `Layout` 就像套娃一样，可以嵌套另一个 `Layout` 。



单说理论可能不太好理解，我们来看看实际一点的举例。

通常较经典的布局方式如下这个样子：

图2



这个样子看上去还是比较贴近实际的吧。

虽然似乎一下子复杂了起来，但别着急，我们慢慢分析看。

一般的布局中，页头一般可以放Logo、导航菜单等，侧边栏可以放导航项，底部页脚放一些版权信息等。

这类布局模式可以套用到很多界面上，是比较简便的万能方法。

即便是再复杂的布局，大体上也是这个套路。

不信你瞧，比如，后台系统界面。

图3



甚至是简单的登录框，当然只是它可以没有头部或侧边栏而已。

图4



好了，请注意，这里要说明一下的是，通常整体上这种 “上-中-下” 式的布局只是人为约定的模式，并不是实际意义上的某个WEB标准或HTML的标准。

你可以随意布局，并不一定要按照这类布局模式做，但是前人总结出来的经验还是可以让你少走弯路的，学习这种模式还是有好处的。



理论概念了解得差不多了，让我们来动手写写代码吧。

先来个最基本的，有头有尾有内容，还有侧边栏。

```html
<div class="layout">
    <Layout>
        <Header>我来组成头部</Header>
        <Layout>
            <Sider>组成手臂</Sider>
            <Content>组成躯干</Content>
        </Layout>
        <Footer>组成腿和脚</Footer>
    </Layout>
</div>
```

图5



纳尼？这是什么鬼？

怎么和想像的不一样啊喂！

就这样别说颜值了，简直是面目全非啊！

怎么回事呢？

其实前面已经有说过哦，这些个 `Layout` 啊、`Header` 或 `content` 啥的，只是个约定的标记，真正要把架子搭起来，还是得靠样式表单。

把官网的部分代码拿来修正一下做演示。

```html
<!-- 前面加上了点CSS样式，照抄就行了 -->
<style scoped>
.layout{
    border: 1px solid #d7dde4;
    background: #f5f7f9;
    position: relative;
    border-radius: 4px;
    overflow: hidden;
}
.layout-logo{
    width: 100px;
    height: 30px;
    background: #5b6270;
    border-radius: 3px;
    float: left;
    position: relative;
    top: 15px;
    left: 20px;
}
.layout-nav{
    width: 420px;
    margin: 0 auto;
    margin-right: 20px;
}
    .layout-footer-center{
    text-align: center;
}
</style>


<!-- 我是战神金刚 -->
<div class="layout">
	<Layout>
        
        <!-- 我来组成头部 -->
		<Header>
			<i-menu mode="horizontal" theme="dark" active-name="1">
				<div class="layout-logo"></div>
				<div class="layout-nav">
					<Menu-Item name="1">
						<Icon type="ios-navigate"></Icon>
						Item 1
					</Menu-Item>
					<Menu-Item name="2">
						<Icon type="ios-keypad"></Icon>
						Item 2
					</Menu-Item>
					<Menu-Item name="3">
						<Icon type="ios-analytics"></Icon>
						Item 3
					</Menu-Item>
					<Menu-Item name="4">
						<Icon type="ios-paper"></Icon>
						Item 4
					</Menu-Item>
				</div>
			</i-menu>
		</Header>
        
		<Layout>
            <!-- 组成手臂 -->
			<Sider hide-trigger :style="{background: '#fff'}">
				<i-menu active-name="1-2" theme="light" width="auto" :open-names="['1']">
					<Submenu name="1">
						<template slot="title">
							<Icon type="ios-navigate"></Icon>
							Item 1
						</template>
						<Menu-Item name="1-1">Option 1</Menu-Item>
						<Menu-Item name="1-2">Option 2</Menu-Item>
						<Menu-Item name="1-3">Option 3</Menu-Item>
					</Submenu>
					<Submenu name="2">
						<template slot="title">
							<Icon type="ios-keypad"></Icon>
							Item 2
						</template>
						<Menu-Item name="2-1">Option 1</Menu-Item>
						<Menu-Item name="2-2">Option 2</Menu-Item>
					</Submenu>
					<Submenu name="3">
						<template slot="title">
							<Icon type="ios-analytics"></Icon>
							Item 3
						</template>
						<Menu-Item name="3-1">Option 1</Menu-Item>
						<Menu-Item name="3-2">Option 2</Menu-Item>
					</Submenu>
				</i-menu>
			</Sider>
            
            <!-- 组成躯干 -->
			<Layout :style="{padding: '0 24px 24px'}">
				<Breadcrumb :style="{margin: '24px 0'}">
					<Breadcrumb-Item>Home</Breadcrumb-Item>
					<Breadcrumb-Item>Components</Breadcrumb-Item>
					<Breadcrumb-Item>Layout</Breadcrumb-Item>
				</Breadcrumb>
				<Content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">
					WeChat @网管小贾 | www.sysadm.cc
				</Content>
			</Layout>
		</Layout>
        
        <!-- 组成腿和脚 -->
        <Footer class="layout-footer-center">&copy; 2020 网管小贾 | 微信公众号 @网管小贾</Footer>
	</Layout>
</div>
```

图6



现在再看看，这模样有点儿那个意思了吧！

实际上就是在前面基本布局的基础上加上了一些样式和基本组件。

理清布局容器组件之间的关系，你就可以随心所欲地布局整个页面了。

而代码中所涉及到的诸如导航菜单等其他的组件，我们会在以后的文章中陆续介绍。

好了，布局就是这么一回事。



不过嘛，小伙伴们看到现在，这栅格和布局两位兄弟感觉好像差不多意思哈，都是为了让一张小鲜肉脸上的精致五官摆放得错落有致。

那他们总有不同之处吧，这个区别又是啥呢？

其实上文书末尾已经简述过，简单地讲就是，**栅格可以用于局部也可以用于整体，而布局则是个整体概念。**

看这张图，你就容易理解了。

图7





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



