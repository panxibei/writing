MRTG一款小白最爱的系统网络监控神器二（高级篇）

副标题：小白神器，简单实用~~



上文书《MRTG一款小白最爱的系统网络监控神器一（初级篇）》，我们介绍了 `MRTG` 的安装和简单的使用方法。

但是这些方法只能简单地监控网络浏览，要想应用于更复杂一些的场景，就需要我们定制高级配置了。

本章会涉及到如下配置设定的说明，先来个概览：

* 监控CPU、内存和硬盘
* 监控交换机、打印机等网络设备
* `MRTG` 自动配置生成及多设备自定义页面模板制作
* 自动化抓取流量数据

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



