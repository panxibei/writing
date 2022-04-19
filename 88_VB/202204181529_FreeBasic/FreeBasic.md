FreeBasic

副标题：

英文：

关键字：





在 `Windows` 上的 `FreeBASIC` 编辑器。



* `FreeBASIC` - 编译器
* `FBE` - 代码编辑器
* `FBX` - 专为 `FreeBASIC` 打造的 `Windows` 框架



特征： 

- 开启 `Unicode` 支持，中文不再乱码。 
- 支持 `32` 位和 `64` 位版本。 
- 高 `DPI` 可感知任何显示器分辨率。 
- 语言本地化，基于 `English.lang` 文件轻松创建语言文件。 
- 本地化支持 11 种语言： 
  - 英语、法语、西班牙语、德语、捷克语、意大利语、中文、俄语、乌克兰语、葡萄牙语、波兰语 
- 基于工程或非工程的编辑。 
- 用于 `GUI` 应用程序开发的内置可视化设计器。 
- 轻松集成基于控制台或 `GUI` 的代码。 
- 增量编译定义为“模块”的代码。 
- 只需指定哪个源代码文件是资源即可轻松包含 `Windows` 资源文件。 
- `FreeBasic` 编译器（`32` 位和 `64` 位）的无缝集成。 
- 代码提示弹出窗口和自动完成。 





```
C:\WinFBE_Suite\Languages
```







### 在 `Ubuntu` 上玩 `FreeBASIC`



##### 安装所需要组件

```
apt-get install gcc
apt-get install libc6-dev 
apt-get install ncurses-dev

/* X11非终端显示情况下需要安装以下几项支持 */ 
apt-get install libx11-dev
apt-get install libxext-dev
apt-get install libxpm-dev
apt-get install libxrandr-dev
apt-get install libxrender-dev

/* 默认安装路径为 /usr/local */
./install.sh -i [安装路径]
```



##### 下载 `Ubuntu` 版本的 `FreeBASIC` 编译器



**FreeBASIC-1.09.0-ubuntu-20.04-x86_64.tar.gz**

下载链接：





##### 新建一个测试文件 `test.bas`

打开你喜欢的文本编辑器，输入以下内容并保存为 `test.bas` 。

```
Screen 13
Print "Welcome to Sysadm.cc!! 网管小贾！！"
SLEEP
END
```

图g01



##### 编译 `test.bas` 文件

很简单，只要指明编译器路径，并不用带任何参数即可。

```
# 当前目录下
fbc test.bas

# 指明编译器路径
/usr/local/fbc test.bas

# 加上-v可交互输出编译结果，用于查看错误
fbc -v test.bas
```

图g02



##### 运行编译后程序

我们可以在 `test.bas` 文件同目录下直接找到编译好的程序 `test` ，运行它试试吧！

```
./test
```



不知缺少啥组件，在图形界面下中文会乱码。

图g03



很奇怪的是，在终端下中文却很正常地输出了。

图g04



