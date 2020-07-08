InstallShield静默安装折腾

副标题：



官方用户手册

>### Running Installations in Silent Mode
>
>Silent installations are installations that run without an end-user interface. If you want your installation to run silently, InstallShield allows you to create silent installations for Basic MSI, InstallScript MSI, and InstallScript project types.
>
>##### Basic MSI Silent Installations
>
>To run a Basic MSI installation silently, type the following at the command line:
>
>`msiexec /i Product.msi /qn`
>
>If your release settings include Setup.exe, you can run the following command:
>
>`Setup.exe /s /v"/qn"`
>
>Basic MSI installations do not create or read response files. To set installation properties for a Basic MSI project, run a command line such as:
>
>`msiexec /i Product.msi /qn INSTALLDIR=D:\ProductFolder USERNAME="Valued Customer"`







###### 1、网上找的表述问题多多。

>  安装包参数获取 `/?` 或是 `/HELP`

我去，根本没有安装参数信息显示啊！



> 安装完毕后，打开 `C:\windows` 目录找到 `setup.iss` 文件

直接安装，没有找到 `setup.iss` 。

我是小白，很傻很天真，事后才知道这样是不会生成 `setup.iss` 文件的。

那怎么才会有？接着看下去。



> 使用 `-R` 参数(即record) 运行安装程序

一时没有明白record的含义，遂

```shell
# 这是错误方法
setup.exe /r /f1"setup.iss"
```

提示错误：Unable to write to repsonse file

图1



翻译成人话就是，无法写入响应文件，请确保有足够空间。

怎么回事，为什么人话我也看不懂，我的空间明明很充足啊！



不断地查找，发现有网友似乎也遇到类似的问题。

如下图，没有生成 `setup.iss` 文件。

图2



其他网友给出了一些看法，建议加上 `f1` 参数。

图3



最后折腾得不行了，才发现 `setup.iss` 应该加上绝对路径。

**原来 `/r` 这个开关是用来录制安装过程，生成 `setup.iss` 文件以备静默安装使用。**

```shell
# setup.iss必须加上了绝对路径才正确
setup.exe /r /f1"c:\foo\setup.iss"
```



真是三尸神暴跳，气炸连肝肺！

这里有个很搞的问题，如果加了上 `f1` 参数，那么在 `C:\Windows` 下是找不到 `setup.iss` 的。

它去哪儿了？

其实应该是 `setup.exe /r` 这个样子，后面加个参数 `r` 就完了。

你说搞不搞，网上写得也是不明不白！



###### 2、总结一下吧，让小伙伴们少起弯路。**

```shell
# 在C:\Windows下可找到setup.iss
setup.exe /r

# setup.iss必须加上了绝对路径才正确
setup.exe /r /f1"c:\foo\setup.iss"
```



###### 3、搞清楚上面的问题，静默安装就简单了。

```shell
# 1. start /wait 等待程序运行完毕再执行接下来的程序
# 2. setup.exe、setup.iss和setup.log的文件名可以随意指定
# 3. 参数f2如果不指定，日志文件默认产生在setup.exe的当前目录中
start /wait setup.exe /s /f1"c:\foo\setup.iss" /f2"c:\foo\setup.log"
```

补充一点：`f1` 参数中的路径似乎不支持共享形式的路径，如：`\\server\foo` 。

临时解决方法是，先把 `setup.iss` 复制到本地，再引用本地的 `setup.iss` 即可。











>