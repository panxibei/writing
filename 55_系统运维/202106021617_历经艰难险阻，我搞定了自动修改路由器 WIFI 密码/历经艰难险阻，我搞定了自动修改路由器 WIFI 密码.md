历经艰难险阻，我搞定了自动修改路由器 WIFI 密码

副标题：宝宝再也不怕被蹭网了~

英文：after-a-lot-of-difficulties-i-resolved-issue-to-change-wifi-password-of-router-automatically

关键字：tplink,wifi,router,路由器,密码



请告诉我，你们有没有经常被蹭网的经历？

简单地说，就是路由器 WIFI 密码很容易被别人知道，然后就悲剧了。

这种情况下，通常我们能做的也就是重新修改密码。

然而过了一段时间，悲剧又戏剧性地再次上演。



老是这样可不行啊！

于是我就开始动脑筋了，思考着有没有一个好一点的办法，让路由器能定时修改密码。

最初我想到的是，通过 `Telnet` 连接到路由器，然后通过 `Cli` 命令修改密码。

可是，大多数情况下是家用路由器啊，那玩意根本就不支持 `Telnet` 连接啊！

此路不通！



两千年之后，我突发奇想、灵光乍现，想到了通过模拟鼠标点击来操纵路由器管理页面的方法。

这种想法有点疯狂！

带着肚子那么一点点可怜的 `JS` 知识，我决定折腾一把看看。

我没有其他办法了不是吗，上吧！

于是我找来一台旧版管理页面的 `Tp-link` 路由器（型号 TL-WR880N），就它了！



### 组织代码，编写程序

首先，我们要搞定自动登录。

使用火狐打开路由器管理页面，按下 `F12` ，点击 `查看器` 一项，再点下左边的那个小箭头，然后将鼠标定位到密码输入框处。

OK，顺利找到了密码框的 `id` ，为 `pcPassword` 。

相应的代码如下（假定密码是 `123456` ），那么就可以自动填充密码。

```
document.getElementById('pcPassword').value = '123456';
```

图1



有了密码，我们需要点击确定才能正常登录。

用相同的方法，找到确定按钮的 `id` ，为 `loginBtn` 。

同样用代码来模拟点击。

```
document.getElementById('loginBtn').click();
```

图2



可以先测试一下，切换到 `控制台` 标签页，然后输入前面那两行代码。

然后回车，即可登录进入管理页面。

图3



这个过程中没有真正用鼠标去点击，是不是很神奇？

这里需要说明一点，通常页面登录验证是加密的，所以想通过提交链接的方法来实现登录有些困难。

好，登录进来之后，我们就要找一找在哪里可以修改密码。



需要事先说明的是，通常 `Tp-link` 旧款管理页面使用的是框架结构，就是传说中的 `frameset` 标签元素，所以实际上它的左侧菜单和右侧内容是分别属于不同的框架区域的。

类似于如下这个样子。

```
<frameset>
  <frameset>
  	<frame>顶部</frame>
  </frameset>
  <frameset>
  	<frame name="bottomLeftFrame">左侧菜单</frame>
  </frameset>
  <frameset>
  	<frame name="mainFrame">右侧内容</frame>
  </frameset>
</frameset>
```



所以左右两侧的代码有些不一样，左边名字叫 `bottomLeftFrame` ，而右侧名字叫 `mainFrame` 。

图4







找到 `无线安全设置` 菜单项，它的 `id` 为 `a9` 。

图5



如要点击它，代码应该是这个样子。

```
parent.frames.bottomLeftFrame.document.getElementById('a9').click();
```

图6



OK，我们来到了 WIFI 密码设置页面。

接下自然就是想办法修改这里的密码了。

如法炮制，获取到密码框的 `id` 为 `pskSecret` 。

图7



给它重新赋值就很简单了，用如下代码。

```
parent.frames.mainFrame.document.getElementById('pskSecret').value = '66666666';
```

注意此处是主框架 `mainFrame` ，并且密码要求 8 位以上。

