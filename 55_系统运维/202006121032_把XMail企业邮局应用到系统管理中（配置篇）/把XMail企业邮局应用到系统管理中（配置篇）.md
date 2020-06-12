把XMail企业邮局应用到系统管理中（配置篇）

副标题：简单易用才是应用之道~



上文书我们初步地说明了 `XMail` 是如何安装的，其中也给小伙伴们分享了我自制的**一键安装XMail程序包**。

>  前文链接：[把XMail企业邮局应用到系统管理中（安装篇）](https://www.sysadm.cc/index.php/xitongyunwei/743-xmail-install)
>
> **<一键安装 `XMail` 程序包>** 免费下载请到前文中查找~

程序安装好后，默认的设置是无法直接使用的，那么自然就要我们先动手配置它了。

`XMail` 的官网文档有几百页纸，但简单基本的配置并不复杂，不要害怕哈，只要做好以下简单的几步就能实现我们想要的基本收发功能了。

Let's go!



#### 一、配置工具和配置文件

我们先来认识一下 `XMail` 的几个工具程序：

1. `C:\MailRoot\bin\CtrlClnt.exe` ，主要系统管理程序
2. `C:\MailRoot\bin\XMCrypt.exe` ，密码加密生成程序



再有几个主要配置文件：

1. `server.tab` ，服务端主配置文件
2. `ctrlaccounts.tab` ，管理用户配置文件
3. `mailusers.tab` ，邮件用户配置文件
4. `domains.tab` ，邮局域名配置文件



在正式开始配置之前先说一个注意事项哈。

在编辑配置文件的时候，最好不要用 `Windows` 的记事本程序，因为编码异常的问题，你最好用一些高级一点文本编辑器，比如 `Notepad++` 等等。



好了，接下来我们开始尝试手动配置 `XMail` ，在此之后有机会的话我们也会用第三方的工具软件快捷方便地完成配置。



#### 二、配置步骤

基本步骤像下面这样子走：

##### 1、修改邮局域名

假定我们测试用的域名为 `sysadm.local` 。

用高级一些的文本编辑器打开 `C:\MailRoot\server.tab` ，将所有的 `xmailserver.test` 替换成 `sysadm.local` 。

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
# adminpass为密码明文，相应生成密文0401080c0b15041616
C:\MailRoot\bin\XMCrypt.exe adminpass
```



##### 3、添加管理员信息

还是用高级一些的文本编辑器编辑 `C:\MailRoot\ctrlaccounts.tab` ，添加如下内容：

```
admin	0401080c0b15041616
```

注意：每行格式一定是 **用户名[tab]密码[回车]** 。



##### 4、修改域

看看以下命令的注释你就明白 了。

```
# 查看域
# 以下会返回域信息，如果是初次则域信息为 "xmailserver.test"
C:\MailRoot\bin\ctrlclnt -s localhost -u admin -p adminpass domainlist

# 删除域
# 删除测试域 "xmailserver.test"
C:\MailRoot\bin\ctrlclnt -s localhost -u admin -p adminpass domaindel xmailserver.test

# 添加域
# 添加我们的自定义域 "sysadm.local"
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



#### 三、测试

OK，好像也不是很复杂哈，邮件域和用户都搞定了！接下来测试看看！



1、域名解析

在客户端电脑（不是 `XMail` 服务器）上，编辑 `C:\Windows\System32\drivers\etc` ，在最后追加：

```
x.x.x.x sysadm.local    # x.x.x.x 是XMail服务器的IP地址
```

友情提示：

* 如果你的客户端能正确解析 `XMail` 服务器的IP，比如通过DNS服务器已经做了解析，那么这一步可以不做。
* 为保证远端客户程序能顺利访问 `XMail` 服务，请确保服务器的防火墙开放了 `25` 和 `110` 这两个端口。



2、邮件客户端程序测试

邮件客户端有很多，使用任意一款支持 `SMTP/POP3` 的就行，我们用常见的 `OUTLOOK` 演示。

基本设置信息：

> 邮件地址：floyd@sysadm.local
>
> 发送邮件（SMTP）：sysadm.local
>
> 接收邮件（POP3）：sysadm.local
>
> 帐号：floyd（或者是全名floyd@sysadm.local）
>
> 密码：floydpass



打开 `OUTLOOK` ，找到 `帐户设置` > `电子邮件` > `新建` 。

图1



在出现窗口的电子邮件地址一栏填入 `floyd@sysadm.local` ，同时勾选 `让我手动设置我的帐户` ，并点击连接。

图2



在高级设置界面选择 `POP` 方式。

图3



`POP` 帐户设置中，**接收邮件服务器**和**待发邮件服务器**都填写 `sysadm.local` ，点击下一步。

图4



输入 `floyd@sysadm.local` 用户的密码。

图5



`OUTLOOK` 经过一番折腾后宣布成功添加了帐户。

图6



用这个邮箱给自己发送一封测试邮件，发送成功的同时，自己也能收到邮件，那么说明配置测试成功完成！

以上测试环节可能会有些折腾，你也可以同时使用 `telnet` 命令辅助测试，先确保端口可以访问。



嗯，下课时间马上要到了，今天就写这些吧。

毕竟手动配置太累，如果有时间有机会的话，以后会补充通过第三方程序来配置 `XMail` 的方法。

当然，官网文档中还有写到与 `XMail` 通讯的方法和指令，第三方程序的原理正是基于这些方法。

另外我们还可以自己动手用VB编写开发自己想要的更多的便捷配置功能。

好了，我又要回去搬砖了，那才是我的工作，要不会被老板骂不务正业了！

小伙伴们有空关注一下我的微信公众号吧，感谢！

我们下期再见啦！



> WeChat @网管小贾
>
> Blog @www.sysadm.cc





