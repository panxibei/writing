新版 TPLINK 家用路由器实现自动修改 WIFI 密码

副标题：

英文：

关键字：









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

