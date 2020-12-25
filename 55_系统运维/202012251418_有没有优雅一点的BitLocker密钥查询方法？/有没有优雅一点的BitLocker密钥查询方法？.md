有没有优雅一点的BitLocker密钥查询方法？

副标题：





按通常的做法

右击域名，选择“查找BitLocker恢复密码”。

图1



这个界面要输入密码ID前8个字符，喂，什么鬼，我上哪儿去找密码ID去啊？

图2



于是乎想到了必须要把BitLocker密钥导出。

找到老外一篇博文。

https://ndswanson.wordpress.com/2014/10/20/get-bitlocker-recovery-from-active-directory-with-powershell/

看了半天，懵了半天，最后才知道文章的最后面给出了命令，很简单。

```powershell
# 获取你想要查询的计算机对象
> $Computer = Get-ADComputer -Filter {Name -eq 'Hostname'}

# 获取该计算机的所有BitLocker恢复密钥，注意参数 “SearchBase” 
> $BitLockerObjects = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase $Computer.DistinguishedName -Properties 'msFVE-RecoveryPassword'

# 输出结果，打完收工
> $BitLockerObjects
DistinguishedName : CN=2020-10-20T13:10:38-06:00{E59D69FF-6A3B-42A6-89C0-57A0DA0E302A},CN=xjpc01,OU=swCompute
rs,DC=sysadm,DC=cc
msFVE-RecoveryPassword : 465762-121880-049797-598411-533643-549890-128436-549736
Name : 2020-10-20T13:10:38-06:00{E59D69FF-6A3B-42A6-89C0-57A0DA0E302A}
ObjectClass : msFVE-RecoveryInformation
ObjectGUID : d0a15cc8-5f86-42ed-8942-633cec25b6b1
......
......
```



一共就三条命令啊，试试看。

结果输入第一条命令就挂了。

图3



怎么就挂了呢？

我跑到AD服务器上再试试，没有报错啊？

哦，过了一会儿我回过味儿来了，原来我是在没有安装远程服务管理工具的客户端上执行的命令。

好吧，我先安装一个再来试过。



Windows10远程服务器管理工具，想图个方便就在这儿下载吧，Win10/Win2016都可安装使用哦。

WindowsTH-RSAT_WS2016-x64.msu



说是迟，那时快，一眨眼的功夫我就安装好了远程管理工具。

回过头来，再试试那几条 `PowerShell` 命令，看来是没问题了。

图4



从图中能看到，相应的 `msFVE-RecoveryPassword` 就是传说中的 `BitLocker` 恢复密码。



其实通过 AD 管理工具查找到计算机名称，然后在其属性选项卡中就能看到 `BitLocker` 恢复密码。

图5



相对按密码ID前8位来查询 `BitLocker` 恢复密码，按计算机名称来查找才比较符合人性。

给出的命令也挺简单易用，但是，难道就这么结束了吗？

感觉还可以再优雅，再人性化一点啊！









