新版 TPLINK 家用路由器实现自动修改 WIFI 密码

副标题：我这儿有每天自动更新 WIFI 密码的方法，来瞧瞧吧~

英文：tplink-router-how-to-change-wifi-password-automatically-everyday

关键字：tplinke,router,wifi,password,change,ssid



前一阵子，我突发奇想撸了个自动修改 `WIFI` 密码功能的代码。

说白了就是用油猴自动执行 `JS` 代码，来自动控制和操作路由器管理页面，从而达到自动更新密码的目的。



> 参考文章：《历经艰难险阻，我搞定了自动修改路由器 WIFI 密码》
>
> 文章链接：https://www.sysadm.cc/index.php/xitongyunwei/841-after-a-lot-of-difficulties-i-resolved-issue-to-change-wifi-password-of-router-automatically



看过之前文章的小伙伴们应该知道，前文中我使用的是旧版 `TP-Link` 的路由器，其管理页面是旧式的，操作起来着实麻烦。

其中居然还用到了 `frameset` 这种极具复古风情的标签元素，让我又回味了一把不忍回忆的过往。

所以说，整个代码的实现过程中，充满了艰辛和痛苦。

不过好在`TP-Link` 新版路由器的管理界面较旧版的要精练简化得多，这也更方便我们定位、获取和操作这些标签元素。

现今流行使用的正是这种新版管理界面的路由器，所以对于大家来说，本文内容和代码更适合参考并且完全可以直接拿来使用。

最近正好新买了一台 `TL-WDR8661` ，`AC2600` 起步，一般家用无线没问题，就拿它演示了。

还多说啥，直接开干吧！



### 搞定自动登录

按下 `F12` 打开火狐的调试窗口，点选 `查看器` 来定位网页标签元素。

点击左侧的箭头图标，用鼠标来定位密码框。

取得密码框的 `id` 为 `lgPwd` ，那么自动填入密码的代码就是这样。

```
// 填入密码
document.getElementById('lgPwd').value = '123456';
```

图1



接着是获取 `确定` 按钮的 `id` ，为 `loginSub` ，编写点击确定的代码如下。

```
// 按下确定登录按钮
document.getElementById('loginSub').click();
```



### 定位密码修改框

成功登录管理页面后，我们就可以直接看到无线密码设定的地方。

既然第一个页面就放着密码修改的设定，那么我们直接去改不就完了？

哎，这么说也没啥问题，但这里需要注意一个小细节，就是我们务必要保证的的确确是定位到了这个页面。

啥意思？

大白话就是说，我们要先保证不会由于某种原因（比如说误点击）而导致跳转到了其他页面，否则我们是找找不到我们想要的密码修改框的。

所以，我们要先让代码定位一下这个页面，然后再考虑修改密码的问题。

那么问题来了，这个首页是从哪里定位的呢？



#### 定位首页

通过观察，我们很容易地就知道，原来是通过点击下方一排方格图标来切换不同功能的网页的。

点击第一个“网络状态”这个图标，就可以定位首页。

OK，那么接下来就简单了，很容易地我们就可以获取到这个 `div` 标签元素的 `id` 为 `netStateMbtn` 。

是 `div` 吗，难道不应该是 `button` 之类的标签？

其实从它的 `id` 名称上也能看出来，它是充当了一个按钮的角色。

于是点击它的代码就应该是这个样子。

```
// 点击网络状态图标
document.getElementById('netStateMbtn').click();
```

图3



#### 修改并保存密码

定位首页 OK 后，我们就可以来考虑如何修改并保存密码了。

如前面所操作的那样，没有什么特别的悬念，定位密码输入框及保存按钮的 `id` ，分别是 `hostWifiPwdBs` 和 `hostWifiSaveBs` 。

填充密码及点击确定按钮的代码就可以这样写了。

```
// 修改 WIFI 密码
document.getElementById('hostWifiPwdBs').value = 'password';

// 点击保存
document.getElementById('hostWifiSaveBs').click();
```

图4

图5



事情到这儿似乎结束了，真的吗？

不然，其实还有一个小坑！

当你点击保存按钮时，系统会弹出警告提示你是否真的确定更新密码。

