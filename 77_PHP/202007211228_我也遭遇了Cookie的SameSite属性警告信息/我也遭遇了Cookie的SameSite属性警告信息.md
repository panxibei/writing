我也遭遇了Cookie的SameSite属性警告信息

副标题： SameSite属性是个啥？



某日，我正愉快地敲着代码，突然，浏览器控制台上冒出了几行警告信息！

我驼着背眯缝着眼睛，仔细这么一瞧，瞳孔瞬间放大，心里咯噔一下，整个人都不好了！

它警告我，说是什么 `SameSite` 属性设置为 `none` ，但缺少 `secure` 属性，此 `Cookie` 未来将被拒绝。

图1



要说这只是个警告，咱选择性失明地忽略它也就完了，可是最让人不舒服的，就是那句“此Cookie未来将被拒绝”。

这还了得，我的生命中怎能没有 `Cookie` 啊，说实话，我当时害怕极了！

瑟瑟发抖的我赶紧向大神们求助。



### SameSite 属性是个啥？

我们都知道 `Cookie` ，小甜饼香又甜嘛，不过它在计算机中是指客户端保存用户信息状态的东东。

有了这个东东，用户登录啥的就方便了，不用每次都重复输入用户名和密码。

但是方便的同时也带来了安全问题，因为 `Cookie` 可以做到第三方登录，而别有用心之人就可以利用它做到跨站攻击（*CSRF跨站点请求伪造(Cross—Site Request Forgery)*）。

这是历史遗留问题，所以大神们就在 `Cookie` 中增加了 `SameSite` 属性，用它来标明是否是  `同站 cookie`。

那么有了这个属性，就可以有效防止CSRF攻击或用户追踪。



`SameSite` 属性有三个属性值，分别是

* Strict	严格
* Lax	宽松
* None	未设定



#### Strict

`Strict` 即严格，完全禁止第三方 Cookie，跨站点时，任何情况下都不会发送 Cookie。

换言之，只有当前网页的 URL 与请求目标一致，才会带上 Cookie。

```
Set-Cookie: CookieName=CookieOfSysadm.cc; SameSite=Strict;
```



由于这个设定过于严格，将会造成非常不好的用户体验。

比如，有个朋友转发给你一个链接 `https://www.sysadm.cc/index.php/webxuexi?start=1` ，结果往往是你无法正常打开它。



出现打不开的情况，有时会是强制你重新登录，有时干脆就是警告你链接失效。

比如，当前网页有一个 GitHub 链接，用户点击跳转就不会带有 GitHub 的 Cookie，跳转过去总是未登陆状态。

还有就是像淘宝之类有很多参数的链接，或者是用 `iframe` 嵌套的网站，都会因为设定严格无法获取Cookie信息而无法打开。



另外，如果你设定了 `Strict` ，那么从第三方跳转至需要CSRF令牌验证的网站表单时，则需要禁用CSRF令牌验证，否则表单可能工作不正常。

于是乎这个设定值，似乎也只能是适合基本不会有第三方登录的系统，例如类似于一个很少用户使用的后台管理系统。



#### Lax

`Lax` 规则相对 `Strict` 宽松一些，大多数情况也是不发送第三方 Cookie，但是导航到目标网址的 GET 请求除外。

```
Set-Cookie: CookieName=CookieOfSysadm.cc; SameSite=Lax;
```



导航到目标网址的 GET 请求，只包括三种情况：链接、预加载和GET表单。

| 请求类型   | 代码示例                      | Lax设定下是否发送Cookie |
| ---------- | ----------------------------- | :---------------------: |
| Link       | a href="…"                    |            ◯            |
| Pererender | link rel="prerender" href="…" |            ◯            |
| Form GET   | form method="get" action="…"  |            ◯            |
| Form POST  | form method="post" action="…" |            ×            |
| iframe     | iframe src="…"                |            ×            |
| AJAX       | $.get('…')                    |            ×            |
| Image      | img src="…"                   |            ×            |



`Lax` 设定的好处至少有两个。

1. 即使从其他网站跳转过来也能维持登录状态，因此容易导入已有的Session管理。
2. 因为限制了POST不能发送Cookie，所以同 `Strict` 一样杜绝了CSRF攻击的可能性。



#### None

未设定值，这个是目前的默认值，不过为了安全考虑 `Chrome` 计划将 `Lax` 变为默认设置。

**这也就是文章开关碰到的 “此Cookie未来将被拒绝” 警告信息出现的原因。**

当然了，网站可以选择显式关闭 `SameSite` 属性，将其设为 `None` 。

不过，前提是必须同时设置 `Secure` 属性（Cookie 只能通过 HTTPS 协议发送），否则无效。

**这也是 “某些 Cookie 滥用推荐的“sameSite“属性” 的原因。**

```
Set-Cookie: laravel_session=sysadm.cc; SameSite=None; Secure
```



### SameSite 属性使用注意点

1、修改 `SameSite` 需要后端语言的支持，而 `php` 的 `setcookie` 函数需要 `php7.3` 版本以上才可以支持。

`php7.3` 以下版本需要通过 `header` 进行设置 `cookie` 的 `SameSite` 属性。

>  关于php7.2即将过期的信息，请参考文章：[《WampServer官方下载去哪儿了？》](https://www.sysadm.cc/index.php/xitongyunwei/692-wampserver)



2、使用 `Laravel` 的小伙伴们可以参考以下方法设定 `SameSite` 属性。

找到 `项目根目录/config/session.php` 文件，按需修改即可。

```php
    /*
    |--------------------------------------------------------------------------
    | Same-Site Cookies
    |--------------------------------------------------------------------------
    |
    | This option determines how your cookies behave when cross-site requests
    | take place, and can be used to mitigate CSRF attacks. By default, we
    | do not enable this as other CSRF protection services are in place.
    |
    | Supported: "lax", "strict"
    |
    */

    'same_site' => "lax",
```



### 简单总结

如果小伙伴们遇到没有正常发送 `Cookie` 的问题，那么看看会不会是以下两个问题没整好。

1、跨站请求时，需要同时设置为  `SameSite=None` 和 `Secure` 时，才会发送 `Cookie` 。

2、`Chrome` 浏览器默认 `SameSite` 属性设定为 `Lax` ，所以网站后端相应的  `SameSite` 属性应该设定为对应的非 `None` 值，否则会出现无法发送（或获取）Cookie的情况。



好了，终于整明白了！

最后经过修改，重新刷新配置缓存（`php artisan config:cache`），再打开调试控制台后警告信息消失了。

谢天谢地，我又可以开始愉快的写代码了。



> WeChat @网管小贾 | www.sysadm.cc

