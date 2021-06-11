历经艰难险阻，我搞定了自动修改路由器 WIFI 密码

副标题：宝宝再也不怕被蹭网了~

英文：after-a-lot-of-difficulties-i-resolved-issue-to-change-wifi-password-of-router-automatically

关键字：tplink,wifi,router,路由器,密码



请告诉我，你们有没有经常被蹭网的经历？

简单地说，就是路由器 `WIFI` 密码设置得太简单，很容易就被别人猜到了，然后就悲剧了。

这种情况下通常好像我们能做的也就是重新修改密码。

然而过了一段时间，悲剧又戏剧性地再次上演。



老是这样可不行啊！

即使是设定一个超长超强的密码，一旦有人知道了，那么后果就是用不了几天，整层楼甚至整栋楼的人可能就都知道了。

这时只有一个变相的办法，就是频繁修改密码。

似乎有很多安全专家也鼓励我们要经常性地更新自己的密码。

道理我懂，可我总不能一天到晚动不动就去修改密码啊！

要是手上有一二十个路由器也这么干？

难道要逼我躺平？

哎，先别慌，想办法让它自动更新密码不就得了！

于是我就开始动脑筋了，思考着有没有一个好一点的办法，能让路由器定时地自动地修改密码。



最初我想到的是，能不能通过 `Telnet` 远程连接到路由器，然后使用 `Cli` 命令修改密码。

这招看似可行，虽然我可以控制程序自动 `Telnet`  连接，可是，大多数情况下我们用的都是家用路由器啊，那玩意根本就不支持 `Telnet` 连接啊喂！

好像只有所谓企业版的路由器有支持 `Cli` 指令，但这并没有什么普遍性。

呵呵，此路不通！



两千年后，我突发奇想、灵光乍现，有了一个奇葩想法。

既然我们平时修改密码都是在路由器的管理页面上点来点去的，那我们能不能通过模拟鼠标点击来实现修改密码的功能呢？

呃...这个想法好像有点疯狂哈！

哥们靠谱不？

肚子里带着那么一点点可怜的 `JS` 知识，我决定搏一把看看。

也没有其他办法了不是吗，上吧！

于是我找来了一台旧版式管理页面的 `Tp-link` 路由器（型号 `TL-WR880N` ），就它了！



**实验准备工作：**

* 一台 Windows 10 系统电脑
* 火狐（或谷歌）浏览器
* 一根网线连接到路由器的 LAN 口
* 设定路由器与电脑为可互访的同一网段 IP 地址



### 组织代码，编写程序

首先，我们要搞定页面自动登录。

使用火狐打开路由器管理首页，按下 `F12` 开启调试控制台界面，点击 `查看器` 一项，再点下左边的那个小箭头，然后将鼠标定位到密码输入栏处。

OK，顺利找到了密码框的 `id` ，为 `pcPassword` 。

相应的代码如下（假定登录密码是 `123456` ），那么我们就可以自动填充密码了。

```
document.getElementById('pcPassword').value = '123456';
```

图1



密码自动填上了，我们还需要点击确定按钮，有了这个动作才能正常登录。

用相同的方法，定位确定按钮的 `id` ，为 `loginBtn` 。

同样用代码来模拟点击。

```
document.getElementById('loginBtn').click();
```

图2



可以先测试一下，切换到 `控制台` 标签页，然后输入前面那两行代码。

然后回车，即可使用代码自动登录进入管理页面。

图3



这个过程中没有真正用鼠标去点击，而只是用了代码，是不是很神奇？

这里需要说明一点，通常页面登录验证信息是加密的，所以想通过直接提交验证链接的方法来实现登录有些困难。

好，登录进来之后，我们就要找一找在哪里可以修改密码，这才是我们的主要目的。



需要事先说明的是，通常 `Tp-link` 旧款式管理页面使用的是框架结构，就是传说中的 `frameset` 标签元素，所以实际上它的左侧菜单和右侧内容是分别属于不同的框架区域的。

类似于如下这个样子。

```
<frameset>
  <frameset>
  	<frame>顶部内容</frame>
  </frameset>
  <frameset>
    <frameset>
  	  <frame name="bottomLeftFrame">左侧菜单</frame>
    </frameset>
    <frameset>
  	  <frame name="mainFrame">右侧内容</frame>
    </frameset>
  </frameset>
</frameset>
```



