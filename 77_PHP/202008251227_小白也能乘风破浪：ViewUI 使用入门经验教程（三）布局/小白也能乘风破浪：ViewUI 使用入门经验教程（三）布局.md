小白也能乘风破浪：ViewUI 使用入门经验教程（三）布局

副标题：布局



《战神金刚》是上个世纪众多经典动画片之一，80后90后的小伙伴们应该都有印象吧。

虽然童年时光已逝，经典似乎离我们越来越遥远，但是那句经典台词我想一定有小伙伴仍能脱口而出：“组成脚和腿，组成躯干和手臂， 我来组成头部！”。

图1



激动不？我们再来一张图。

图2



呃，这个......什么鬼......？

嗯，这个是传说中的布局示意图啊！

喂，美好回忆被你打断，突然整这个，几个意思？

先别激动，擦干泪水你仔细瞧瞧，这两者之间可有一点儿相似之处？

我怎么就......哎？

没错啦，战神金刚正是由多架战机合体的机器人！

对比战神金刚合体机器人，你应该能看出来，这个页面布局其实它就和一个人是一样一样的，有头、身体、手和脚。



## 第三弹：布局

页面布局也有手和脚，对比大活人的各个部件：

* 人就是布局容器 `Layout` ；
* 头就是页头 `Header` ；
* 身体就是内容 `Content` ；
* 手就是侧边栏 `Sider` ；
* 脚就是底部页脚 `Footer`  。



那么这些个头啊手和脚，它们之间存在着什么样的关系呢？

从图中我们就可以看出，整个布局容器 `Layout` 包含着 `Header` 、 `Content` 、`Sider` 和 `Footer`  。

而 `Layout` 就像套娃一样，可以嵌套另一个 `Layout` 。



单说理论可能不太好理解，我们来看看实际一点的例子。

通常较为经典的布局方式大概如下这个样子：

图3



这个样子看上去还是比较贴近实际的吧。

虽然似乎一下子复杂了起来，但别着急，我们慢慢分析，看看里面的门道。



一般的布局中，页头一般可以放Logo、导航菜单等，侧边栏可以放导航项，底部页脚放一些版权信息等。

这类布局模式可以套用到很多界面上，是比较简便的万能方法。

即便是再复杂的布局，大体上也都是这个套路。

不信你瞧，比如，后台系统界面。

图4



甚至是超级简单的登录框，当然只是它可以没有头部或侧边栏而已。

图5



好了，请注意，这里要说明一下的是，通常整体上这种 “上-中-下” 式的布局只是人为约定的模式，并不是实际意义上的某个WEB标准或HTML的标准。

你完全可以按你想像，随意毕加索式地布局，并不一定要按照这类布局模式做，但是前人总结出来的经验还是可以让你少走弯路的，对于小白来说学习这种模式还是有好处的。



好了，理论概念了解得差不多了，让我们来动手写写代码吧。

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

图6



纳尼？这又是什么鬼？

怎么和想像的不一样啊喂！

就这样儿别说颜值了，简直是面目全非啊！

怎么回事呢？

其实前面已经有说过哦，这些个 `Layout` 啊、`Header` 或 `content` 啥的，只是个约定的标记，真正要把架子搭起来还要开美颜，还是得靠样式表单。

把官网的部分代码拿来改吧改吧做演示。

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
        
        <!-- 组成脚和腿 -->
        <Footer class="layout-footer-center">&copy; 2020 网管小贾 | 微信公众号 @网管小贾</Footer>
	</Layout>
</div>
```

图7



现在再看看，这模样有点儿那个意思了吧！

实际上就是在前面基本布局框架的基础上加上了一些样式和基本组件。

理清布局容器组件之间的关系，你就可以随心所欲地布局整个页面了。

而代码中所涉及到的诸如导航菜单等其他的组件，我们会在以后的文章中陆续介绍。

好了，布局就是这么一回事儿。



不过嘛，小伙伴们看到现在，这栅格和布局两位兄弟感觉好像差不多意思哈，都是为了让一张小鲜肉脸上的精致五官摆放得错落有致。

那他们总有不同之处吧，这个区别又是啥呢？

其实上文书末尾已经简述过，简单地讲就是，**栅格可以用于局部也可以用于整体，而布局则是个整体概念。**

看这张图，你就容易理解了。

图8



栅格可以在任意区域放置内容组件（菜单、按钮等），而布局就是用来划分不同区域的。



OK，看样子大家都了解得差不多了，收获不小吧？

至于布局的其它使用细节，如固定头部、侧边收起等等功能，可以视具体实际使用情况参考官网内容。

好了，我们有了布局模式的概念，那么就可以按照自己的想法来摆放具体的UI组件了。

接下来我们将要具体介绍各种不同的UI组件，来具体实现界面效果。

敬请期待下一弹！



**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test03.7z：https://o8.cn/AzESBn    密码：0b93



> 前文阅读参考：
>
> [小白也能乘风破浪：ViewUI 使用入门经验教程（一）开篇](https://www.sysadm.cc/index.php/webxuexi/767-getting-started-with-viewui-1)
>
> [小白也能乘风破浪：ViewUI 使用入门经验教程（二）栅格](https://www.sysadm.cc/index.php/webxuexi/768-getting-started-with-viewui-2)



> WeChat @网管小贾 | www.sysadm.cc