图08



密码改好了，我们要保存才能生效，找一找保存按钮吧。

最下面有保存按钮，`id` 也找到了，是 `Save` 。

```
parent.frames.mainFrame.document.getElementById('Save').click();
```

图09



看到这儿是不是感觉还挺简单的？

其实后面还有很多坑呢。

坑之一，在保存代码执行后，你会发现它会提示你重启路由器密码才能生效。

图10



我用手机连接过，的确只有重启后才有用。

所以接下来还得研究一下如何让它重启。

活还没干完，继续上路！



系统中有重启路由器的菜单项，找到它确认 `id` 为 `a44` 。

那么点击它的代码就是如下了，别忘记它是左侧菜单项的哦。

```
parent.frames.bottomLeftFrame.document.getElementById('a44').click();
```

图11



再找到 `重启路由器` 按钮的 `id` 为 `reboot` 。

```
parent.frames.mainFrame.document.getElementById('reboot').click();
```

图12



在这儿看似坑一被填上了，可惜别高兴得太早。

虽然我们可以点击重启按钮了，可是它居然弹出个确认提示框来。

图13



我勒个去啊！

这个确定要怎么才能点击上呢？

查了大半天的资料，有网友说可以这么搞，说是可以覆盖原 `windows.alert` 方法，这样它就不弹出来了。

类似于以下几种都可以，通过覆盖并返回 `false` 来规避。

```
@grant        unsafeWindow

unsafeWindow.alert = function(){return false};
window.alert = function(){return false};
Window.prototype.alert = function(){return false};
```



可惜这种方法是无效的，原因很简单，有两个。

一个是 `alert` 是阻塞式的，也就是说当弹出窗口时，后面的代码就中断了，根本就不执行，又如何把它关闭呢。

二个是无法覆盖，反正我没成功过，但再转念一想，即使覆盖成功了，也无法达到目的。

因为它是要确认 `true` 或 `false` 的，如果覆盖了，之后代码又如何走呢？

基于以上原因，我决定换个思路。

比如说，看我能不能修改原代码，使其确认自动返回 `true` 不就行了！

你还别说，真让我给找着了！



我将重启路由器的页面保存下来，顺藤摸瓜找到了提交表单的元素项，找到了其中有一个叫作 `onsubmit` 的标签。

```
onsubmit="return doSubmit();"
```

很显示，这玩意应该就是提交重启时的函数代码。

然后我接着找，找这个叫作 `doSubmit()` 的函数。

果然在不远的地方有它的身影。

代码整理如下：

```
function doSubmit(){
  if(confirm("确认重新启动路由器？")){
    return true;
  } else {
    return false;
  }
}
```



图14



找到这儿就已经很清楚了，这个 `doSubmit()` 就是按确认提示返回 `true` 或 `false` 来进行判断是否重启。

那么这下就简单了，只要我主动返回给 `onsubmit` 这一元素 `true`  值就行了呗。

那么代码应该怎么写呢？

我来来回回找了半天，也没找着 `form` 的 `id` 是什么，这叫我怎么获取 `form` 的元素节点呢？

世上无难事，只怕有心人啊，还好这个页面相当简单，只有一个 `form` 标签，那么完全可以用  `getElementsByTagName` 来获取标签元素。

当然了，这个和 `getElementsByName` 一样，获取到的是一个数组，通常是第一个元素，也就是数组只有一个成员。

所以代码写成了下面这个样子。

```
parent.frames.mainFrame.document.getElementsByTagName("form")[0].onsubmit=true;
```



好，我们再来试一试哈。

先给 `onsubmit` 赋值 `true` ，然后再来点击重启按钮。

OK了！成功无视确认直接重启路由器！



哈哈，很兴奋吧，可惜前面说了，这个只是坑一，后面还有坑哦！

我们接着说。



### 自动化处理

前面这些代码，实际上只能通过手动方式输入到控制台上执行。

可是我想要的是自动修改密码呀，那么怎么自动化处理执行呢？

