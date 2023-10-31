mimikatz

副标题：

英文：

关键字：







管理员密码破解查看





扫雷游戏作弊





 This module extracts **passwords**, **keys**, **pin codes**, **tickets** from the memory of `lsass` (`Local Security Authority Subsystem Service`)
 *the process by default, or a minidump of it!* (see: [howto ~ get passwords by memory dump](https://github.com/gentilkiwi/mimikatz/wiki/howto-~-get-passwords-by-memory-dump) for minidump or other dumps instructions) 



When working with `lsass` process, `mimikatz` needs some rights, choice:

- Administrator, to get `debug` privilege via [`privilege::debug`](https://github.com/gentilkiwi/mimikatz/wiki/module-~-privilege#debug) 
-  `SYSTEM` account, via post exploitation tools, scheduled tasks, `psexec -s ...` - in this case `debug` privilege is not needed.

Without rights to access `lsass` process, all commands will fail with an error like this: `ERROR kuhl_m_sekurlsa_acquireLSA ; Handle on memory (0x00000005)` *(except when working with a minidump)*.





```
mimikatz # privilege::debug
Privilege '20' OK

mimikatz # log sekurlsa.log
Using 'sekurlsa.log' for logfile : OK
```







> https://github.com/gentilkiwi/mimikatz/wiki/module-~-sekurlsa



Starting with Windows 8.x and 10, **by default**, there is no password in memory.

*Exceptions:*

- When DC is/are unreachable, the `kerberos` provider keeps passwords for future negocation ;
- When `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest`, `UseLogonCredential` (DWORD) is set to `1`, the `wdigest` provider keeps passwords ;
- When values in `Allow*` in `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults` or `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation`, the `tspkgs` / CredSSP provider keeps passwords.

Of course, not when using *Credential Guard*.