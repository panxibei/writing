MRTG一款小白最爱的系统网络监控神器二（高级篇）

副标题：小白神器，简单实用~~



上文书《MRTG一款小白最爱的系统网络监控神器一（初级篇）》，我们介绍了 `MRTG` 的安装和简单的使用方法。

但是这些方法只能简单地监控网络浏览，要想应用于更复杂一些的场景，就需要我们定制高级配置了。

本章会涉及到如下配置设定的说明，先来个概览：

* 监控CPU、内存和硬盘
* 监控交换机、打印机等网络设备
* 自动化抓取流量数据
* `MRTG` 自动配置生成及多设备自定义页面模板制作

其中，自动配置生成是我通过收集整理各个命令步骤后做成的自动批处理程序，文末有下载。

自定义页面模板也是一样，方便以后添加各项设备，下载链接也放在文章最后。



好，闲言碎语不要讲，先表一表如何监控三大金刚：CPU、内存和硬盘。

在说这三大金刚之前，我们先来简单介绍一款工具 `iReasoning MIB Browser` 。

用它来查 `snmp` 信息非常方便，因为我们要用它来找设备的 `OID`。

按照老习惯，省得你找了，给出下载链接：



#### 一、设置监控CPU的配置

1、下载后安装打开 `iReasoning MIB Browser` ，我们先来查找CPU的OID。

1. 在 `Address` 中输入设备的IP地址，点击右边的 `Go` 。
2. 在左侧依次展开 `host` >`hrDevice` > `hrProcessorTable` > `hrProcessorLoad` 。
3. 双击 `hrProcessorLoad` ，右侧表格中相应CPU核数的信息，`Value` 为 当前负载。

从下图中可以得出我们想要的结果，即两个CPU内核的 `OID` 分别为 `.1.3.6.1.2.1.25.3.3.1.2.4` 和 `.1.3.6.1.2.1.25.3.3.1.2.5` ，当前负载均为4。

图1



2、配置文件参考。

这里设定显示两个CPU内核的负载情况。

如果你想要取平均值或更多内核时，可以修改 `Target` 参数。

平均值可以这样设定：

`(.1.3.6.1.2.1.25.3.3.1.2.4:public@192.168.1.99 + .1.3.6.1.2.1.25.3.3.1.2.5:public@192.168.1.99) / 2`

```ini
# CPU监控配置
# mrtg_cpu.cfg

RunAsDaemon: yes
Interval: 5
WorkDir: c:\wamp64\www\mrtg

Target[cpu]:.1.3.6.1.2.1.25.3.3.1.2.4&.1.3.6.1.2.1.25.3.3.1.2.5:public@192.168.1.99
MaxBytes[cpu]: 100
Options[cpu]: gauge, absolute, growright, noinfo, nopercent
YLegend[cpu]: CPU Load (%)
ShortLegend[cpu]: %
Legend1[cpu]: CPU core1 use in percent
Legend2[cpu]: CPU core2 use in percent
LegendI[cpu]: CPU core1 use in percent
LegendO[cpu]: CPU core2 use in percent
Title[cpu]: CPU Load Performance
PageTop[cpu]: <H1>CPU Load Performance</H1>
```



3、运行测试命令。

```shell
cd c:\mrtg\bin
perl mrtg c:\wamp64\www\mrtg\mrtg_cpu.cfg
```



4、打开测试网页。

```shell
http://localhost/mrtg/cpu.html
```

如果命令控制台上没有特别的错误，可能需要观察等待5分钟以上图形才可能有变化。



#### 二、设置监控内存和硬盘的配置

内存和硬盘为啥在放一起讲呢？因为它们是在一块儿的，往下看~

1、和CPU配置一样，先查查OID。

1. 依次展开 `iReasoning MIB Browser` 的 `host` > `hrStorage` > `hrStorageTable` > `hrStorageEntry` 。

2. 分别双击 `hrStorageAllocationUnit` 、 `hrStorageSize` 和 `hrStorageUsed` 三项。

   它们分别表示：分配单元（簇）、总容量和已使用容量。

3. 以上这三项在右侧表格信息中，第一项为C盘、第二项为D盘，以此类推。

   最后第二项为虚拟内存，最后一项为物理内存。

4. 这三项它们之间的关系是，`实际总容量 = 分配单元 * 总容量`，`实际已使用容量 = 分配单元格 * 已使用容量`。

图2

图3

图4



2、配置文件参考。

