phpipam

副标题：

英文：

关键字：





将 `phpipam` 压缩包解压到 `web` 目录中。

接着找到 `config.dist.php` ，将其复制一份并命名为 `config.php` 。

图a01



没错，这就是配置文件，用文本编辑软件打开它吧。

找到相关设置，比如数据库设定，修改为你的实际环境参数。

图a02



还有另一个比较重要的设定，就是网址链接访问路径。

如果你的 `phpipam` 不在 `web` 站点的根目录中，那么就需要添加一下子目录路径。

比如你的子目录是 `phpipam` ，那么对于当前站点来说，它的相对根目录就应该在 `/phpipadm/` 上，而不是在 `/` 上。

图a03



如果安装过程中出现缺少 `PEAR` 支持的提示，那么我们需要安装 `PEAR` 。

图e06



以管理员权限打开命令行窗口，切换到 `php.exe` 的相关路径下，执行以下命令安装 `pear` 。

```
php go-pear.phar
```

图e01



`go-pear.phar` 可以不需要到网上查找，在文末就有最新版下载。

命令执行后，基本上可以一路无脑回车，不过需要注意的是，应该确保 `php.exe` 的 `CLI` （即命令行）路径务必要正确！

图e02



其他提示下直接回车，最后完成安装。

图e03



可以使用如下命令测试查看 `pear` 是否正常输出内容。

```
pear help
pear version
```

图e05



如果出现错误，可能是 `pear.bat` 文件不存在造成的。

找到 `php.exe` 所在路径，看看是不是有个以 `pear` 开头并且以 `old` 结尾的文件。

如果有，将它重命名为 `pear.bat` 即可。

图e04



注意，如果在后续的安装过程中仍然出现缺少 `PEAR` 支持的提示，而实际上我们也的确是有安装的，那么我们只能用一点特殊手段来跳过这个烦人的警告了。

我们可以按如下路径找到检查 `php` 扩展的脚本文件。

```
phpipam/functions/checks/check_php_build.php
```



打开这个 `check_php_build.php` 文件，找到如下字样的代码，将其注释即可。

```
# Check for PEAR functions
if (!@include_once 'PEAR.php') {
    $missingExt[] = "php PEAR support";
}
```

图d02





一切准备就绪后，我们在浏览器的地址栏中输入以下链接。

```
# phpipam放在根目录，就这样写
http://localhost
或者
http://ip

# phpipam放在子目录，就这样写
http://ip/phpipam
或者
http://localhost/phpipam
```



出现了安装界面，一般选择 `新的 phpipam 安装` 。

图c01



紧接着就是安装数据库了，一般选择 `自动数据库 安装` 。

图c03



填写数据库所必需的用户名、密码及名称等信息开始安装吧。

图c04



然后给管理员一个密码，给网站起一个标题，保存 `Save settings` ！

图c05



最后就可以登录我们的 `phpipam` 站点啦！

图c06





```
C:\wamp64\www\phpipam>php phpipam-agent/index.php discover
```

