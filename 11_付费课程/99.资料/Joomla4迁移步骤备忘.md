Joomla4迁移步骤备忘



1、主程序安装



2、各参数配置



3、扩展

隐藏功能：ECR（easycontentrestriction）



验证码：

* Friendly Captcha（首选）
* 数字连连看 jGraphicCaptchaProtection
* 问答：joomla_plg_qa
* hCaptcha（备选）



邀请码：joomla_plg_regauth



评论功能：pkg_engage-3.1.1



图片缩略图功能：plg_mouseoverzoom



markdown：akmarkdown安装到Joomla!4上的方法



4、WebAuthn

这个功能是用来无密码登录用的，用户必须要注册再登录后方可设定这个功能，之后即可只输入用户名再验证就可以登录了。

验证方法有 Windows Hello、指纹、U盘等等设备方式。

这个可能需要https受信任证书才能测试（ https://127.0.0.1可能无效），暂时先保留。

如果不适合使用，那么可以关闭它。

* 在 网站前台模块 > 会员登录（Login Form）里关闭个人资料链接，防止用户使用这个功能。
* 在扩展插件中将 `系统 - WebAuthn 无密码登录` 关闭