这个时候就要让油猴登场了！



油猴有很多，我用的是 `Tamper Monkey` 。

它是火狐或谷歌等浏览器的一个扩展或插件，用于自动执行用户 `JS` 代码。

评分好像最高，于是就选了它。

说实话，我也是第一次用它，对它不是很熟悉，所以接下来的操作都非常适合新手小白。

如何安装我就不说了，作为浏览器插件安装起来非常简单。

接下来还是说一说如何实现自动化处理 `JS` 代码，这才是重点吧。

图15



第一次，我简单粗暴地把前面的那些代码机械地罗列到了油猴中，可惜很快我就认输了。

原因很简单，页面加载往往需要一点的时间间隔，而在页面加载完成前，代码已经跑完了。

所以我们需要给代码加上延时。

```
setTimeout(function() {
  ...
}, 1000);
```



这个其实就是坑二，延时是根据页面加载的速度决定的，通常你可以设定得长一些。

另外在点击或跳转页面时，也会出现加载页面的情况，所以基本上每一步操作都要加上延迟。

之后的完整代码会展示这一点。



如果这个时候你迫不及待地将代码放到油猴里跑上一跑，你会发现似乎真的可以做到自动登录、自动修改密码、并自动重启路由器。

哇！太棒了！这不就是我们想要的吗？

如果你发出如此感叹，我只能说你还是太年轻了。

要知道，当路由器重启后，页面就会自动重新加载，此时你的代码就会再次执行一次，然后路由器又重启了，如此往复、没完没了。

没错，这就是接下来就说的第三个坑！

图16



### 禁止页面重新加载

为什么要禁止页面重新加载，刚才也说了，就是防止页面重启加载而导致程序重头再跑一遍。

但是，我想你会说，不重启 `WIFI` 密码就无法生效啊。

其实事实并不完全是这样的，事实真相是，路由器的确要重启才能生效，与此同时页面会重新加载，而我们并不希望页面重新加载。

怎么办？



方法可能有很多，只不过我是菜鸟小白，我实现找不出其他高明一些的方法。

最后，我只能通过点击其他菜单项来跳转到其他页面，从而通过这样一种看似蠢笨的方式变相地改变触发重启倒计时。

测试的结果是，这样做还真的可行！

```
// 跳转到其他页面，以防真的重启而导致刷新页面重新加载JS
parent.frames.bottomLeftFrame.document.getElementById('a9').click();
```



这下好了，只要页面不重新加载，程序就不会被初始化，我们也就不用担心它无脑式地重复执行了。

不过，这样就算完了吗？



### 生成 WIFI 密码的算法

我们修改 `WIFI` 密码的最初目的是防止他人蹭网，但至少我们自己应该能用啊。

所以我们必须要有一套别人无法识别，但自己却门儿清的密码算法。

当然这种算法可以复杂也可以简单。

举例我将日期作为密码，比如今天是 `2021年06月01日` ，那么密码就是 `20210601` 。

到了第二天，那么密码自动修改为 `20210602` ，以此类推。

所以就很简单了，只要程序能获取到当前的日期即可。



可是还有一个问题，就是程序什么时候修改密码。

总不能一会儿就改一次，路由器可是要重启生效的。

所以必须要有一个判断，即当天只能修改一次。

基于以上，我们可以结论，程序每间隔一定的时间循环判断，当日期变动时，自动修改密码并重启生效。

好了，另一个问题也就随之而来，程序如何判定日期已经变动了？



通常做法是设定一个变量，这个变量存放了当前日期。

等到了第二天，与这个变量对比，就修改密码同时将新的日期放到这个变量中，以备后面再行判断。

想法是不错，可是油猴脚本并不提供数据持久化功能。

就是说，我想将某些信息保存到本地文件中，但这实现不了。

所以说，只能是一次程序跑到底，让这个变量永远保存到内存中不丢弃。

这也是前面不让页面重新加载的另一个原因。



### 完整代码示例