```ini
# 内存监控配置
# mrtg_memory.cfg

RunAsDaemon: yes
Interval: 5
WorkDir: c:\wamp64\www\mrtg

# 内存的分配单元为65536，所以要先乘以65536，然后除以两次1024转换为M单位。
Target[memory]:1.3.6.1.2.1.25.2.3.1.6.4&1.3.6.1.2.1.25.2.3.1.5.4:public@192.168.1.99 * 65536 / 1024 / 1024
MaxBytes[memory]: 2048
Title[memory]: Memory usage (RigolBuckUp)
PageTop[memory]: <H1>Memory (RigolBuckUp)</H1>
kMG[memory]: M,G,T,P,X
YLegend[memory]: Memory
ShortLegend[memory]: bytes
Legend1[memory]: Commited Memory
Legend2[memory]: Total Memory
LegendI[memory]: Memory Used
LegendO[memory]: Memory Total
Options[memory]: growright,nopercent,gauge
```



```ini
# 硬盘监控配置
# mrtg_disk.cfg

RunAsDaemon: yes
Interval: 5
workdir: c:\wamp64\www\mrtg

# 磁盘的分配单元为4096，所以要先乘以4096，然后除以两次1024转换为M单位。
Target[disk]:1.3.6.1.2.1.25.2.3.1.6.1&1.3.6.1.2.1.25.2.3.1.5.1:public@192.168.1.99 * 4096 / 1024 / 1024
MaxBytes[disk]: 50633
Title[disk]: DISK C:
PageTop[disk]: <H1>DISK C:</H1>
kMG[disk]: M,G,T,P,X
YLegend[disk]: hdd
ShortLegend[disk]: bytes
Legend1[disk]: Used Disk
Legend2[disk]: Total Disk
LegendI[disk]: Disk Used
LegendO[disk]: Disk Total
Options[disk]: growright,nopercent,gauge
```



3、运行测试命令。

```shell
cd c:\mrtg\bin
perl mrtg c:\wamp64\www\mrtg\mrtg_memory.cfg
perl mrtg c:\wamp64\www\mrtg\mrtg_disk.cfg
```



4、打开测试网页。

```shell
http://localhost/mrtg/memory.html
http://localhost/mrtg/disk.html
```

如果命令控制台上没有特别的错误，可能需要观察等待5分钟以上图形才可能有变化。



#### 三、监控交换机、打印机等网络设备

这里我们只拿打印机做试验，其他设备大同小异。

1、首先开启设备的SNMP。

可以通过图形设定界面，也可以通过CLI命令控制台，需要参考具体设备的设置方法。

图形界面参考：

图5

图6



CLI命令控制台参考：

```shell
snmp-servercommunity public RO
snmp-serverhost x.x.x.x public
snmp-serverenable traps
snmp-servertrap-source Vlan1
```



2、生成配置文件

```powershell
md c:\wamp64\www\device
perl cfgmaker public@x.x.x.x --global "workdir: c:\wamp64\www\device" --output c:\wamp64\www\device\device.cfg
```



3、修改配置文件

把上述 `device.cfg` 用文本编辑器打开，在**最开头**添加以下几行内容。

```
RunAsDaemon: yes
Interval: 5
Options[_]: growright, bits
```

然后，把删除包含 `Loopback` 和 `USB` 等内容的部分，只保留主网卡（通常是第一项）的那部分内容，保存后关闭文件。



4、开始监控测试

```
cd c:\mrtg\bin
perl mrtg c:\wamp64\www\device\device.cfg
```

打开网页 `http://127.0.0.1/device/xxxxxx.html` ，`xxxxxx` 通常是Target后面方括号中的内容。

按照配置文件的设定，每间隔5分钟页面会自动刷新流量监控。



#### 三、自动化抓取流量数据

一般情况下，我们在配置文件中添加 `RunAsDaemon: yes` 参数，然后执行监控命令后会自动抓取数据而不会停止。

但这种情况有一些不足，比如窗口不能关闭，否则程序就退出了，比如需要用户事先登录到系统中手动执行。

所以为了实现自动化，我们最好把它做成服务程序。

我们要用到一个工具：srvany.zip 密码：

下载解压后可以看到有两个文件，分别是 `instsrv.exe` 和 `srvany.exe` 。

第一个是安装服务用的，第二个是运行服务用的。

把它们复制到 `c:\mrtg\bin` 下。



1、安装服务项，可以这样：

```
# 需要管理员权限
instsrv MRTG c:\mrtg\bin\srvany.exe
```

2、导入注册表（注意其中的路径）：

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MRTG\Parameters]
"Application"="c:\\perl64\\bin\\wperl.exe"
"AppParameters"="c:\\mrtg\\bin\\mrtg --logging=eventlog c:\\mrtg\\bin\\mrtg.cfg"
"AppDirectory"="c:\\mrtg\\bin\\"
```



就这样，服务安装好了。

到 `计算机管理` > `服务` 中查看，会看到有新的名称为 `MRTG` 的服务生成。

当然了，服务名称是可以修改的，只要把导入的注册表项 `MRTG` 改成你想要的就行了，比如：

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MRTG_192_168_1_99\Parameters]`



