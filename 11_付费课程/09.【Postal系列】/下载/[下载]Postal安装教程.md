

Postal安装教程

副标题：

英文：

关键字：























## 先决条件

在安装 `Postal` 之前，您需要执行一些操作。



### 服务器

我们**强烈**建议将 `Postal` 安装在其自己的专用服务器（即不运行其他软件的服务器）上。

`Postal` 的最低配置要求如下：

- 至少 `4GB` 内存
- 至少 `2` 个 `CPU` 内核
- 适合您的使用案例的磁盘空间量（至少 `25GB` ）



大多数人在虚拟服务器上安装 `Postal` 。

有很多提供商可供选择，包括 `Digital Ocean` 和 `Linode` 。



需要注意的一件事是，您需要确保提供商不会阻止端口 `25` 出站。

这很常见，用于防止垃圾邮件发送者的滥用。



您选择什么操作系统并不重要，只要您能够在其上安装 `Docker`（见下一节）。

这些说明中的任何内容都不会对您的操作系统做出可预见的影响。



### Docker

`Postal` 完全使用容器运行，这意味着要运行 `Postal` ，您需要一些软件来运行这些容器。

为此，我们建议使用 `Docker` ，但您可以使用任何您想要的软件。



首先，您需要在服务器上安装 `Docker` 引擎。

按照 Docker 网站上的说明安装 Docker。

您还需要确保已安装 `Docker` `Compose` 插件。

在继续操作之前，请确保可以同时运行 `docker` 和 `docker compose` 。

图b01









### 系统实用程序

在运行某些 `Postal` 命令之前，您需要安装一些系统实用程序。



在 `Ubuntu/Debian` 上：

```
apt install git curl jq
```



在 `CentOS/RHEL` 上：

```
yum install git curl jq
```



图b02



查看一下各自的版本。

图b03





### Git & 安装助手存储库

您需要确保 `git` 已安装在服务器上。

然后，您需要克隆 `Postal` 安装助手程序存储库。

这包含一些引导配置和其他有用的东西，这些东西将加快您的安装速度。

```
git clone https://github.com/postalserver/install /opt/postal/install
sudo ln -s /opt/postal/install/bin/postal /usr/bin/postal
```



如果拉取失败，有可能是目标目录不存在的原因。

图b04



创建目标目录，然后再拉取一次就OK了。

图b05



建立软链接，方便调用 `postal` 命令。

图b06





### MariaDB（10.6 或更高版本）

`Postal` 需要一个数据库引擎来存储所有电子邮件和其他基本配置数据。

您需要提供凭据，以允许创建和删除数据库的完全访问权限，以及对创建的任何数据库具有完全访问权限。

`Postal` 将为您创建的每个邮件服务器自动配置一个数据库。



我们不支持使用 `MySQL` 来代替 `MariaDB` 。



假设您有 `Docker` ，您可以使用以下命令在容器中运行 `MariaDB` ：

```
docker run -d \
   --name postal-mariadb \
   -p 127.0.0.1:3306:3306 \
   --restart always \
   -e MARIADB_DATABASE=postal \
   -e MARIADB_ROOT_PASSWORD=postal \
   mariadb
```

图b07



- 这将运行一个 `MariaDB` 实例，并让它侦听端口 `3306` 。

- 请务必选择安全密码。

  安装时，您需要将其放入您的 `Postal` 配置中，因此请务必（安全）记下它。

- 如果您无法或不愿意授予 `root` 访问权限，则您单独创建的数据库用户需要对名为 `postal` 和 `postal-*` （可以在配置  `message_db` 部分中配置此前缀）赋予数据库的所有权限。

```
虽然您可以根据需要配置最大消息尺寸，但您需要验证 MariaDB 配置的 innodb_log_file_size 至少是您希望发送的最大消息的10倍（15MB电子邮件为150MB，25MB电子邮件为250MB，诸如此类）。

如果您有旧版v1数据库，您可能还需要检查数据库中的原始表是否具有 LONGBLOB 类型。
```



查看一下是否正在运行。

图b08





## 安装

完成所有先决条件后，可以继续安装 `Postal` 。



### 配置