总之大框架里套小框架这样子的形式，是不是有点眼花，所以说不太推荐用这种框架。

基于这种框架元素的间隔，左右两侧的代码是有些不一样的，而用名字 `name` 来区分，左侧名字叫 `bottomLeftFrame` ，而右侧名字叫 `mainFrame` 。

而左右两侧的元素就得跟着自己所在的框架走了，也就是它们的代码前缀会有些不同，下面会详细说到。

图4



好，框架大概了解了，我们来找一下设置密码的地方。

在左侧菜单中，找到 `无线安全设置` 菜单项，它的 `id` 为 `a9` 。

图5



如要点击它，代码应该是这个样子，注意前面要加上所在框架（左侧框架 `bottomLeftFrame` ）。

```
parent.frames.bottomLeftFrame.document.getElementById('a9').click();
```

图6



OK，我们来到了 `WIFI` 密码设置页面，接下自然就是想办法修改这里的密码了。

依旧如法炮制，获取到密码框的 `id` 为 `pskSecret` 。

图7



给它重新赋值就很简单了，用如下代码，注意这次它是在右侧主框架 `mainFrame` 中了。

```
parent.frames.mainFrame.document.getElementById('pskSecret').value = '66666666';
```

注意此处密码要求 8 位以上，小于8位会出错而导致程序执行失败。

图8



密码改好了，接着我们要保存才能生效对吧，找一找保存按钮吧。

页面最下面有保存按钮，`id` 也找到了，是 `Save` 。

```
parent.frames.mainFrame.document.getElementById('Save').click();
```

图9



嗯，看到这儿是不是感觉还挺简单的？

其实后面还有很多坑呢。

你瞧，这坑说来就来了！



坑之一，在点击保存按钮的代码顺利执行后，你会发现它会弹出个提示，告诉你重启路由器密码才能生效。

图10



我用手机试着连接过，的确只有重启后新密码才有用。

所以接下来还得研究一下如何让它重启。

活还没干完哈，继续上路！



一般来说，系统管理页面中是自带有重启路由器的菜单项的。

果不其然，找到了它，确认 `id` 为 `a44` 。

那么点击它的代码就是如下了，别忘记它是属于左侧框架中的哦。

```
parent.frames.bottomLeftFrame.document.getElementById('a44').click();
```

图11



再找到 `重启路由器` 按钮的 `id` 为 `reboot` 。

```
parent.frames.mainFrame.document.getElementById('reboot').click();
```

图12



在这儿看似坑一被填上了，嘿嘿，可惜别高兴得太早。

虽然我们可以点击重启按钮了，可是它喵的居然弹出个确认提示框来。

图13



嘿，我勒个去啊！

这个确定要怎样才能点击上呢？

查了大半天的资料，有网友说可以这么搞，说是可以覆盖原 `windows.alert` 方法，这样它就不弹出来了。

类似于以下几种都可以，通过覆盖并返回 `false` 来规避。

```
@grant        unsafeWindow

unsafeWindow.alert = function(){return false};
window.alert = function(){return false};
Window.prototype.alert = function(){return false};
```



可惜太扯了，这种方法是无效的，原因很简单，有两个。

一个是 `alert` 是阻塞式的，也就是说当弹出窗口时，后面的代码就中断了，根本就不执行，又如何把它关闭呢。

二个是无法覆盖，反正我没成功过，但再转念一想，即使覆盖成功了，也无法达到目的。

因为它是要确认 `true` 或 `false` 的，如果覆盖了，之后代码又如何走呢？

基于以上原因，我决定换个思路。

比如说，看我能不能修改原代码，使其确认自动返回 `true` 不就行了！

这个...好使不？

你还别说，真让我给找着了！



我将重启路由器的页面保存下来，顺藤摸瓜找到了提交表单的元素项，最后定位到了其中有一个叫作 `onsubmit` 的标签。

```
onsubmit="return doSubmit();"
```

很显示，这玩意应该就是提交重启时的函数代码啊！

然后我接着找，找这个叫作 `doSubmit()` 的函数。

果然在隔壁胡同寻到了它的身影。

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



找到这儿就已经很清楚了，这个 `doSubmit()` 就是按确认提示后返回 `true` 或 `false` 来进行判断是否重启。

那么这下就简单了，只要我主动返回给 `onsubmit` 这一元素 `true`  值不就行了呗。

那这代码应该怎么写呢？