#### 四、`MRTG` 自动配置生成及多设备自定义页面模板制作

##### 1、自动配置程序

手动配置总归有些累，时间管理很重要，如果有很多很多的设备需要设置，很累人啊！

OK，我总结整理了一些批处理程序，用于减轻手工劳动（文末下载）。

请注意，我没有采用命令输入参数的形式，而是在文件中直接修改参数，而后执行。

1-1、配置生成

```powershell
:: 生成mrtg配置文件

set strIP=x.x.x.x
:: 下面这个团体一般是public
set strComminuty=public
set strPath=x_x_x_x
set strCfgFilename=mrtg_x_x_x_x.cfg

mkdir c:\wamp\www\%strPath%
start /b /w perl cfgmaker %strComminuty%@%strIP% --global "WorkDir: c:\wamp\www\%strPath%" --output %strCfgFilename%

:: 别忘记添加 RunAsDaemon: yes
echo Options[_]: growright, bits>> %CD%\tmp1.txt
echo RunAsDaemon: yes>> %CD%\tmp1.txt
type %strCfgFilename% >> %CD%\tmp1.txt

del /f /q %CD%\%strCfgFilename%

rename %CD%\tmp1.txt %strCfgFilename%

pause
```

1-2、生成页面文件

```powershell
:: 注意，output后面接路径。index.html的文件名可以是其他名字（例如设备的名字）
:: mrtg.cfg文件名可修改为实际对应设备的配置文件名

set strPath=x_x_x_x
set strCfgFilename=mrtg_x_x_x_x.cfg

del /F /S /Q c:\wamp64\www\%strPath%\*.*

perl indexmaker --output=c:\wamp64\www\%strPath%\index.html %strCfgFilename% --columns=1

:: start /Dc:\mrtg\bin wperl mrtg --logging=eventlog %strCfgFilename%

pause
```

1-3、安装服务

```powershell
:: 安装服务（需要管理员权限）

set strServiceName=MRTG_x_x_x_x
set strSrvanyPath=c:\mrtg\bin
set strSrvanyPathReg=c:\\mrtg\\bin

%strSrvanyPath%\instsrv %strServiceName% %strSrvanyPath%\srvany.exe

:: 手动导入以下注册表内容
:: ============================================
:: Windows Registry Editor Version 5.00
:: 
:: [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MRTG_x_x_x_x\Parameters]
:: "Application"="c:\\perl64\\bin\\wperl.exe"
:: "AppParameters"="c:\\mrtg\\bin\\mrtg --logging=eventlog c:\\mrtg\\bin\\mrtg_x_x_x_x.cfg"
:: "AppDirectory"="c:\\mrtg\\bin\\"
:: ============================================

echo Windows Registry Editor Version 5.00>>%strSrvanyPath%\%strServiceName%.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\%strServiceName%\Parameters]>>%strSrvanyPath%\%strServiceName%.reg
echo "Application"="c:\\perl64\\bin\\wperl.exe">>%strSrvanyPath%\%strServiceName%.reg
echo "AppParameters"="%strSrvanyPathReg%\\mrtg --logging=eventlog %strSrvanyPathReg%\\%strServiceName%.cfg">>%strSrvanyPath%\%strServiceName%.reg
echo "AppDirectory"="%strSrvanyPathReg%\\">>%strSrvanyPath%\%strServiceName%.reg

reg import %strSrvanyPath%\%strServiceName%.reg /reg:64

pause
```



总结如下，直接点击下载。

1. cfgMaker.bat ------------ 生成配置文件
2. indexMaker.bat ---------- 生成页面文件
3. instsrv.bat ------------- 安装服务
4. doAll.bat ------------- 整合以上三项一次搞定

注意，安装服务需要管理员权限，所以第3项和第4项应该以管理员权限方式运行。



##### 2、PERL脚本的修改

由于使用官方的PERL脚本生成的配置标题会产生网络适配器名称加数字这样的内容。

如：`192_168_1_99_1` 。

我虽然不是强迫症，但看着挺难受的，于是帮它改成直接是网络适配器的名称。

```
# MRTG的PERL脚本部分修改

1.cfgmaker文件
修改标题内容为包含网络适配器的名称，而不是单纯的数字

第749行：
"PageTop[$target_name]: <h1>$html_desc_prefix$html_if_title_desc -- $sysname</h1>

修改为：
"PageTop[$target_name]: <h1>$html_desc_prefix$html_if_description -- $sysname</h1>


2.indexmaker
556行，修改页面底下的相关信息（如联系邮箱等）。
```

`cfgMaker` 修改版 链接：密码：

`indexMaker` 修改版 链接：密码：



##### 3、自定义页面模板







