

一款没有邮箱的经典邮件服务器：Postal

副标题：一款没有邮箱的经典邮件服务器：Postal

英文：a-classic-mail-server-without-emaill-accounts-postal

关键字：postal,mail,email,smtp,pop,邮件,邮箱,电子邮件,server,docker





前不久 `Postal` 开源了！

`Postal` 是个啥？

简单地说，它是一个邮件服务器，但是与其他同类产品不同的是，它没有邮箱管理功能。

也就是说，`Postal` 里面没有设置某某账号对应某某邮箱，它只是用来发送邮件的。

你可以简单地理解为它是一个邮局，它不管谁是谁，它只管收发邮件。



据说 `Postal` 功能非常强大，支持的特性非常丰富，包括邮件图表统计、垃圾邮件及病毒检查等等。

我也是初次接触它，因此我们先来看看最基本的一些内容，比如它是如何安装的吧！



在安装 `Postal` 之前，我们需要了解一些信息，然后再做一些准备工作。

官方强烈建议将 `Postal` 安装在自己的专用服务器（即不运行其他软件的服务器）上。

此外 `Postal` 的最低配置要求如下：

- 至少 `4GB` 内存
- 至少 `2` 个 `CPU` 内核
- 适合实际使用情况的磁盘空间量（至少 `25GB` ）



需要注意的一件事是，需要确保设定中不会阻止端口 `25` 出站。

通常这是用于防止垃圾邮件发送者的滥用。

至于选择什么操作系统其实并不重要，只要能够跑 `Docker` 即可。

可以放心的是，后续中的任何内容都不会对操作系统做出可预见的影响。



`Postal` 完全使用容器运行，这意味着要运行 `Postal` ，我们需要一些软件来运行这些容器。

为此，官方建议使用 `Docker` 容器，但您可以使用任何您想要的其它软件。



首先，我们需要在服务器上安装 `Docker` 引擎。

按照 `Docker` 网站上的说明安装 `Docker` ，还需要确保已安装 `Docker` `Compose` 插件。

在继续操作之前，请确保可以同时运行 `docker` 和 `docker compose` 。

图01



有了 `Docker` ，在运行某些 `Postal` 命令之前，我们还需要安装一些系统实用程序。

在 `Ubuntu/Debian` 上：

```
apt install git curl jq
```

在 `CentOS/RHEL` 上：

```
yum install git curl jq
```

图02



检查一下各自的版本，看看是不是正常输出了信息。

图03



刚才我们安装了 `git` ，接下来我们需要克隆 `Postal` 安装助手程序存储库。

这包含一些引导配置和其他有用的东西，这些东西将加快安装速度。

```
git clone https://github.com/postalserver/install /opt/postal/install
```



如果拉取失败，有可能是目标目录不存在的原因。

图04



创建目标目录，然后再拉取一次就OK了。

图05



```
sudo ln -s /opt/postal/install/bin/postal /usr/bin/postal
```

建立软链接，方便调用 `postal` 命令。

图06



`Postal` 需要一个数据库引擎来存储所有电子邮件和其他基本配置数据。

克隆拉取完程序存储库后，我们就要来创建一个数据库引擎。

我们需要提供凭据，以允许创建和删除数据库的完全访问权限，以及对创建的任何数据库具有完全访问权限。

`Postal` 将为我们创建的每个邮件服务器自动配置一个数据库。

`Postal` 官方不建议使用 `MySQL` 而建议使用 `MariaDB` 。



这时我们就用到了 `Docker` ，可以使用以下命令在容器中运行 `MariaDB` ：

```
docker run -d \
   --name postal-mariadb \
   -p 127.0.0.1:3306:3306 \
   --restart always \
   -e MARIADB_DATABASE=postal \
   -e MARIADB_ROOT_PASSWORD=postal \
   mariadb
```

图07



有几点需要注意：

- 这将运行一个 `MariaDB` 实例，并让它侦听端口 `3306` 。

- 请务必选择安全密码。

  安装时，密码需要将其放入 `Postal` 配置中，因此请务必（安全）记下它。

- 如果无法或不愿意授予 `root` 访问权限，则单独创建的数据库用户需要对名为 `postal` 和 `postal-*` （可以在配置  `message_db` 部分中配置此前缀）赋予数据库的所有权限。



查看一下是否正在运行。

图08



