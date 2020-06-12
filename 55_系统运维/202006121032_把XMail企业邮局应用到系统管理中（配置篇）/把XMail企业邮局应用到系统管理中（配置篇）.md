把XMail企业邮局应用到系统管理中（配置篇）

副标题：简单易用才是应用之道~



上文书我们说到XMail是如何安装的，其中给小伙伴们分享了我自制的一键安装程序包。

>  前文链接：[把XMail企业邮局应用到系统管理中（安装篇）](https://www.sysadm.cc/index.php/xitongyunwei/743-xmail-install)
>
> **<一键安装 `XMail` 程序包>** 下载请到前文中查找~



程序安装好后，默认的设置是没办法直接使用的，那么自然要我们动手配置它了。

我们先来认识一下 `XMail` 的几个工具程序：

1. `C:\MailRoot\bin\CtrlClnt.exe` ，主要系统管理程序
2. `C:\MailRoot\bin\XMCrypt.exe` ，密码加密生成程序

再有几个主要配置文件：

1. `server.tab` ，服务端配置文件
2. `ctrlaccounts.tab` ，管理用户配置文件
3. `mailusers.tab` ，邮件用户配置文件
4. `domains.tab` ，邮局域名配置文件



在正式开始配置之前想说一个注意事项哈。

在编辑配置文件的时候，最好不要用 `Windows` 的记事本程序，因为编码的问题，你最好用一些高级一点文本编辑器，比如 `Notepad++` 等等。



接下来我们开始尝试手动配置 `XMail` ，在此之后我们也会用第三方的工具软件快捷方便地完成配置。



基本步骤像下面这样子走：

##### 1、修改邮局域名

用文本编辑器打开 `C:\MailRoot\server.tab` ，将所有的 `xmailserver.test` 替换成 `sysadm.local` 。

比如：

```
"RootDomain" "xmailserver.test"
"SmtpServerDomain" "xmailserver.test"
"POP3Domain" "xmailserver.test"
"HeloDomain" "xmailserver.test"
"PostMaster" "root@xmailserver.test"
"ErrorsAdmin" "root@xmailserver.test"

替换成：
"RootDomain" "sysadm.local"
"SmtpServerDomain" "sysadm.local"
"POP3Domain" "sysadm.local"
"HeloDomain" "sysadm.local"
"PostMaster" "root@sysadm.local"
"ErrorsAdmin" "root@sysadm.local"
```



##### 2、生成管理员加密密码

```
# adminpass为密码明文，生成密文0401080c0b15041616
C:\MailRoot\bin\XMCrypt.exe adminpass
```



##### 3、添加管理员信息

编辑 `C:\MailRoot\ctrlaccounts.tab` ，添加如下内容：

```
admin	0401080c0b15041616
```

注意：每行格式一定是 **用户名[tab]密码[回车]** 。



##### 4、修改域

```
# 查看域
# 以下会返回测试域信息 "xmailserver.test"
C:\MailRoot\bin\ctrlclnt -s localhost -u admin -p adminpass domainlist

# 删除域
# 删除测试域 "xmailserver.test"
C:\MailRoot\bin\ctrlclnt -s localhost -u admin -p adminpass domaindel xmailserver.test

# 添加域
# 添加我们自定义域 "sysadm.local"
C:\MailRoot\bin\ctrlclnt -s localhost -u admin -p adminpass domainadd sysadm.local
```



##### 5、添加用户

```
# 查看用户
# 返回信息如："sysadm.local" "admin" "adminpass"	"U"，U代表个人用户
C:\MailRoot\bin\ctrlclnt -s localhost -u admin -p adminpass userlist

# 添加用户
# 以下用户名为 floyd，密码为 floydpass
C:\MailRoot\bin\ctrlclnt -s localhost -u admin -p adminpass useradd sysadm.local floyd floydpass U
```