在启动 `Postal` 之前，需要进行一些配置。

克隆的存储库包含一个用于自动生成一些初始配置文件的工具。



运行以下命令，并替换 `postal.yourdomain.com` 为您要访问 `Postal` `Web` 界面的实际主机名。

在继续操作之前，请确保您已通过 `DNS` 提供商设置此域。

```bash
postal bootstrap postal.yourdomain.com
```

图b09





这将在 `/opt/postal/config` 中生成三个文件。

- `postal.yml` 是 `Postal` 主配置文件
- `signing.key` 是用于在 `Postal` 中签署各种事物的私钥
- `Caddyfile` 是 `Caddy` `Web` 服务器的配置



以上文件一旦生成后，您应该打开 `/opt/postal/config/postal.yml` 并添加所有适当的安装值（比如数据库密码等）。

图b10



```
请注意，docker 设置挂载 /opt/postal/config 为 /config ，因此 postal.yml 中提到的任何完整目录路径都可能需要以 /config 开头，而不是以 /opt/postal/config 开头。
```



### 初始化数据库

添加配置后，需要通过添加所有适当的表来初始化数据库。

运行以下命令以创建架构，然后创建第一个管理员用户。

```bash
postal initialize
postal make-user
```

图b11

图b12

图b13

图b14





### 运行 Postal

您现在已准备好实际运行 `Postal` 本身。

您可以通过运行以下命令来继续执行此操作：

```
postal start
```

图b15



这将在您的计算机上运行多个容器。

您可以使用 `postal status` 来查看这些组件的详细信息。

图b16



### Caddy

要处理 `SSL` 终端和所有 `Web` 流量，您需要配置 `Web` 代理。

您可以在这里使用任何你喜欢的东西 - `nginx` ， `Apache` ， `HAProxy` ，任何东西 - 但在这个例子中，我们将使用 `Caddy` 。

这是一个很棒的小型服务器，需要很少的配置并且非常容易设置。

```
docker run -d \
   --name postal-caddy \
   --restart always \
   --network host \
   -v /opt/postal/config/Caddyfile:/etc/caddy/Caddyfile \
   -v /opt/postal/caddy-data:/data \
   caddy
```

图b17



一旦开始，`Caddy` 将为您的域颁发 `SSL` 证书，您将能够立即访问 `Postal` `Web` 界面并使用您在前面步骤之一中创建的用户登录。

![](../01.JPG)









基本操作



登录 `Web` 页面，输入前面创建的管理员和密码。

图c01



可以点击设置 `My Settings` 来修改管理员的一些信息，比如密码。

图c03



一开始需要创建组织。

图c02



创建完组织，还要创建邮件服务器，用于管理。

图c04

图c08



接着邮件服务器要有相应的域名。

图c05

图c11



一个组织里可以放好几个邮件服务器。

如果你不想要这个组织，也可以随时删除它。

图c07



创建完邮件服务器。

图c09



随时都可以点击 `Send Message` 来测试邮件发送。

图c12



指定好发件人和收件人，以及主题和内容，点击 `Send Message` 按钮。

图c13



如果配置不正确，有可能会收到错误信息，比如 `SOFT FAIL` （软拒绝）。

图c14



类似问题的原因可能有很多，其中有一个原因可能是 `SMTP` 认证未能通过。

那么我们就要到 `Credentials` 一项中设定认证，否则验证不通过是无法正常发送邮件的。

图c15

图c16



用 `Telnet` 方式来测试一下 `postal` 是否正常工作。

图c17



正常设定了 `SMTP` 认证，那么验证登录时才能顺利通过。

比如前面 `Credentials` 中设定了这样一组认证：

```
admin
uM1S53njHjXJwSzpFGA8ltNr
```

那么在登录 `auth login` 输入验证信息时，应该输入前者的 `Base64` 编码。

```
YWRtaW4=
dU0xUzUzbmpIalhKd1N6cEZHQThsdE5y
```

图c18



验证通过后，输入发件人和收件人，并输入主题和内容即可发送测试邮件。

图c19



因为是测试环境，我并没有完善一些配置，因此无法截取成功发送的截图，请见谅！





