我来来回回找了半天，也没找着 `form` 的 `id` 是什么，这叫我怎么获取 `form` 的元素节点呢？

世上无难事，只怕有心人啊，还好这个页面相当简单，只有一个 `form` 标签，那么完全可以用  `getElementsByTagName` 来获取标签元素。

当然了，这个和 `getElementsByName` 一样，获取到的是一个数组，只有一个标签的话那通常就是在数组的第一个成员了，也就是数组长度只有 1 。

所以代码写成了下面这个样子。

```
parent.frames.mainFrame.document.getElementsByTagName("form")[0].onsubmit=true;
```



好，我们再来试一试哈。

先给 `onsubmit` 赋值 `true` ，然后再来点击重启按钮。

哈哈，OK 了！成功无视确认直接重启路由器！



哈哈，很兴奋吧，可惜前面说了，这个只是坑一，骚年别激动，后面还有坑哩！

从坑里跳出来，我们接着说下一个坑。



### 自动化处理

前面这些代码，实际上只能通过手动方式输入到控制台上执行。

可是我想要的是自动修改密码的效果呀，怎么才能自动化处理执行呢？

这个时候就要请大名鼎鼎的油猴登场了！



油猴有很多，我用的是 `Tamper Monkey` 。

它是火狐或谷歌等浏览器的一个扩展或插件，用于自动执行用户自定义 `JS` 代码。

感觉评分好像最高，于是就选了它。

说实话，我也是第一次用它，对它的一切不是很熟悉，所以接下来的操作都非常适合新手小白。

如何安装我就不说了，作为浏览器插件安装起来非常简单方便。

接下来还是说一说如何实现自动化处理 `JS` 代码，这才是重点对吧。

图15



头一次，我简单粗暴地把前面的那些代码机械地罗列到了油猴中，可惜很快我就惨败了。

原因很简单，页面加载往往需要一点的时间间隔，而在页面加载完成前，代码已经跑完了。

为了让代码能赶上上实际页面加载情况，所以我们需要给代码加上延时。

```
setTimeout(function() {
  ...
}, 1000);
```



这个其实就是坑二，延时是根据页面加载的速度决定的，通常你可以设定得长一些，比如 3 到 5 秒的样子。

另外在点击或跳转页面时，也会出现加载页面的情况，所以基本上每一步操作都要加上延迟。

之后的完整代码会展示这一点。



如果这个时候你迫不及待地将代码放到油猴里跑上一跑，你会发现似乎真的可以做到自动登录、自动修改密码、并自动重启路由器。

哇！太棒了！这不就是我们想要的吗！

我们成功了！

如果你发出如此感叹，我只能说你还是太年轻了，至少文章在这里才刚过一半。

要知道，当路由器重启后，页面就会自动重新加载，而只要页面加载，油猴中的代码就会自动开始执行。

此时你的代码就会再次执行一次，然后路由器又重启了，如此往复、没完没了，让人流泪，令人心碎。

没错，这就是接下来要说的第三个坑！

图16



### 禁止页面重新加载

为什么要禁止页面重新加载，刚才也说了，就是防止因页面重启加载而导致程序重头再跑一遍。

但是，我想你会说，不重启 `WIFI` 密码就无法生效啊。

其实事实并不完全是这样的，事实真相是，路由器的确要重启才能生效，与此同时页面会重新加载。

而我们希望的是路由器可以重启，但并不希望页面重新加载或刷新。

怎么办？



方法可能有很多种，只不过我是菜鸟小白，我实在找不出其他高明一些的办法。

最后，我只能通过点击其他菜单项来跳转到其他页面，从而通过这样一种看似蠢笨的方式变相地改变触发重启倒计时。

比如在重启倒计时时，点击一下修改密码的菜单项，回到密码修改页面。

测试的结果是，这样做还真的可行！

```
// 跳转到其他页面，以防重启而导致刷新页面重新加载JS
parent.frames.bottomLeftFrame.document.getElementById('a9').click();
```



这下好了，只要页面不重新加载刷新，程序就不会被初始化，我们也就不用担心它无脑式地重复执行了。

不过，这样就算完了吗？



### 生成 WIFI 密码的算法

我们修改 `WIFI` 密码的最初目的是防止他人蹭网，但至少我们自己应该能用啊。

所以我们必须要有一套别人无法识别，但自己却门儿清的密码算法。

当然这种算法可以复杂也可以简单。