这个框挺讨厌的是吧，不过这也是程序通常的做法，确保用户没有误操作。

好了，既然它出现了，那么我们就必须想办法处理它。

打起精神，继续加油吧！



#### 消灭警告提示框

当警告窗口出现后，我们就可以定位窗口中确定按钮的 `id` 。

纳尼？没有 `id` ？

果然可怕的事情发生了，它居然没有 `id` ，那还怎么玩？

哎，别慌哈，我发现它有个 `class` ，是 `subBtn ok` ，这个 `class` 能不能用来定位呢？

还好答案是肯定的，不过需要用到 `getElementsByClassName` 。



小伙伴们应该注意到了吧，是 `Elements` ，而不是 `Element` ，英文单词是复数。

这就意味着，它是用来获取一组元素的，那么得到的结果就不是单个的而是多个的，所以结果是通过数组的形式来表达。

OK，在这个页面中我们找不到第二个 `class` 是 `subBtn ok` 的标签元素来，所以这个确认按钮只能是数组的第一个成员了。

那么代码应该是这个样子吧。

```
// 关闭确认提示
document.getElementsByClassName('subBtn ok')[0].click();
```

用控制台可以测试一下代码是否正确。

图6





### 完整参考代码及演示画面

由于考虑到诸多的程序问题（比如程序中断等），我们需要加入一些延迟、判断、比较等相应的代码用来完善整个程序。

此处举例，比如每天自动修改密码，密码的算法由你自己决定，可简单亦可复杂，只要你自己能猜出来而别人不那么容易猜出来就行。

还有其他一些需要考虑的问题，就由小伙伴们自行判断和完善代码吧。



以下参考代码基本可以实现这样一些功能：

* 自动登录管理页面
* 每天自动填充密码并保存
* 密码算法为固定字符串加当天日期（比如 `Sysadm20210606` ）
* 循环判断密码是否过期，并可确保路由器离线后再次上线仍能执行修改密码的功能



**完整代码下载：**

下载链接：

提取码：



将代码保存到油猴中，刷新路由器页面即可开始执行。

关于油猴的操作，具体可以参考前文（本文开头有链接），也可以参考其他文章，此处暂不赘述。



```js
// ==UserScript==
// TP-Link 路由器 型号 TL-WDR8661 测试通过
// @name         定时修改路由器 WIFI 密码
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  网管小贾的博客 / www.sysadm.cc
// @author       @网管小贾
// @match        http://192.168.1.1/
// @icon         https://www.google.com/s2/favicons?domain=89.251
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
						document.getElementById('lgPwd').value = '123456';
						document.getElementById('loginSub').click();
					}
					catch (e) {
					}

					setTimeout(function() {
						try {

							currentDate = (new Date()).Format("yyyyMMdd");
                            
                            // 定位“网络状态”首页画面
							document.getElementById('netStateMbtn').click();

							setTimeout(function() {

								try {
									// 避免重复修改
									if (document.getElementById('hostWifiPwdBs').value != 'Sysadm' + currentDate) {

										// 修改 WIFI 密码
										document.getElementById('hostWifiPwdBs').value = 'Sysadm' + currentDate;
										// 保存
										document.getElementById('hostWifiSaveBs').click();
                                        // 关闭确认提示
                                        document.getElementsByClassName('subBtn ok')[0].click();

                                        setTimeout(function() {
											checkDate = currentDate;
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

图7



### 写在最后

本着能动手绝不逼逼的原则，我简单粗暴地撸了这么一些低劣代码，各位见笑！

虽然自己想要的效果基本能够实现，但囿于自身水平，程序代码仍有诸多不足之处，万望各路大神指点一二。

那么各位小伙伴在实际使用的过程中，其最终效果能否真正满足实际需求呢？

希望大家都来说一说，聊聊自己的看法。

如果小伙伴们还有什么其他的奇思妙想，欢迎关注我，我们一起讨论。

最后祝大家不必再为被蹭网而烦恼，自己的无线路由器自己做主！



**扫码关注@网管小贾，阅读密码**

网管小贾的博客 / www.sysadm.cc
