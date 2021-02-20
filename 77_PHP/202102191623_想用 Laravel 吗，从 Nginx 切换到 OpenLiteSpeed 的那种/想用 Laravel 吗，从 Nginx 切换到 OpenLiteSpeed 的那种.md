想用 Laravel 吗，从 Nginx 切换到 OpenLiteSpeed 的那种

副标题：亲，这边建议您使用 OLS + Laravel 组合呢~





### OpenLiteSpeed 简介



OpenLiteSpeed 和 LiteSpeed 的区别



知识库链接：https://openlitespeed.org/kb/



### OpenLiteSpeed 的安装



网上铺天盖地都是如何一键安装 `OLS` ，如果你的应用是 `wordpress` ，那么倒可以参考参考，因为一键安装可以连带 `wordpress` 及其插件一股脑儿地全部搞定。

可是，我虽然是个小白，但我同时又是个完美强迫症，在这里我只用最简单、直接的方法来安装。

是的，我要用的正是官方建议的二进制包安装方法。

链接：https://openlitespeed.org/kb/install-from-binary/



注意，安装时需要管理员权限。

先将二进制包下载下来，可以到下载页上下载，也可以直接使用 `wget` 。

```
wget https://openlitespeed.org/packages/openlitespeed-1.7.8.tgz
```



我安装的是官方最新版本 `1.7.8` ，这个包大概 71.6 MB，官网下载比较慢，在这我留个国内的备用下载链接。

**openlitespeed-1.7.8.tgz**

下载链接：https://



下载好了就可以安装了，很简单。

```
tar -zxvf openlitespeed-1.7.8.tgz
cd openlitespeed
./install.sh
```



安装完成后你就可以看到这句话，表明安装成功，就是这么简单。

`[OK] The startup script has been successfully installed!`



别看安装如此简单，实际上它已经完成了95%以上的任务。

根据以往的 `Apache` 或 `Nginx` 等安装经验，我们接下来应该安装 `PHP` 对不对？

其实它已经好好地躺在系统里了，目前最新版本可支持到 `7.4` 及 `8.0` 。





### OpenLiteSpeed 的服务

在 `CentOS` 下， `OLS` 的服务名称为 `lshttpd` ，所以可以这样查看它的服务。

```
systemctl status lshttpd
```



它还有一个别称 `lsws` ，所以也可以这样查看它的服务。

```
systemctl status lsws
```



那么我们就可以随意启动、停止或启用禁用 `OLS` 服务了。

```
# 启动/停止服务
systemctl start lsws
systemctl stop lsws

# 启用/禁用服务
systemctl enable lsws
systemctl disable lsws
```





### OpenLiteSpeed 的各项配置





```
chown -R nobody:nobody storage
chown -R nobody:nobody bootstrap/cache
```

