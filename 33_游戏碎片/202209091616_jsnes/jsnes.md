jsnes

副标题：

英文：

关键字：





`bfirsh` 项目地址：

```
https://github.com/bfirsh/jsnes
```



大神官网：

```
https://jsnes.org/
```

图b01

图b02

图b03

图b04









`nes-embed.html` 中有以下代码。

```js
<script>window.onload = function(){nes_load_url("nes-canvas", "InterglacticTransmissing.nes");}</script>
```

这行代码意思为在页面加载完成后再加载 `nes` 游戏到 `canvas` 。

可是代码似乎还是有缺陷，涉及到 `AJAX` 的异步提交，在使用 `window.onload` 时总是会失败。





按键



设定按键的代码如下：

```
function keyboard(callback, event){
	var player = 1;
	switch(event.keyCode){
		case 38: // UP
			callback(player, jsnes.Controller.BUTTON_UP); break;
		case 40: // Down
			callback(player, jsnes.Controller.BUTTON_DOWN); break;
		case 37: // Left
			callback(player, jsnes.Controller.BUTTON_LEFT); break;
		case 39: // Right
			callback(player, jsnes.Controller.BUTTON_RIGHT); break;
		case 65: // 'a' - qwerty, dvorak
		case 81: // 'q' - azerty
			callback(player, jsnes.Controller.BUTTON_A); break;
		case 83: // 's' - qwerty, azerty
		case 79: // 'o' - dvorak
			callback(player, jsnes.Controller.BUTTON_B); break;
		case 9: // Tab
			callback(player, jsnes.Controller.BUTTON_SELECT); break;
		case 13: // Return
			callback(player, jsnes.Controller.BUTTON_START); break;
		default: break;
	}
}
```

图a01



`case` 后面用于判断按键的数字是该按键的 `ASCII` 码，可以到官方查询。

```
https://www.ascii-code.com/
```

比如我们想将 `上` 、 `下` 、 `左` 、 `右` 设定为 `W` 、 `S` 、 `A` 、 `D` ，那么我们先找到这几个按键的 `ASCII` 码，分别是十进制的 `87` 、 `83` 、 `65` 、 `68` ，然后将它们写到代码中就可以了。



比如修正后的按键 `上` ，应该是这样写。

```
case 87: // UP
	callback(player, jsnes.Controller.BUTTON_UP); break;
```



类似的 `A` 和 `B` 按钮也是一样操作，找相应 `ASCII` 码并修改为你喜欢的按钮。





```
<iframe src="https://127.0.0.1/Joomla/wgxj/jsnes-bfirsh/nes-embed.html" width="720px" height="640px" frameborder="0" scrolling="no"> </iframe>
```





将它嵌入页面中。

```
<iframe src="https://127.0.0.1/Joomla/wgxj/jsnes/src/index.html" width="720px" height="820px" frameborder="0" scrolling="no"> </iframe>
```





`dafeiyu`

```
https://gitee.com/feiyu22/jsnes
```







**将技术融入生活，打造有趣之故事。**

网管小贾 / sysadm.cc