完成所有先决条件后，我们就可以继续安装 `Postal` 了。

当然了，在启动 `Postal` 之前，还是需要进行一些配置。



克隆的存储库包含一个用于自动生成一些初始配置文件的工具。

运行以下命令，并替换 `postal.yourdomain.com` 为您要访问 `Postal` `Web` 界面的实际主机名。

在继续操作之前，请确保已通过 `DNS` 提供商设置此域。

```bash
postal bootstrap postal.yourdomain.com
```

图09



这将在 `/opt/postal/config` 中生成三个文件。

- `postal.yml` 是 `Postal` 主配置文件
- `signing.key` 是用于在 `Postal` 中签署各种事物的私钥
- `Caddyfile` 是 `Caddy` `Web` 服务器的配置



以上文件一旦生成后，我们应该打开 `/opt/postal/config/postal.yml` 并添加所有适当的安装值（比如数据库密码等）。

图10



```
请注意，docker 设置挂载 /opt/postal/config 为 /config ，因此 postal.yml 中提到的任何完整目录路径都可能需要以 /config 开头，而不是以 /opt/postal/config 开头。
```



添加配置后，需要通过添加所有适当的表来初始化数据库。

运行以下命令以创建架构，然后创建第一个管理员用户。

```bash
postal initialize
postal make-user
```

图11

图12

图13

图14



OK！

现在我们已经准备好实际运行 `Postal` 本身了。

可以通过运行以下命令来继续执行此操作：

```
postal start
```

图15



这将在计算机上运行多个容器。

可以使用 `postal status` 来查看这些组件的详细信息。

图16



接下来，我们要处理 `SSL` 终端和所有 `Web` 流量，则需要配置 `Web` 代理。

我们可以在这里使用任何自己喜欢的东西，诸如 `nginx` 、 `Apache` 、 `HAProxy` ，任何东西都是可以的。

但是按照官方文档中的建议，最好是使用 `Caddy` 。

这是一个很棒的小型服务器，需要很少的配置并且非常容易设置。

它也是通过 `docker` 来跑的，简单又方便。

```
docker run -d \
   --name postal-caddy \
   --restart always \
   --network host \
   -v /opt/postal/config/Caddyfile:/etc/caddy/Caddyfile \
   -v /opt/postal/caddy-data:/data \
   caddy
```

图17



一旦启动，`Caddy` 将自动为我们的域颁发 `SSL` 证书，我们将能够立即访问 `Postal` `Web` 界面并使用在前面步骤之一中创建的用户登录。



服务已经跑起来了，我们来简单看一下基本操作吧。

登录 `Web` 页面，输入前面创建的管理员和密码。

图18



可以点击设置 `My Settings` 来修改管理员的一些信息，比如密码。

图19



一开始需要创建组织。

图20



创建完组织，还要创建邮件服务器，用于管理。

图21

图22



接着邮件服务器要有相应的域名。

图23

图24



一个组织里可以放好几个邮件服务器。

如果你不想要这个组织，也可以随时删除它。

图25



创建完邮件服务器。

图26



随时都可以点击 `Send Message` 来测试邮件发送。

图27



指定好发件人和收件人，以及主题和内容，点击 `Send Message` 按钮。

图28



如果配置不正确，有可能会收到错误信息，比如 `SOFT FAIL` （软拒绝）。

图29



类似问题的原因可能有很多，其中有一个原因可能是 `SMTP` 认证未能通过。

那么我们就要到 `Credentials` 一项中设定认证，否则验证不通过是无法正常发送邮件的。

图30

图31



用 `Telnet` 方式来测试一下 `postal` 是否正常工作。

图32



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

图33



验证通过后，输入发件人和收件人，并输入主题和内容即可发送测试邮件。

图34



因为是测试环境，我并没有完善一些配置，因此无法截取成功发送的截图，请见谅！

有兴趣的小伙伴们可以自行测试后续使用情况。



最后出于对 `Postal` 的喜爱，我将官方在线英文文档做了一个中文版的 `PDF` 手册。

对此感兴趣的小伙伴们可以过来围观一下。



与此同时，`Postal` 英文版也被我放在了一起，方便大家收集使用。

英文版封面，内容和官网一致。

图35



中文版封面

图36



部分内容一览，其中加了很多我自己的截图，方便大家学习参考。

图37

图38













**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc



