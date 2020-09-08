小白也能乘风破浪：ViewUI 使用入门经验教程（五）布局组件二

副标题：布局组件二



但凡





## 第五弹：布局组件二



#### 四、面板分割 - Split

顾名思义，面板分割可以做到把一个大区域分成若干个小区域。

而且，这个被分割的面板之间还可以调整区域之间的宽度或高度。



基本用法不难，一个是CSS模式，一个是用 `Split` 代码标签。

```css
<style>
	<!-- 整体边框 -->
	.demo-split{
		height: 200px;
		border: 1px solid #dcdee2;
	}
	<!-- 中间分隔栏 -->
	.demo-split-pane{
		padding: 10px;
	}
</style>
```



左右结构，注意CSS样式：

```html
<div class="demo-split">
	<Split v-model="split1">
		<div slot="left" class="demo-split-pane">
			......
		</div>
		<div slot="right" class="demo-split-pane">
			......
		</div>
	</Split>
</div>
```



上下结构，多了个 `mode="vertical"` ：

```html
<div class="demo-split" mode="vertical">
	<Split v-model="split1">
		<div slot="top" class="demo-split-pane">
			......
		</div>
		<div slot="bottom" class="demo-split-pane">
			......
		</div>
	</Split>
</div>
```



没啥大花样，效果图如下：

图1



这种质朴的画面让我感觉面板分割可能会用到一些特殊场合。

至于什么特殊场合，很抱歉，作为小白的我，至今还没有用它派上大用场。

也许你比我更聪明呢，说不定会有用它的时候哦！



#### 五、分割线 - Divider

分割线可以用来分割不同的文字或图文内容。

而同样是分割，面板分割似乎太过强调区域概念，而使得它过分拘谨，95%以上使用的人会不自觉地选择比它更自由的分割线。

很巧，我就是那95%以内的人，我情愿用线来分割内容，而不会把内容圈得太死。

最早先，一部分人喜欢用多个减号 `-` ，或者用类似于减号的符号（如波浪号 `~` 等）来分割文本段落，这通常是由于早期的编辑器制定的古板规则使然。

分割内容是人类无法回避的一大问题，你也可以把它归为哲学问题。

如果我使用过 `vi` 或 `vim` ，那么会有很不同反响的感受，“反人类”会被作为使用过后最大的反映。

但传统的编辑器规则才是最大的反人类，原因很简单，因为你必须要用两只手同时做到使用键盘和鼠标。

以上个人观点，随便你们喷，记得带好口罩。

话再说回来，传统的 `html` 标签已经为大家提供了一个简单的分割标签 `hr` 。

什么？HR？

别想歪了，这个 `hr` 是 `水平分隔线（horizontal rule）` 的意思！

我一般就用 `<hr` 这样分隔我想分隔的内容。

当我看到 `Divider` 时，我发现我太LOW了，我决定改弦更张。



它的用法更高档一些。

```html
<!-- 单纯的一条分隔线，和hr类似 -->
<Divider></Divider>

<!-- 分隔线带文本 -->
<Divider>With Text</Divider>

<!-- 分隔线秒变虚线 -->
<Divider dashed></Divider>
```

效果是这个样子的：

图2



分割线是水平横线，还可以变成垂直的，加个 `type="vertical"` 就行了。

```html
<Divider type="vertical"></Divider>
```

效果如下：

图3



带文本的分隔线，这个文本可以在左，也可以在右。

```html
<Divider orientation="left">文字在左</Divider>
<Divider orientation="right">文字在右</Divider>
```

效果如下：

图4



这个分隔线很简单吧，就算是美工很烂的我在很多场合也会经常用到它，是比较理想的分隔利器。

小伙伴们可以多用用看哦！





#### 六、单元格 - Cell

说实话，这个单元格对我而言有些复杂了。

官方说明是用于固定的菜单列表，可我好像并没有怎么用到它。

先来看看大概的样子，兴许你能用到它呢。



单元格每一项通常被单元格组（CellGroup）包裹起来。

而每一项就是一行由 `<Cell></Cell>` 包裹的单元格项。

演示代码如下：

```html
<Cell-Group>
	<Cell title="1. 可以只显示个标题"></Cell>
	<Cell title="2. 也可以显示标签内容" label="这里是标签内容，叭啦叭啦......"></Cell>
	<Cell title="3. 也可以显示右侧详细内容" extra="这里是详细内容"></Cell>
	<Cell title="4. 可以是链接" extra="这里是详细内容" to="https://www.sysadm.cc"></Cell>
	<Cell title="5. 也可以点击这里打开新窗口" to="https://www.sysadm.cc" target="_blank"></Cell>
	<Cell title="6. 哇哦，被禁用了" disabled></Cell>
	<Cell title="7.惊喜，被选中了" selected></Cell>
	<Cell title="8. 有徽标数" to="/components/badge">
		<Badge :count="66" slot="extra" />
	</Cell>
	<Cell title="9. 还有开关">
		<i-Switch v-model="switchValue" slot="extra"></i-Switch>
	</Cell>
</Cell-Group>
```

每行单元格项，可以仅仅显示为一个标题，也可以显示为标签、链接、状态甚至是徽标或开关等其他组件。

具体请参考上面的代码，这里有9行单元格项演示，效果大概是这个样子的：

图5



如果你点击链接之类的单元格项，那么就会跳转到你指定的 `To` 后面的链接。

不过在跳转之前，它默认会触发 `on-click` 点击事件。

当然了，没有链接的单元格项，你点击它也是会触发这个事件的，事件返回值是你点击项的 `name` 。

给个示例，传递单元格名称参数到函数中：

```html
<Cell-Group @on-click="name=>onclick(name)">
	<Cell name="我是老大"></Cell>
	<Cell name="我是老二"></Cell>
	<Cell name="我是老三"></Cell>
    ......
    <Cell name="我是谁，我在哪？"></Cell>
</Cell-Group>
```

另外，在 `methods` 方法中可以这样写：

```js
onclick (cell_name) {
    alert(cell_name);
}
```

效果大概是这样子：

图6 gif



这样你就可以随心所欲地点击单元格，然后根据它们不同的名称 `name` 来区分并触发你想做的动作啦！

具体完整的代码，请到文未免费下载参考吧。





















这一弹给小伙伴们介绍了三个布局组件：列表、卡片和折叠面板。

虽然内容不多，但它们各有各的特点，务必要熟练掌握，在实际运用中才可以发挥想像充分利用好它们的特点。

下一弹我们会继续介绍其他的布局组件。

好了，准备下课啦！





**本文相关文件下载：**

vue.min.js.7z：https://o8.cn/4JnupS    密码：zyc8

ViewUI-4.3.2.zip：https://o8.cn/ilEeNU    密码：88pi

test04.7z：https://o8.cn/AzESBn    密码：0b93



> WeChat @网管小贾 | www.sysadm.cc