举例，我将日期作为密码，比如今天是 `2021年06月01日` ，那么密码就是 `20210601` 。

到了第二天，那么密码自动修改为 `20210602` ，以此类推。

所以就很简单了，只要程序能获取到当前的日期即可。



可是还有一个问题，就是程序什么时候修改密码。

总不能一会儿就改一次，路由器可是要重启生效的。

所以必须要有一个判断，即当天只能修改一次。

基于以上，我们可以得出结论，程序每间隔一定的时间循环判断，当日期变动时，自动修改密码并重启生效。

好了，另一个问题也就随之而来，程序如何判定日期已经变动了？



通常做法是设定一个变量，这个变量存放了当前日期。

等到了第二天，与这个变量对比，就修改密码同时将新的日期放到这个变量中，以备后面再行判断。

想法是不错，可是油猴脚本并不提供数据持久化功能。

就是说，我想将某些信息保存到本地文件中，但这实现不了。

所以说，只能是一次程序跑到底，让这个变量永远保存到内存中不丢弃。

这也是前面不让页面重新加载的另一个原因。



### 完整代码示例

有了算法，再加上前面杂七杂八的条件，终于第一版的代码形成了。



```javascript
// ==UserScript==
// TP-Link 路由器 型号 TL-WR880N 测试通过
// @name         定时修改路由器 WIFI 密码
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  网管小贾的博客 / www.sysadm.cc
// @author       @网管小贾
// @match        http://192.168.1.1/
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

							currentDate = (new Date()).Format("yyyyMMdd");

							setTimeout(function() {
								
								try {
									// 避免重复修改
									if (parent.frames.mainFrame.document.getElementById('pskSecret').value != 'Sysadm' + currentDate) {
										
										// 修改 WIFI 密码
										parent.frames.mainFrame.document.getElementById('pskSecret').value = 'Sysadm' + currentDate;
										// 保存
										parent.frames.mainFrame.document.getElementById('Save').click();

										setTimeout(function() {
											try {
												// 跳转至重启页面
												parent.frames.bottomLeftFrame.document.getElementById('a44').click();

												setTimeout(function() {
													try {
														// 修改重启提示为 true
														parent.frames.mainFrame.document.getElementsByTagName("form")[0].onsubmit = true;
														
														// 确认重启
														parent.frames.mainFrame.document.getElementById('reboot').click();

														setTimeout(function() {
															// 跳转到其他页面，以防真的重启而导致刷新页面重新加载JS
															parent.frames.bottomLeftFrame.document.getElementById('a9').click();
															checkDate = currentDate;
														}, 1000);
													
													}
													catch (e) {
														checkDate = '';
													}
													
												}, 1000);
												
											}
											catch (e) {
												checkDate = '';
											}

										}, 1000);
									
									}
								
								}
								catch (e) {
									checkDate = '';
								}

							}, 1000);
						
						}
						catch (e) {
							checkDate = '';
						}


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



代码中，默认管理员登录密码是 `123456` ，修改的 `WIFI` 密码是 `前缀 Sysadm + 当前日期` 。

程序每 10 秒循环执行一次。

同时判断当前日期 `currentDate`  与 检查日期 `checkDate` 是否一致。

如果两者一致，则跳过待机，如果不一致，则修改密码。

本程序代码在`Tp-link` 路由器（型号 `TL-WR880N` ）上测试通过。



完整 JS 代码下载：

**定时修改路由器 WIFI 密码.7z (29.5K)**

下载链接：



**最终效果动图演示：**

图17.gif



### 写在最后

经过几天的测试，其效果基本上可以做到自动修改为当天的密码，程序高效、外貌拉风、省时省力，值得拥有！

本文测试所用 `Tp-link` 路由器为常见家用式路由器，管理网页界面为旧版风格。

如果你用的就是这个旧版式风格的网页管理，就可以直接拿来测试使用。

当然，有机会我还会做一篇新版风格界面的相关文章。

此外如果你是其他品牌的路由器，也可以利用本文的思路来定制适合自己品牌和型号路由器的程序代码，从而实现最终想要的效果。

本文涉及的坑点比较多，故囿于语言组织能力，表述上可能有言不达意之处，还请小伙伴们海涵！

希望小伙伴们积极关注我，多多点赞转发，多多批评指教！



**扫码关注@网管小贾，阅读更多**

**网管小贾的博客 / www.sysadm.cc**