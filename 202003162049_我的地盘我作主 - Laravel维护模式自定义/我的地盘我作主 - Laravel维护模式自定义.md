我的地盘我作主 - Laravel维护模式自定义

不得不承认，现实中不管你的系统是多么的简单还多么的复杂，总是逃不脱更新和维护这一大问题。

但如果你使用过Laravel来建立站点系统的话，肯定多少会了解到它的维护模式还算是方便易上手。

瞧！两条命令搞定一切。

`php artisan down` 和 `php artisan up`，一个启用，一个关闭。

超级简单是不是？



再复杂一些，也不过是加了几个选项，如：

`message` 显示或记录自定义消息

```php
php artisan down --message="Upgrading Database"
```

`allow` 维护模式中允许特定的网络访问

```php
php artisan down --allow=127.0.0.1 --allow=192.168.0.0/16
```



简单易懂吧？可惜并不轻松愉快！

为什么这么说尼？

原因很扎心，如果遇到频繁需要维护的场景，每次都要手写一番消息和特定许可IP，的确感觉有些吃不消啊！

那怎么办？

还能怎么办，盘它呗！



图1



通过一顿猛操作，网上搜集到的信息这么那么一综合，有了！

基本思路是，修改中间件 `CheckForMaintenanceMode.php` ，通过数据库读取出自定义消息和特定IP地址。

如果符合特定允许条件，则正常返回请求，否则显示出自定义维护消息。



1、找到中间件 `CheckForMaintenanceMode.php` 的handle方法。



2、添加以下代码，用于判断是否开启了维护模式（实际是判断 `storage/framework/`下是否存在 `down` 文件）

```php
if ($this->app->isDownForMaintenance()) {}
```



3、允许IP地址的判断代码，这个最好写在判断down文件内容的前面。

```php
// 读取维护模式所需的消息及特定IP地址
$config = Config::where('cfg_name', 'SITE_MAINTENANCE_ALLOWED')
	->orWhere('cfg_name', 'SITE_MAINTENANCE_MESSAGE')
	->pluck('cfg_value', 'cfg_name')->toArray();

// 允许的IP地址，由字符串转成数组形式
// 如：'127.0.0.1', '10.10.10.10' 转换为 ['127.0.0.1', '10.10.10.10']
$allowed_ip = explode(',', $config['SITE_MAINTENANCE_ALLOWED']);

// 如果在允许范围内，则正常返回请求
if (in_array($request->getClientIp(), $allowed_ip)) {
	return $next($request);
}
```



显示自定义维护消息，写在down文件判断的后面比较好。

```php
if($request->ajax()){
	// 如果是ajax请求，则返回相应信息
	return response()->json();
} else {
	// 如果有系统维护的自定义消息内容，则显示之
	if (!empty($config['SITE_MAINTENANCE_MESSAGE'])) {
		$data['message'] = $config['SITE_MAINTENANCE_MESSAGE'];
}

    // 抛出503
    abort(503, $data['message'] == null || $data['message'] == '' ? '很抱歉，系统维护中！ 请稍后再试！' : $data['message']);
}
```



总结一下，大概按照以下流程。

先判断自定义的IP，再判断down文件的allow，最后显示自定义维护消息。

实际使用中就很方便啦！

每次需要维护时，只要事先编辑好维护的提示消息和可以访问的IP地址，然后直接打上 `php artisan down` 开启维护模式，完事后再 `php artisan up` 关闭维护恢复正常访问就欧了。

真香！

图2



当然，数据库的配置项你应该会创建的吧，官方手册里有写哦。

还是不会？那你可以留言给我。



**公众号：网管小贾**