有了算法，再加上前面杂七杂八，终于第一版的代码形成了。



```javascript
// ==UserScript==
// @name         定时修改路由器 WIFI 密码
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  关注@网管小贾公众号 / www.sysadm.cc
// @author       @网管小贾
// @match        http://172.22.15.213/
// @icon         https://www.google.com/s2/favicons?domain=15.213
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...

    //页面完全加载后运行
	window.onload=function autorun() {
		
		console.log('页面加载完毕，可以执行代码！！');

		Date.prototype.Format = function (fmt) {
			let o = {
				"M+": this.getMonth() + 1, //月份
				"d+": this.getDate(), //日
				"h+": this.getHours(), //小时
				"m+": this.getMinutes(), //分
				"s+": this.getSeconds(), //秒
				"q+": Math.floor((this.getMonth() + 3) / 3), //季度
				"S": this.getMilliseconds() //毫秒
			};
			if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
			for (let k in o) {
				if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
			}
			return fmt;
		};
		
        var currentDate = (new Date()).Format("yyyyMMdd");
        var checkDate = '';
		
		function changeWifi() {
			
			currentDate = (new Date()).Format("yyyyMMdd");

			if (currentDate != checkDate) {
				console.log('Different! - currentDate: ' + currentDate + ' | checkDate: ' + checkDate);

				setTimeout(function() {
					try {
						// 登录
						document.getElementById('pcPassword').value = '123456';
						document.getElementById('loginBtn').click();
					}
					catch (e) {
					}

					setTimeout(function() {
						try {
							// 跳转至修改 WIFI 密码页面
							parent.frames.bottomLeftFrame.document.getElementById('a9').click();
						}
						catch (e) {
						}

						currentDate = (new Date()).Format("yyyyMMdd");

						setTimeout(function() {
							
							try {
								// 修改 WIFI 密码
								parent.frames.mainFrame.document.getElementById('pskSecret').value = 'Sysadm' + currentDate;
								// 保存
								parent.frames.mainFrame.document.getElementById('Save').click();

								setTimeout(function() {
									// 跳转至重启页面
									parent.frames.bottomLeftFrame.document.getElementById('a44').click();

									setTimeout(function() {
										// 修改重启提示为 true
										parent.frames.mainFrame.document.getElementsByTagName("form")[0].onsubmit=true;
										checkDate = currentDate;
										// 确认重启
										parent.frames.mainFrame.document.getElementById('reboot').click();

										setTimeout(function() {
											// 跳转到其他页面，以防真的重启而导致刷新页面重新加载JS
											parent.frames.bottomLeftFrame.document.getElementById('a9').click();
										}, 1000);
										
									}, 1000);

								}, 1000);
							
							}
							catch (e) {
							}

						}, 1000);

					}, 1000);

				}, 2000);
		
			} else {
				console.log('Same! - currentDate: ' + currentDate + ' | checkDate: ' + checkDate);
			}
		}
		var myVar;
		myVar = setInterval(changeWifi, 1 * 10 * 1000);
        // console.log(myVar);
	}

})();
```



代码中，默认登录密码是 `123456` ，修改的 `WIFI` 密码是 `前缀 Sysadm + 当前日期` 。

程序每 10 秒循环执行一次。

同时判断当前日期 `currentDate`  与 检查日期 `checkDate` 是否一致。

如果两者一致，则跳过待机，如果不一致，则修改密码。



### 写在最后

经过几天的测试，其效果基本可以做到自动修改为当天的密码，高效拉风、省时省力！

本文测试所用 `Tp-link` 路由器为常见家用式路由器，管理网页界面为旧版风格。

如果你用的就是这个旧版式风格的网页管理，就可以直接拿来测试使用。

有机会我还会做一篇新版风格界面的相关文章。

本文涉及的坑点比较多，故囿于语言组织能力，表述上可能有所不准，请小伙伴海涵！



**扫码关注@网管小贾，阅读更多**

**网管小贾的博客 / www.sysadm.cc**