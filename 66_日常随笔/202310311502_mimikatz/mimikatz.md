mimikatz

副标题：

英文：

关键字：





夜深人静，小猫小狗都睡了，房间里安静得只能听到闹钟“咔咔”的声响。

可是，指针刚走过12点，房间里忽然一前一后窜进两个黑影！

电脑屏幕突然诡异地亮了起来，一个声音打破了房间里的寂静……



“哎，大军哥，咱不是要找环评报告嘛，你摸电脑干啥？”

“嘘……小点声，你是怕别人听不见是吧！我特么当然是找电脑里的资料！你这硕士怎么考上的，充话费送的啊？”



说话的正是刘大军和丁小伟，这俩人都是本校的研究生。

不过，他们跑到冯教授的办公室里到底要做什么呢？



“你赶紧去那边书柜里找找，还有旁边的抽屉里，都看看有没有！”

刘大军指示丁小伟分头行动，可是丁小伟却拿起桌上一个摆件把玩了起来，“哥，你说这电脑咋没关呢，这冯教授也太不懂得节约用电了吧！”

刘大军一皱眉，回头狠狠瞪了一眼这位猪队友：“我早打听过了，冯教授就没有关机的习惯，这不正好，省得我们破解密码了！实在不行还可以重置！”



正在这时，刘大军似乎找到了疑似目标文件夹，写着某某项目相关资料。

可是点击却进不去，提示需要输入密码。

丁小伟一看他先急上了，“这肯定是我们要找的资料，这怎么还要密码呢？”

刘大军没理他，尝试了几次密码未始终没有成功。

他摸了摸下巴，喃喃地说道：“冯教授年事已高，记不住那么多密码，恐怕就是用的开机密码……看来不能轻易重置密码，还是要破解密码……”

丁小伟听完，干脆一拍手，好么，还得靠猜！



说是迟那时快，只见刘大军从兜里掏出一个一寸来长带钛合金镶边儿的U盘，刹那间在屋内烁烁放光、寒气逼人。

丁小伟倒吸了一口冷气：“哥，你拿的是啥玩意，闪瞎我的狗眼了……”

刘大连并不搭话，径直将这块U盘插进电脑，随着噼里啪啦一顿猛操作，屏幕上出现了这样的画面。

图b01



丁小伟瞪大了两只小咪咪眼，张着个大嘴道：“我说哥，这上面难道是密码？”

“当然了！还好这台电脑的系统不算太新……”说着刘大军随手将 `NTLM` 那一项给复制了下来。

紧接着他又打开了一个在线解密网站，将那串看不懂的密钥粘贴了上去。

然后点击解密查询，页面上神奇地出现了明文密码！

图b02



看到这儿，丁小伟立马将摆件轻轻放下，十分吃惊地问刘大军：“这是啥子秘密武器啊！还能这么玩，还能显示登录密码？”

眼前的猪队友实在是太拉胯，一点都指望不上，刘大军也只能数落两句。

“你说你一天天的，就知道刷手机玩游戏，没个正形，你好歹多少也学点有用的啊！”

知道人家家里有矿，只是来混个水硕，刘大军哀其不幸怒其不争，只能压了压怨气，耐着性子给他解释一番……





> https://github.com/gentilkiwi/mimikatz/wiki/module-~-sekurlsa



刚才他用的是一款开源软件 `mimikatz` ，专门用来翻看电脑密码的。

它是以命令行形式运行，通过输入一系列指令来操作。

这款工具软件开发的初衷，是为了找回遗忘的密码，不过由于它的原理是通过访问系统内存数据（比如 `lsass` 进程），因此往往会被杀毒软件视为病毒。



通常使用 `mimikatz` 查看密码需要管理员权限才行。

> When working with `lsass` process, `mimikatz` needs some rights, choice:
>
> - Administrator, to get `debug` privilege via [`privilege::debug`](https://github.com/gentilkiwi/mimikatz/wiki/module-~-privilege#debug) 
> - `SYSTEM` account, via post exploitation tools, scheduled tasks, `psexec -s ...` - in this case `debug` privilege is not needed.
>
> Without rights to access `lsass` process, all commands will fail with an error like this: `ERROR kuhl_m_sekurlsa_acquireLSA ; Handle on memory (0x00000005)` *(except when working with a minidump)*.



那么有两种方式，一种是使用它提供的 `privilege::debug` 命令，还有一种是使用其他方法提升为 `SYSTEM` 账户权限。

否则会收到像 `ERROR kuhl_m_sekurlsa_acquireLSA ; Handle on memory (0x00000005)` 这样失败的错误提示。



想要让 `mimikatz` 正常工作，其前提条件稍显苛刻。

有时默认情况下密码并不存在于内存中，这是出于安全机制考虑。

然而想要让密码出现在内存中，那么需要做些小动作才行。

比如：当域名服务不可达时，`kerberos` 会将密码暂存在内存中。

又比如：注册表中，`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest` 项下， `UseLogonCredential` (DWORD) 的值设定为 `1` ，那么 `wdigest` 会将密码暂存在内存中。

还比如：当  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults` ，或 `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation` 中存在以 `Allow*` 开头的注册项时，`tspkgs/CredSSP`  会保持密码。

当然，这些前提是没有使用 `Credential Guard` 安全防护。

> Starting with Windows 8.x and 10, **by default**, there is no password in memory.
>
> *Exceptions:*
>
> - When DC is/are unreachable, the `kerberos` provider keeps passwords for future negocation ;
> - When `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest`, `UseLogonCredential` (DWORD) is set to `1`, the `wdigest` provider keeps passwords ;
> - When values in `Allow*` in `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults` or `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation`, the `tspkgs` / CredSSP provider keeps passwords.
>
> Of course, not when using *Credential Guard*.



实际操作一下就可以了解它的简单用法。



运行 `mimikatz.exe` ，进入命令提示符状态。

图b05



输入命令 `privilege::debug` ，目的是为了提升一下管理员权限。

```
mimikatz # privilege::debug
Privilege '20' OK
```



当然，如果要记录日志，还可以再来一条命令。

```
mimikatz # log sekurlsa.log
Using 'sekurlsa.log' for logfile : OK
```







但是好像失败了。

图b04



原来 `cmd` 窗口也必须要以管理员权限运行才行。

重新打开命令窗口，再试一次，OK！

图b03



有了权限，我们就可以进一步查看密码了。

输入命令 `sekurlsa::logonpasswords` ，回车！

乖乖，都出来了！

图b01



不过密码有可能不是明文的，而是像 `NTLM` 、`SHA1` 等加密形式。

复制 `NTLM` 密钥，找个在线解密网站，如果密码比较简单，那么它就无处遁行了。

图b02



接着再看，还能看到电脑里保存的访问共享的用户名和密码。

图b06









扫雷游戏作弊

图a01









**mimikatz.7z(3.73M)含可执行文件及源代码**

下载









