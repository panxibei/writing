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
								parent.frames.mainFrame.document.getElementById('pskSecret').value = 'Aota' + currentDate;
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