Composer 遭遇 Out of memory 错误的另一种可能

副标题：





遭遇错误。

说是 `php.ini` 的问题，遂找到 `php.ini` 文件并对其进行查找编辑。

发现如下已经分配了不小的内存。

不够用？也太贪了吧！

```
; Maximum amount of memory a script may consume (128MB)
; http://php.net/memory-limit
memory_limit = 512M
```



再仔细瞧瞧这错误提示，发现 `Composer` 被提示版本过低。

图2



官网一查，果然成了老爷货，眼看要过期，赶紧升级吧。

升级命令：

```
# 官网说后面还要加个 --2 ，可我尝试过不行
composer self-update
```

查看版本：

```
composer -V
```

图3



成功升级到 `2.0` ！

赶快试试还有没有问题了。

再试着安装，发现问题已经被顺利解决了！

你看这问题闹的，根本就不是 `PHP` 的问题啊！

图4



**关注@网管小贾，阅读更多**

网管小贾的博客 | www.sysadm.cc

