mimikatz

副标题：

英文：

关键字：



> https://github.com/gentilkiwi/mimikatz/wiki/module-~-sekurlsa



管理员密码破解查看





> Starting with Windows 8.x and 10, **by default**, there is no password in memory.
>
> *Exceptions:*
>
> - When DC is/are unreachable, the `kerberos` provider keeps passwords for future negocation ;
> - When `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest`, `UseLogonCredential` (DWORD) is set to `1`, the `wdigest` provider keeps passwords ;
> - When values in `Allow*` in `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults` or `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation`, the `tspkgs` / CredSSP provider keeps passwords.
>
> Of course, not when using *Credential Guard*.







> When working with `lsass` process, `mimikatz` needs some rights, choice:
>
> - Administrator, to get `debug` privilege via [`privilege::debug`](https://github.com/gentilkiwi/mimikatz/wiki/module-~-privilege#debug) 
> - `SYSTEM` account, via post exploitation tools, scheduled tasks, `psexec -s ...` - in this case `debug` privilege is not needed.
>
> Without rights to access `lsass` process, all commands will fail with an error like this: `ERROR kuhl_m_sekurlsa_acquireLSA ; Handle on memory (0x00000005)` *(except when working with a minidump)*.







支行 `mimikatz.exe` ，进入命令提示符状态。

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









