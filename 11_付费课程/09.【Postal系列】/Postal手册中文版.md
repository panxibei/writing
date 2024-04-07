Postal手册中文版















* 欢迎

  * 功能列表
  * 常见问题

* 开始

  * 开始
  * 先决条件
  * 安装
  * 升级
  * 配置
  * `DNS` 配置
  * 升级到 `v3`
  * 升级到 `v2`

* 特征

  * 点击并开启跟踪
  * 运行状况和指标
  * `IP` 池
  * 日志
  * `OpenID` 连接
  * `SMTP` 身份验证
  * `SMTP TLS`
  * 垃圾邮件和病毒检查

* 开发者

  * 使用 `API`
  * 客户端库
  * 通过 `HTTP` 接收电子邮件
  * `Webhooks`（网络钩子）

* 其他说明

  * 自动回复和退回
  * 我们的容器镜像
  * 调试
  * 通配符和地址标签

  



# 欢迎

## 功能列表

这是 `Postal` 可以执行的功能列表（排名不分先后）。



### 一般特征：

- 支持具有邮件服务器和用户的多个组织。

- 显示传入和传出邮件量的图表和统计信息。

- 访问以查看历史消息。

- 访问以查看完整的传出和传入消息队列。

- 设置 `Webhook` 以实时接收有关投放信息的实时信息。

  此外，还存储了对过去 `7` 天 `Webhook` 请求的完全访问权限，以便进行调试。

- 内置 `DNS` 检查和监控，以确保正确配置您发送邮件的域，以实现最大的送达率。

- 每台服务器保留配置，设置消息在数据库中应保留的时间以及要保留在磁盘上的最大大小。

- 完整的日志记录，因此可以轻松识别交付问题。

- 邮件服务器范围的搜索工具，用于查找需要调查的邮件。



### 外发电子邮件：

- 将邮件发送到 `SMTP` 服务器或使用 `HTTP API` 。

- 管理每台服务器的多个凭据。

- 支持对出站邮件进行 `DKIM` 签名。

- 使开发能够将邮件保存在 `Postal` 中，而无需实际将其传递给收件人（可以在 `Postal` 界面中查看邮件）。

- 内置黑名单，可避免将邮件发送给不存在或无法接受电子邮件的收件人。

- 单击并打开跟踪以跟踪收件人何时打开您的电子邮件并单击其中的链接。

- 配置每台服务器的发送限制，以避免邮件服务器滥用。

- 管理多个发送 `IP` 地址池。

- 将不同的发件人或收件人配置为从某些 `IP` 地址传递邮件。

- 邮件标记，以便可以为某些电子邮件提供标记，以便在需要时对其进行分组。

  例如，您可以这样标记 `receipts` 或 `password-reset` 来发送电子邮件。



### 传入电子邮件：

- 能够将传入电子邮件转发到 `HTTP` 端点。
- 能够将传入电子邮件转发到其他 `SMTP` 服务器。
- 能够将传入的电子邮件转发到其他电子邮件地址。
- 使用 `SpamAssassin` 和 `ClamAV` 进行垃圾的邮件和线程检查，具有可配置的阈值和处理垃圾邮件的不同方法。

这是 `Postal` 可以执行的功能列表（排名不分先后）。







## 常见问题

在足够的时间内任何人有过频繁地提出相应的问题，则将其视为常见问题解答。

一旦我们有一些问题要回答，我们将立即更新此页面。



### 我应该使用它而不是使用云提供商吗？

这真的取决于你。

这两种解决方案都有优点和缺点，您应该选择适合每种情况的解决方案。

但是，不要掉以轻心地运行自己的电子邮件平台，需要考虑许多因素，以确保实现良好的可传递性（包括正确的 `DNS` 配置）。



### 通过 `Postal` 发送的电子邮件将成为垃圾邮件。

- 检查是否正确配置了 `DNS` 。

  首先，您需要为您的 `IP` 提供反向 `DNS` ，您需要配置 `DKIM` 和 `SPF` ，您需要确保您的 `rDNS` 与提供给收件人邮件服务器的 `HELO` 匹配。

- 确保您的发送 `IP` 配置了反向 `DNS` （ `PTR` ）记录。

- 检查您发送邮件的 `IP` 地址是否不在任何黑名单上。

- 检查您的实际电子邮件是否看起来像垃圾邮件。

- 发送大量电子邮件的新 `IP` 最初可能无法很好地传递。

您可以通过 `Mail Tester` （邮件测试器）之类的东西运行您的邮件，这将使您很好地了解邮件传递的垃圾级别，并确保您正确配置了所有内容。



### 您可以添加邮件列表功能吗？

不。

`Postal` 是邮件传输代理，而不是邮件列表管理器。

我们不希望添加更适合其他应用程序的功能，例如，通讯簿或处理数据库中人员的取消订阅。





# 开始

## 开始

`Postal` 安装起来相当容易，但运行自己的邮件服务器并不适合每个人。

如果您使用 `Postal` ，您还将负责配置您的 `DNS` 作为维护平台（包括运行升级）。

如果这听起来不像您想要的事情，请尝试托管平台。



安装 `Postal` 的过程概述如下。

当您准备好开始使用 转到“先决条件”页。

1. 安装 `Docker` 和其他先决条件
2. 添加适当的配置和 `DNS` 条目
3. 启动 `Postal`
4. 创建您的第一个用户
5. 登录到 `Web` 界面以创建您的第一个虚拟邮件服务器



### 可视化学习？

您可以观看此视频，该视频将介绍安装过程。

（请通过官网查看教学视频）





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



### Git & 安装助手存储库

您需要确保 `git` 已安装在服务器上。

然后，您需要克隆 `Postal` 安装助手程序存储库。

这包含一些引导配置和其他有用的东西，这些东西将加快您的安装速度。

```
git clone https://github.com/postalserver/install /opt/postal/install
sudo ln -s /opt/postal/install/bin/postal /usr/bin/postal
```



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

- 这将运行一个 `MariaDB` 实例，并让它侦听端口 `3306` 。

- 请务必选择安全密码。

  安装时，您需要将其放入您的 `Postal` 配置中，因此请务必（安全）记下它。

- 如果您无法或不愿意授予 `root` 访问权限，则您单独创建的数据库用户需要对名为 `postal` 和 `postal-*` （可以在配置  `message_db` 部分中配置此前缀）赋予数据库的所有权限。

```
虽然您可以根据需要配置最大消息尺寸，但您需要验证 MariaDB 配置的 innodb_log_file_size 至少是您希望发送的最大消息的10倍（15MB电子邮件为150MB，25MB电子邮件为250MB，诸如此类）。

如果您有旧版v1数据库，您可能还需要检查数据库中的原始表是否具有 LONGBLOB 类型。
```





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



这将在 `/opt/postal/config` 中生成三个文件。

- `postal.yml` 是 `Postal` 主配置文件
- `signing.key` 是用于在 `Postal` 中签署各种事物的私钥
- `Caddyfile` 是 `Caddy` `Web` 服务器的配置



以上文件一旦生成后，您应该打开 `/opt/postal/config/postal.yml` 并添加所有适当的安装值（比如数据库密码等）。

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



### 运行 Postal

您现在已准备好实际运行 `Postal` 本身。

您可以通过运行以下命令来继续执行此操作：

```
postal start
```



这将在您的计算机上运行多个容器。

您可以使用 `postal status` 来查看这些组件的详细信息。



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



一旦开始，`Caddy` 将为您的域颁发 `SSL` 证书，您将能够立即访问 `Postal` `Web` 界面并使用您在前面步骤之一中创建的用户登录。

图a01



## 升级

```
如果当前未运行 `Postal` `v2` ，则需要先按照从 `1.x` 升级文档进行操作，然后才能使用这些说明。
```

安装 `Postal` 后，可以通过运行此命令对其进行升级。

这将始终将您升级到可用最新版本的 `Postal` 。

```bash
cd /opt/postal/install
git pull origin
postal upgrade
```



这将按以下顺序执行一些操作：

- 使用 `Git` 获取安装帮助程序存储库的最新副本
- 拉取最新版本的 `Postal` 容器
- 对数据库架构执行任何必要的更新
- 重新启动所有正在运行的容器



这不是零停机时间升级，因此建议在流量较低且已适当安排维护时执行此操作。

如果您需要零停机时间升级，则需要寻找可以处理此问题的替代容器管理系统（例如 `Kubernetes` ）。



### 更改为特定版本

默认情况下，运行 `postal upgrade` 将安装 `Postal` 容器注册中提供的最新版本。

如果需要将 `Postal` 的版本更改为特定版本，可以使用命令 `postal upgrade`  来指定版本，如下所示：

```bash
postal upgrade [version]
```



## 配置

`Postal` 可以通过其配置文件或环境变量进行配置。

有相当多的区域可以配置。



您可以查看所有可用的配置选项。

- 完整的 `Postal` 配置文件 - 这是一个示例配置文件，其中包含所有配置选项及其默认值和描述。

  此文件通常存在于 `/opt/postal/config/postal.yml` 中。

- 所有环境变量 - 此页面列出了所有环境变量。

  配置文件中可以设置的所有配置也可以由环境变量设置。

```
注意：如果更改任何配置，则应确保重新启动 Postal
```



### 端口和绑定地址

`Web` 和 `SMTP` 服务器侦听端口和地址。

这些端口的默认值可以通过配置进行设置，但是，如果您在单个主机上运行多个实例，则需要为每个实例指定不同的端口。



您可以使用 `PORT` 和 `BIND_ADDRESS` 环境变量为这些进程提供特定于实例的值。



### 旧配置

`Postal` 配置文件的当前版本是 `2` 。

这在配置文件本身中显示为 `version: 2` 。



`Postal` 仍支持 `Postal` `v2` 及更早版本中的版本 `1`（或旧版）配置格式。

如果您使用的是此配置文件，则在启动 `Postal` 时，您将在日志中收到警告。

我们建议更改配置以遵循上面介绍的新 `v2` 格式。



`v1` 和 `v2` 配置之间的主要区别如下所示。

- `web.host` 更改为 `postal.web_hostname`
- `web.protocol` 更改为 `postal.web_protocol`
- `web_server.port `更改为 `web_server.default_port`
- `web_server.bind_address` 更改为 `web_server.default_bind_address`
- `smtp_server.port` 更改为 `smtp_server.default_port`
- `smtp_server.bind_address` 更改为 `smtp_server.default_bind_address`
- `dns.return_path `更改为 `dns.return_path_domain`
- `dns.smtp_server_hostname `更改为 `postal.smtp_hostname`
- `general.use_ip_pools` 更改为 `postal.use_ip_pools`
- `general.*` 对命名空间 `postal` 下各种新名称的更改
- `smtp_relays` 更改为 `postal.smtp_relays` 并且现在使用字符串数组，其格式应为 `smtp://{host}:{port}?ssl_mode={mode}`
- `logging.graylog.*` 更改为 `gelf.*`





## DNS 配置

若要正常工作，需要为 `Postal` 安装配置大量 `DNS` 记录。

查看下表，并与 `DNS` 提供商一起创建相应的 `DNS` 记录。

您需要在配置文件 `postal.yml` 中输入您选择的记录名称。



在本文档中，我们假设您的服务器同时拥有 `IPv4` 和 `IPv6` 。

我们将在本文档中使用以下值，您需要根据需要替换它们。

- `192.168.1.3` - `IPv4` 地址
- `2a00:1234:abcd:1::3` - `IPv6` 地址
- `postal.example.com` - 您希望用于运行 `Postal` 的主机名



### A 记录

您将需要这些记录来访问 `API` 、管理界面和 `SMTP` 服务器。

| 主机名               | 类型   | 记录值                |
| -------------------- | ------ | --------------------- |
| `postal.example.com` | `A`    | `192.168.1.3`         |
| `postal.example.com` | `AAAA` | `2a00:1234:abcd:1::3` |



### SPF 记录

您可以为邮件服务器配置全局 `SPF` 记录，这意味着域不需要每个域单独引用您的服务器 `IP` 。

这允许您在将来进行更改。

| 主机名                   | 类型  | 记录值                                                |
| ------------------------ | ----- | ----------------------------------------------------- |
| `spf.postal.example.com` | `TXT` | `v=spf1 ip4:192.168.1.3 ip6:2a00:1234:abcd:1::3 ~all` |

```
您可能希望将 ~all 替换为 -all 以使 SPF 记录更严格。
```



### 返回路径

返回路径域是默认域，用作 `MAIL FROM` 通过邮件服务器发送的所有邮件的域。

您应该按如下方式添加 `DNS` 记录。

| 主机名                                    | 类型  | 记录值                                            |
| ----------------------------------------- | ----- | ------------------------------------------------- |
| `rp.postal.example.com`                   | `MX`  | `10 postal.example.com`                           |
| `rp.postal.example.com`                   | `TXT` | `v=spf1 a mx include:spf.postal.example.com ~all` |
| `postal._domainkey.rp.postal.example.com` | `TXT` | 值从 `postal default-dkim-record`                 |



### 路由域

如果您希望通过将邮件直接转发到 `Postal` 路由来接收传入电子邮件，则需要为此配置一个域，以便使用 `MX` 记录指向您的服务器。

| 主机名                      | 类型 | 记录值                  |
| --------------------------- | ---- | ----------------------- |
| `routes.postal.example.com` | `MX` | `10 postal.example.com` |



### Postal 配置示例

在您的 `postal.yml` 中，您应该有如下所示的内容来涵盖关键的 `DNS` 记录。

```yaml
dns:
  mx_records:
    - mx1.postal.example.com
    - mx2.postal.example.com
  spf_include: spf.postal.example.com
  return_path_domain: rp.postal.example.com
  route_domain: routes.postal.example.com
  track_domain: track.postal.example.com
```





## 升级到 v3

```
如果您当前运行的 Postal 版本低于 2.0.0，则应先升级到 v2，然后再升级到 v3。
```



`Postal` `v3` 于 `2024` 年 `3` 月发布，对 `Postal` 的运行方式进行了一些更改。

`v2` 和 `v3` 之间的显著变化如下：

- 无需使用 `RabbitMQ`
- 无需运行 `cron` 或 `requeuer` 进程
- 改进了日志记录
- 改进配置管理（包括使用环境变量或配置文件进行配置的能力）



### 数据库注意事项

数据库中任何预先存在的表都必须使用 `DYNAMIC` 行格式进行设置，这一点很重要。

否则，您可能会在数据库迁移过程中收到错误。

这是自 `MariaDB` `10.2.1` 以来的默认设置。



您可以使用 `SHOW TABLE STATUS FROM postal` 检查表的格式。

如果您的表不正确，可以使用以下命令进行更改：

```sql
ALTER TABLE `table_name` ROW_FORMAT=DYNAMIC;
```



### 升级

要升级，您可以按照升级页面上提供的相同说明进行操作。



### 配置

`Postal` `v3` 为其配置文件引入了一种新格式。

可以在我们的存储库中找到完整的新配置文件格式的示例。



虽然 `v3` 仍与早期版本的配置兼容，但应将配置更改为新格式以确保持续兼容。

任何新添加的配置选项在 `v1` 配置格式中都不可用。



### RabbitMQ

升级到 `v3` 后，您可以删除仅支持 `Postal` 安装的任何 `RabbitMQ` 服务。



### Cron & Requeuer 进程

这些进程在 `Postal` `v3` 中不是必需的，也不应运行。





## 升级到 v2

`2021` 年 `7` 月，我们更改了 `Postal` 的安装方式。

安装 `Postal` 的唯一支持方法是现在使用我们提供的容器。

您可以按照以下说明升级 `1.x` 安装以使用容器。



### 我如何知道我是否在使用 `Postal` `v1`？

两个版本之间有一些更改，这应该有助于识别您的版本。

- `Postal` `Web` 界面现在在所有页面（登录页面除外）上都有一个页脚，显示当前版本。

  如果没有页脚，则表示您没有使用 `Postal` `v2` 。

- 如果在不使用容器的情况下安装了 `Postal` ，则很可能使用的是 `Postal` `v1` 。

- 如果运行 `ps aux | grep procodile` 并可获得任何结果，则您使用的是 `Postal` `v1` 。

- 如果运行 `docker ps` 但未获得任何结果，则使用的是 `Postal` `v1` 。

- 如果您在 `2021` 年 `7` 月之前安装了 `Postal` ，则您使用的是 `Postal` `v1` 。

- 如果您有一个目录 `/opt/postal/app` ，您正在使用 `Postal` `v1`（或者您已经升级到 `Postal` `v2` 但尚未整理）。



### 假设

出于本指南的目的，我们将对您的安装做出一些假设。

如果这些假设中的任何一个都不成立，则需要确定适当的升级路线。

- 您已在单个服务器上安装了 `Postal` 。
- 您的服务器上运行着 `MariaDB`（或 `MySQL` ）数据库服务器，并侦听端口 `3306` 。
- 您的服务器上运行着一个 `RabbitMQ` 服务器，并侦听端口 `5672` 。
- 您当前的安装位于 `/opt/postal` 中，您的配置位于 `/opt/postal/config` 中。
- 您在 `Postal` `Web` 服务器前面使用 `Web` 代理（例如 `nginx` 、 `Caddy` 或 `Apache` ）。

```
执行此升级将意味着您的 Postal 服务将在短时间内不可用。
我们建议安排一些维护，并在流量较低时执行升级。
```



### 预备

您需要安装一些额外的系统依赖项。

- Docker
- docker-compose

```
重要提示：使用这些软件的最新版本，而不仅仅是安装操作系统供应商存储库中提供的最新软件包。
说明请参考前面链接。
```



如果您运行的是旧版本或不受支持的操作系统版本，您可能希望利用此机会进行升级。

执行此操作的方法超出了本文档的范围。



### 停止 Postal

首先使用 `postal stop` 停止 `Postal` 进程。



### 配置用于打开/单击跟踪的 Web 代理

在 `Postal` `2.x` 中，我们不再提供专用的服务器进程来处理打开和点击跟踪的请求。

如果不使用此功能，可以跳到下一部分。

但是，如果这样做，则需要向 `Web` 代理添加一些配置并颁发一些 `SSL` 证书。



对于您配置的所有**跟踪域**（例如 `track.yourdomain.com` ），您需要执行以下操作：

1. 在 `Web` 代理中配置虚拟主机，以将每个跟踪域的所有请求路由到 `Postal` `Web` 服务器（在端口 `5000` 上）。
2. 确保通过代理的所有请求都具有 `X-Postal-Track-Host: 1` 标头。
3. 为所有这些主机颁发 `SSL` 证书。
4. 确保您的 `Web` 代理正在侦听您之前用于 `Postal` `fast_server` 的 `IP` 地址。
5. 由于 `Postal` 不再需要有两个 `IP` 地址，因此您可以更新引用辅助 `IP` 的所有 `DNS` 记录，以指向用于 `Postal` 的主 `IP` 。



### 检查配置

您现有的 `Postal` 配置可以保留在与 `/opt/postal/config` 之前相同的位置。

如果您引用了 `postal.yml` 中的任何其他文件，则需要确保这些文件位于 `/opt/postal/config` 文件夹中，并将路径替换为 `/config` 。



例如，如果您有以下内容：

```yaml
smtp_server:
  tls_enabled: true
  tls_certificate_path: /opt/postal/config/smtp.crt
  tls_private_key_path: /opt/postal/config/smtp.key
```



您需要将 `/opt/postal/config` 更新为 `/config` ，如下：

```yaml
smtp_server:
  tls_enabled: true
  tls_certificate_path: /config/smtp.crt
  tls_private_key_path: /config/smtp.key
```

```
重要提示：如果您在操作系统的其他部分（例如 /etc 中）引用了文件，则必须确保这些文件现在位于目录 /opt/postal/config 中，否则它们在 Postal 运行的容器中将不可用。
```



### 删除旧的 Postal 帮助程序脚本

运行以下命令以备份旧的 `Postal` 帮助程序脚本。

```
mv /usr/bin/postal /usr/bin/postal.v1
```



### 安装 Postal v2

接下来要做的是下载新的 `Postal` 安装帮助程序存储库并设置新 `postal` 命令。

```
git clone https://github.com/postalserver/install /opt/postal/install
sudo ln -s /opt/postal/install/bin/postal /usr/bin/postal
```



接下来，使用新的 `Postal` 命令行帮助程序运行正常升级。

这将运行一个新镜像，将数据库架构升级到 `Postal` `v2` 所需的架构。

```
postal upgrade
```



最后，您可以启动 `Postal` 组件。

```
postal start
```



您现在应该会发现 `Postal` 再次运行并正常工作。

使用  `postal status` 确认所有进程类型都在运行。



输出应如下所示：

```
      Name                     Command               State   Ports
------------------------------------------------------------------
postal_cron_1       /docker-entrypoint.sh post ...   Up
postal_requeuer_1   /docker-entrypoint.sh post ...   Up
postal_smtp_1       /docker-entrypoint.sh post ...   Up
postal_web_1        /docker-entrypoint.sh post ...   Up
postal_worker_1     /docker-entrypoint.sh post ...   Up
```



### 有关 SMTP 端口的说明

如果预先在 `25` 以外的任何端口上运行 `Postal` `SMTP` 服务器，则可以还原此配置并让 `Postal` 直接侦听此端口。

为此，您可以删除可能拥有的任何 `iptables` 规则，并使用新的端口号更新您的 `postal.yml` 。



### 回滚

如果出现问题并且需要回滚到以前的版本，您仍然可以通过恢复 `postal` 帮助程序并重新启动它来执行此操作。

```
postal stop
unlink /usr/bin/postal
mv /usr/bin/postal.v1 /usr/bin/postal
postal start
```



### 整理

当您对一切运行良好感到满意时，您应该做一些最后的事情：

- 删除 `/opt/postal/app` 。这是应用程序本身所在的位置，不再需要。
- 删除 `/opt/postal/log` 。此处不再存储日志。
- 删除 `/opt/postal/vendor` 。这不再使用。
- 从 `/usr/bin/postal.v1` 中删除备份 `Postal` 帮助程序工具。
- 如果您更改了任何跟踪域以使用您的主 `IP` 地址，则可以在检查是否应用了所有 `DNS` 更新后从服务器中删除其他 `IP` 。



### 使用现有数据在新服务器上安装

如果您只想在新服务器上安装 `Postal` 并复制数据，您可以按照以下说明进行操作。

1. 创建新服务器，并按照说明安装 `Postal` 。

   此时，您应该有一个有效的安装。

2. 在旧服务器上，使用 `postal stop` 停止 `Postal` 。

3. 在继续使用 `postal status` 之前，请确保它已完全停止。

   在新服务器上，使用 `postal stop` 停止 `Postal` 。

4. 使用任何您喜欢的工具（ `mysqldump` 、 `Mariabackup` 等）将数据库复制到新服务器。

   确保复制 `postal` 数据库以及所有其他 `postal` 为前缀的数据库（或已将前缀配置为 `message_db` 配置部分的任何内容）。

5. 在新服务器上，运行 `postal upgrade-db` 以使用更改的表结构更新复制的数据库。

6. 确保 `postal.yml` 正确合并。

   例如，确保您的 `dns` 部分是正确的。

   无需复制 `rails.secret` - 新主机上的新密钥不会有问题。

7. 如果在开始之前完全停止了 Postal，则无需从 RabbitMQ 复制任何持久化数据。

8. 关闭旧的邮政服务器。

9. 将 IP 地址从旧服务器移动到新服务器（如果旧服务器和新服务器都使用同一提供商）。

10. 使用 在新服务器上启动 Postal。`postal start`







# Features

## Click & Open Tracking

Postal supports tracking opens and clicks from e-mails. This allows you to see when people open messages or they click links within them.

图a02



### How it works

Once enabled, Postal will automatically scan your outgoing messages and  replace any links and images with new URLs that go via your Postal web  server. When the link is clicked, Postal will log the click and redirect to the user to the original URL automatically. The links that are  included in the e-mail should be on the same domain as the sender and  therefore you need to configure a subdomain like `click.yourdomain.com` and point it to your Postal server.

### Configuring your web server

To avoid messages being marked as spam, it's important that the subdomain  that Postal uses in the re-written URLs is on the same domain as that  sending the message. This means if you are sending mail from `example.com`, you'll need to setup `click.example.com` (or whatever you choose) to point to your Postal server.

You'll need to add an appropriate virtual host on your web server that proxies traffic from that domain to the Postal web server. The web server must  add the `X-Postal-Track-Host: 1` header so the Postal web server knows to treat requests as tracking requests.

Once you have configured this, you should be able to visit your chosen domain in a browser and see `Hello.` printed back to you. If you don't see this, review your configuration  until you do. If you still don't see this and you enable the tracking,  your messages will be sent with broken links and images.

If you're happy things are working, you can enable tracking as follows:

1. Find the web server you wish to enable tracking on in the Postal web interface
2. Go to the **Domains** item
3. Select **Tracking Domains**
4. Click **Add a tracking domain**
5. Enter the domain that you have configured and choose the configuration you want to use. It is **highly** recommended that you use SSL for these connections. Anything else is  likely to cause problems with reputation and user experience.

### Disabling tracking on a per e-mail basis

If you don't wish to track anything in an email you can add a header to your e-mails before sending it.

```text
X-AMP: skip
```

### Disabling tracking for certain link domains

If there are certain domains you don't wish to track links from, you can  define these on the tracking domain settings page. For example, if you  list `yourdomain.com` no links to this domain will be tracked.

### Disabling tracking on a per link basis

If you wish to disable tracking for a particular link, you can do so by inserting `+notrack` as shown below. The `+notrack` will be removed leaving a plain link.

- `https+notrack://postalserver.io`
- `http+notrack://katapult.io/signup`



## Health & Metrics

The Postal worker and SMTP server processes come with additional  functionality that allows you to monitor the health of the process as  well as look at live metrics about their performance.

### Port numbers

By default, the health server listens on a different port for each type of process.

- Worker - listens on port `9090`
- SMTP server - listens on port `9091`

Unlike other services, if these ports are in use when the process starts, the  health server will simply not start but the rest of the process will run as normal. This will be shown in the logs.

To configure these ports you can set the `HEALTH_SERVER_PORT` and `HEALTH_SERVER_BIND_ADDRESS` environment variables.

### Metrics

The metrics are exposed at `/metrics` and are in a standard Prometheus exporter format. This means they can  be scraped by any tool that can ingest Prometheus metrics. This will  then allow them to be turned in to graphs as appropriate.

### Health checks

The `/health` endpoint will return "OK" when the process is running. This can be used for health check monitoring.



## IP Pools

Postal supports sending messages from different IP addresses. This allows you  to configure certain sets of IPs for different mail servers or send from different IPs based on the sender or recipient addresses.

### Enabling IP pools

By default, IP pools are disabled and all email is sent from any IP  address on the host running the workers. To use IP pools, you'll need to enable them in the configuration file. You can do this by setting the  following in your `postal.yml` configuration file. You'll then need to restart Postal using `postal stop` and `postal start`.

```yaml
postal:
  use_ip_pools: true
```

### Configuring IP pools

Once you have enabled IP pools, you'll need to set them up within the web interface. You'll see an **IP Pools** link in the top right of the interface. From here you can add pools and then add IP addresses within them.

Once an IP pool has been added, you'll need to assign it any organization  that should be permitted to use it. Open up the organization and choose **IPs** and then tick the pools you want to allocate.

Once allocated to an organization, you can assign the IP pool to servers from the server's **Settings** page. You can also use the IP pool to configure IP rules for the organization or server.

It's **very important** to make sure that the IP addresses you add in the web interface are  actually configured on your Postal servers. If the IPs don't exist on  the server, message delivery may fail or messages will not be dequeued  correctly.



## Logging

All Postal processes log to STDOUT and STDERR which means their logs are  managed by whatever engine is used to run the container. In the default  case, this is Docker.

### Redirecting logs to the host syslog

If you want to send your log data to the host system's syslog then you can configure this. This is useful if you wish to use external tools like `fail2ban` to block users from accessing your system.

The quickest way to achieve this is to use a docker compose overide file in `/opt/postal/install/docker-compose.override.yml`. The contents of this file, would contain the following:

```yaml
version: "3.9"
services:
  smtp:
    logging:
      driver: syslog
      options:
        tag: postal-smtp
```

If you wanted to put worker and web server logs there too, you can define those. The example above demonstrates using the `smtp` server process.

### Limiting the size of logs

Docker cam be configured to limit the size of the log files it stores. To  avoid storing large numbers of log files, you should configure this  appropriately. This can be achieved by setting a maximum size in your `/etc/docker/daemon.json` file.

```json
{
  "log-driver": "local",
  "log-opts": {
    "max-size": "100m"
  }
}
```

### Sending logs to Graylog

Postal includes support for sending log output to a central Graylog server  over UDP. This can be configured using the following options:

```yaml
gelf:
  # GELF-capable host to send logs to
  host: 
  # GELF port to send logs to
  port: 12201
  # The facility name to add to all log entries sent to GELF
  facility: postal
```



## OpenID Connect

Postal supports OpenID Connect (OIDC) allowing you to delegate authentication  to an external service. When enabled, there are various changes:

- You are not required to enter a password when you add new users.
- When a user first logs in with OIDC, they will be matched to a local user based on their e-mail address.
- On subsequent logins, the user will be matched based on their unique identifier provided by the OIDC issuer.
- Users without local passwords cannot reset their password through Postal.
- Users cannot change their local password when associated with an OIDC identity.
- Existing users that currently have a password will continue to be able to use  that password until it is linked with an OIDC identity.

图a03



### Configuration

To get started, you'll need to find an OpenID Connect enabled provider.  You should create your application within the provider in order to  obtain a identifier (client ID) and a secret (client secret).

You may be prompted to provide a "redirect URI" during this process. You should enter `https://postal.yourdomain.com/auth/oidc/callback`.

Finally, you'll need to place your configuration in the Postal config file as normal.

```yaml
oidc:
  # Start by enabling OIDC for your installation.
  enabled: true
  
  # The name of the OIDC provider as shown in the UI. For example: 
  # "Login with My Proivder".
  name: My Provider
  
  # The OIDC issuer URL provided to you by your Identity provider. 
  # The provider must support OIDC Discovery by hosting their configuration
  # at https://identity.example.com/.well-known/openid-configuration.
  issuer: https://identity.example.com
  
  # The client ID for OIDC
  identifier: abc1234567890

  # The client secret for OIDC
  secret: zyx0987654321
  
  # Scopes to request from the OIDC server. You'll need to find these from your
  # provider. You should ensure you request enough scopes to ensure the user's
  # email address is returned from the provider.
  scopes:
    - openid
    - email
```

If your Identity Provider does not  support OpenID Connect discovery (which is enabled by default, you can  manually configure it.) For full details of the options available see  the [example config file](https://github.com/postalserver/postal/blob/main/doc/config/yaml.yml).

By default, Postal will look for an email address in the `email` field and a name in the `name` field. These can be overriden using configuration if these values can be found elsewhere.

### Logging in

Once enabled, you can log in by pressing the **Login with xxx** button on the login page. This will direct you to your chosen identity  provider. Once authorised, you will be directed back to the application. If a user exists matching the e-mail address returned by the OpenID  provider, it will be linked and you will be logged in. If not, an error  will be displayed.

### Debugging

Details about the user matching process will be displayed in the web server  logs when the callback from the Identity provider happens.

### Disabling local authentication

Once you have established your OpenID Connect set up, you can fully disable  local authentication. This will change the login page as well as user  management options.

```yaml
oidc: 
  # ...
  local_authentication_enabled: false
```

### Using Google as an identity provider

Setting up Postal to authenticate with Google is fairly straight forward.  You'll need to use the Google Cloud console to generate a client ID and  secret ([see docs](https://developers.google.com/identity/openid-connect/openid-connect)). When prompted for a redirect URI, you should be `https://postal.yourdomain.com/auth/oidc/callback`. The following configuration can be used to enable this:

```yaml
oidc:
  enabled: true
  name: Google
  issuer: https://accounts.google.com
  identifier: # your client ID from Google
  secret: # your client secret from Google
  scopes: [openid, email]
```

------





## SMTP Authentication

For sending outgoing emails through the Postal SMTP server you will need to generate a **credential** through the Postal web interface. This credential is associated with a  server and allows you to send mail from any domain associated with that  domain (or the organization that owns the domain.)



### Authentication types

When authenticating to the SMTP server, there are three supported authentication types.

- `PLAIN` - the credentials are passed in plain text to the server. When using this, you can provide any string as the username (e.g. `x`) and the password should contain your credential string.
- `LOGIN` - the credentials are passed Base64-encoded to the server. As above,  you can use anything as the username and the password should contain the credential string (Base64-encoded).
- `CRAM-MD5` - this is a challenge-response mechanism based on the HMAC-MD5  algorithm. Unlike the above two mechanism, the username does matter and  should contain the organization and server permalinks separated by a `/` or `_` character. The password used should be the value from your credential.



### From/Sender validation

When sending outgoing email through the SMTP server, it is important that the `From` header contains a domain that is owned by the server or its organization. If this it not valid, you will receive a `530 From/Sender name is not valid` error.

If you have enabled "Allow Sender Header" for the server, you can include this domain in the `Sender` header instead and any value you wish in the `From` header.



### IP-based authentication

Postal has the option to authenticate clients based on their IP address. To use this, you need to create an **SMTP-IP** credential for the IP or network you wish to allow to send mail. Use this carefully to avoid creating an open relay.



## SMTP TLS

By default, Postal's SMTP server is not TLS enabled however you can enable it by generating and providing a suitable certificate. We recommend  that you use a certificate issued by a regnognised certificate authority but this isn't essential to use this feature.



### Key & certificate locations

Certificates should be placed in your `/opt/postal/config` directory.

- `/opt/postal/config/smtp.key` - the private key in PEM format
- `/opt/postal/config/smtp.cert` - the certificate in PEM format



#### Generating a self signed certificate

You can use the command below to generate a self signed certificate.

```bash
openssl req -x509 -newkey rsa:4096 -keyout /opt/postal/config/smtp.key -out /opt/postal/config/smtp.cert -sha256 -days 365 -nodes
```



### Configuration

Once you have a key and certificate you will need to enable TLS in the configuration file (`/opt/postal/config/postal.yml`). Additional options are available too.

```yaml
smtp_server:
  # ...
  tls_enabled: true
  # tls_certificate_path: other/path/to/cert/within/container
  # tls_private_key_path: other/path/to/cert/within/container
  # tls_ciphers:
  # ssl_version: SSLv23
```

You will need to run `postal restart` if you change the configuration or your key/certificate.



## Spam & Virus Checking

Postal can integrate with SpamAssassin and ClamAV to automatically scan  incoming and outgoing messages that pass through mail servers.

This functionality is disabled by default.



### Setting up SpamAssassin

By default, Postal will talk to SpamAssassin's `spamd` using an TCP socket connection (port 783). You'll need to install SpamAssassin on your server and then enable it within Postal.



#### Installing SpamAssassin

```
sudo apt install spamassassin
```

Once you have installed this, you will need to open up `/etc/default/spamassassin` and change `ENABLED` to `1` and  `CRON` to `1`. On some systems (such as Ubuntu 20.04 or newer), you might need to enable the SpamAssassin daemon with the following command.

```bash
update-rc.d spamassassin enable
```

Then you should restart SpamAssassin.

```
sudo systemctl restart spamassassin
```



#### Enabling in Postal

To enable spam checking, you'll need to add the following to your `postal.yml` configuration file and restart. If you have installed SpamAssassin on a different host to your Postal installation you can change the host here but be sure to ensure that the `spamd` is listening on your external interfaces.

```yaml
spamd:
  enabled: true
  host: 127.0.0.1
  port: 783
postal stop
postal start
```



#### Classifying Spam

The spam system is based on a numeric scoring system and different scores  are assigned to different issues which may appear in a message. You can  configure different thresholds which define when a message is treated as spam. We recommend starting at 5 and updating this once you've seen how your incoming messages are classified.

You have three options which can be configured on a per route basis which defines how spam messages are treated:

- **Mark** - messages will be sent through to your endpoint but the spam information will be made available to you.
- **Quarantine** - the message will placed into your hold queue and you'll need to  release them if you wish them to be passed to your application. They  will only remain here for 7 days,
- **Fail** - the message will be marked as failed and will only be recorded in your message history without being sent.





# Developer

## Using the API

The HTTP API allows you to send messages to us using JSON over HTTP. You  can either talk to the API using your current HTTP library or you can  use one of the pre-built libraries.

[Full API documentation](https://apiv1.postalserver.io)

This API does not support managing all the functions of Postal. There are  plans to introduce a new v2 API which will have more functionality and  significantly better documentation. We do not have an ETA for this.  Additionally, we will not be accepting any pull requests to extend the  current API to have any further functionality than it currently does.



### General API Instructions

- You should send POST requests to the URLs shown below.
- Parameters should be encoded in the body of the request and `application/json` should be set as the `Content-Type` header.
- The response will always be provided as JSON. The status of a request can be determined from the `status` attribute in the payload you receive. It will be `success` or `error`. Further details can be found in the `data` attribute.

An example response body is shown below:

```javascript
{
  "status":"success",
  "time":0.02,
  "flags":{},
  "data":{"message_id":"xxxx"}
}
```

To authenticate to the API you'll  need to create an API credential for your mail server through the web  interface. This is a random string which is unique to your server.

To authenticate a request to the API, you need to pass this key in the `X-Server-API-Key` HTTP header.



### Sending a message

There are two ways to send a message - you can either provide each attribute  needed for the e-mail individually or you can craft your own RFC 2822  message and send this instead.

Full details about these two methods can be found in our API documentation:

- Sending a message
- Sending an RFC 2822 message

For both these methods, the API will return the same information as the result. It will contain the `message_id` of the message that was sent plus a `messages` hash with the IDs of the messages that were sent by the server to each recipient.

```javascript
{
  "message_id":"message-id-in-uuid-format@rp.postal.yourdomain.com",
  "messages":{
    "john@example.com":{"id":37171, "token":"a4udnay1"},
    "mary@example.com":{"id":37172, "token":"bsfhjsdfs"}
  }
}
```

------



## Client Libraries

There are a number of client libraries available to help send e-mail using  the Postal platform. These aren't all developed by the Postal team.

- [Ruby](https://github.com/postalserver/postal-ruby)
- [Rails](https://github.com/postalserver/postal-rails)
- [Ruby (mail gem)](https://github.com/postalserver/postal-mailgem)
- [PHP](https://github.com/postalserver/postal-php)
- [Node](https://github.com/postalserver/postal-node)
- [Java](https://github.com/matthewmgamble/postal-java)
- [.Net](https://github.com/KingdomFirst/PostalServer-DotNet-Framework)
- [Go](https://github.com/Pacerino/postal-go)

All of these libraries will make use of the API rather than using any SMTP  protocol - this is considered to be best approach for delivering your  messages.

If your framework makes use of SMTP, you do not need a  client library however you will also miss out on some of Postals  functionality.



## Receiving e-mail by HTTP

One of the most useful features in Postal is the ability to have incoming  messages delivered to your own application as soon as they arrive. To  receive incoming messages from Postal you can set it up to pass them to  an HTTP URL of your choosing.

Each endpoint has an HTTP URL (we  highly recommend making use of HTTPS where possible) as well as a set of rules which defines how data is sent to you.

- You can choose whether data is encoded as normal form data or whether Postal sends JSON as the body of the request.
- You can choose whether to receive the raw message (raw) or have it as a JSON dictionary (processed).
- You can choose whether you'd like replies and signatures to be separated from the plain body of the message.

Your server should accept Postals incoming request and reply within 5  seconds. If it takes longer than this, Postal will assume it has failed  and the request will be retried. Your server should send a `200 OK` status to signal to Postal that you've received the request.

Messages will be tried up to 18 times with an exponential back-off until a successful response is seen except in the case of `5xx` statuses which will fail immediately.

When a message permanently fails to be delivered to your endpoint (i.e. the  server returned a 5xx status code or it wasn't accepted after 18  attempts), the recipient will be sent a bounce message.

You can view the attempts (along with debugging information) on the message page in the web interface.



### The processed payload

When you chose to receive the message as JSON (processed), you'll receive a payload with the following attributes.

```javascript
{
  "id":12345,
  "rcpt_to":"sales@awesomeapp.com",
  "mail_from":"test@example.com",
  "token":"rtmuzogUauKN",
  "subject":"Re: Welcome to AwesomeApp",
  "message_id":"81026759-68fb-4872-8c97-6dd2901cb33a@rp.postal.yourdomain.com",
  "timestamp":1478169798.924355,
  "size":"822",
  "spam_status":"NotSpam",
  "bounce":false,
  "received_with_ssl":false,
  "to":"sales@awesomeapp.com",
  "cc":null,
  "from":"John Doe <test@example.com>",
  "date":"Thu, 03 Nov 2016 10:43:18 +0000",
  "in_reply_to":null,
  "references":null,
  "plain_body":"Hello there!",
  "html_body":"<p>Hello there!</p>",
  "auto_submitted":"auto-reply",
  "attachment_quantity":1,
  "attachments":[
    {
      "filename":"test.txt",
      "content_type":"text/plain",
      "size":12,
      "data":"SGVsbG8gd29ybGQh"
    }
  ]
}
```

- You will only have the `attachments` attribute if you have enabled it.
- The `data` attribute for each attachment is Base64 encoded.



### The raw message payload

When you choose to receive the full message, you will receive the following attributes.

```javascript
{
  "id":12345,
  "message":"REtJTS1TaWduYXR1cmU6IHY9MTsgYT1yc2Etc2hhMjU2Oy...",
  "base64":true,
  "size":859
}
```

- The `base64` attribute specifies whether or not the `message` attribute is encoded with Base64. This is likely to be true all the time.





## Webhooks

Postal supports sending webhooks over HTTP when various events occur during the lifecycle of a message.

This page lists all the different types of event along with an example JSON  payload that you'll receive. In many cases, only a small amount of  information will be sent, if you require more information you should use the API to obtain it.



### Message Status Events

These events are triggered on various events in an e-mail's lifecycle. The  payload format is identical for all messages however the `status` attribute may change. The following statuses may be delivered.

- `MessageSent` - when a message is successfully delivered to a recipient/endpoint.
- `MessageDelayed` - when a message's delivery has been delayed. This will be sent each  time Postal attempts a delivery and a message is delayed further.
- `MessageDeliveryFailed` - when a message cannot be delivered.
- `MessageHeld` - when a message is held.

```javascript
{
  "status":"Sent",
  "details":"Message sent by SMTP to aspmx.l.google.com (2a00:1450:400c:c0b::1b) (from 2a00:67a0:a:15::2)",
  "output":"250 2.0.0 OK 1477944899 ly2si31746747wjb.95 - gsmtp",
  "time":0.22,
  "sent_with_ssl":true,
  "timestamp":1477945177.12994,
  "message":{
    "id":12345,
    "token":"abcdef123",
    "direction":"outgoing",
    "message_id":"5817a64332f44_4ec93ff59e79d154565eb@app34.mail",
    "to":"test@example.com",
    "from":"sales@awesomeapp.com",
    "subject":"Welcome to AwesomeApp",
    "timestamp":1477945177.12994,
    "spam_status":"NotSpam",
    "tag":"welcome"
  }
}
```



### Message Bounces

If Postal receives a bounce message for a message that was previously accepted, you'll receive the `MessageBounced` event.

```javascript
{
  "original_message":{
    "id":12345,
    "token":"abcdef123",
    "direction":"outgoing",
    "message_id":"5817a64332f44_4ec93ff59e79d154565eb@app34.mail",
    "to":"test@example.com",
    "from":"sales@awesomeapp.com",
    "subject":"Welcome to AwesomeApp",
    "timestamp":1477945177.12994,
    "spam_status":"NotSpam",
    "tag":"welcome"
  },
  "bounce":{
    "id":12347,
    "token":"abcdef124",
    "direction":"incoming",
    "message_id":"5817a64332f44_4ec93ff59e79d154565eb@someserver.com",
    "to":"abcde@psrp.postal.yourdomain.com",
    "from":"postmaster@someserver.com",
    "subject":"Delivery Error",
    "timestamp":1477945179.12994,
    "spam_status":"NotSpam",
    "tag":null
  }
}
```



### Message Click Event

If you have click tracking enabled, the `MessageLinkClicked` event will tell you that a user has clicked on a link in one of your e-mails.

```javascript
{
  "url":"https://atech.media",
  "token":"VJzsFA0S",
  "ip_address":"185.22.208.2",
  "user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
  "message":{
    "id":12345,
    "token":"abcdef123",
    "direction":"outgoing",
    "message_id":"5817a64332f44_4ec93ff59e79d154565eb@app34.mail",
    "to":"test@example.com",
    "from":"sales@awesomeapp.com",
    "subject":"Welcome to AwesomeApp",
    "timestamp":1477945177.12994,
    "spam_status":"NotSpam",
    "tag":"welcome"
  }
}
```



### Message Loaded/Opened Event

If you have open tracking enabled, the `MessageLoaded` event will tell you that a user has opened your e-mail (or, at least, have viewed the tracking pixel embedded within it.)

```javascript
{
  "ip_address":"185.22.208.2",
  "user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36",
  "message":{
    "id":12345,
    "token":"abcdef123",
    "direction":"outgoing",
    "message_id":"5817a64332f44_4ec93ff59e79d154565eb@app34.mail",
    "to":"test@example.com",
    "from":"sales@awesomeapp.com",
    "subject":"Welcome to AwesomeApp",
    "timestamp":1477945177.12994,
    "spam_status":"NotSpam",
    "tag":"welcome"
  }
}
```



### DNS Error Event

Postal regularly monitors domains it knows about to ensure that your  SPF/DKIM/MX records are correct. If you'd like to be notified when the  checks fail, you can subscribe to the `DomainDNSError` event.

```javascript
{
  "domain":"example.com",
  "uuid":"820b47a4-4dfd-42e4-ae6a-1e5bed5a33fd",
  "dns_checked_at":1477945711.5502,
  "spf_status":"OK",
  "spf_error":null,
  "dkim_status":"Invalid",
  "dkim_error":"The DKIM record at example.com does not match the record we have provided. Please check it has been copied correctly.",
  "mx_status":"Missing",
  "mx_error":null,
  "return_path_status":"OK",
  "return_path_error":null,
  "server":{
    "uuid":"54529725-8807-4069-ab29-a3746c1bbd98",
    "name":"AwesomeApp Mail Server",
    "permalink":"awesomeapp",
    "organization":"atech"
  },
}
```



# Other Notes

## Auto-Responders & Bounces

When you send an e-mail you may be automatically be sent a bounce message or an auto responder by the destination mail server. These are handled  slightly differently to normal incoming e-mail and it's worth  understanding how these work.

Messages like these aren't usually sent to the e-mail address that sent the message but are sent to the **return path** address. This is an address which Postal assigns to your mail server  and is provided to the destination mail server for the purpose of  sending this type of message. The return to address will be something  like `abcdef@psrp.yourdomain.com`.

If you wish to route mail which is sent to your return path address to your application, you can set up a **return path route**. This is the same as a normal route except you should enter the name as `__returnpath__` and leave the domain field blank. You can only choose HTTP endpoints  for this type of route. Once added, messages sent to your return path  that aren't detected as bounces will be sent to HTTP endpoint you  choose.



### A note about bounces

Messages that Postal detects as being bounces for a message you have already  sent will not be delivered to your return path route. The original  message will be updated and a `MessageBounced` webhook event will be triggered.



## Our container image

This page contains information about how Postal actually is packaged and run within a container.



### Where's the container?

Postal is packaged and hosted at `ghcr.io/postalserver/postal`.

The `latest` tag will always track the `main` branch within the repository and therefore will have the latest copy of the application. It is not recommended to use this tag in production  because you may start using it at any time without noticing.

Each version of Postal will also be tagged, for example, `3.0.0`. We always recommend using a version tag in production. To upgrade, you  simply need to start using the newer version of the container and be  sure to run the `upgrade` command. You can view all the tags which exist [on GitHub](https://github.com/postalserver/postal/pkgs/container/postal) and in [our CHANGELOG](https://github.com/postalserver/postal/blob/main/CHANGELOG.md).



### What processes need to run?

There are 3 processes that need to be running for a successful Postal  installation. All processes are run within the same image (`ghcr.io/postalserver/postal`). The table below identifies the processes.



#### The web server

- **Command:** `postal web-server`
- **Ports:** 5000

This is the main web server that handles all web traffic for Postal's admin  interface and open/click tracking requests. By default, it listens on  port 5000 but this can be configured in the `postal.yml` file by changing the `web_server.default_port` option or setting the `PORT` environment variable.

You can run multiple web servers and load balance between them to add additional capacity for web requests.



#### The SMTP server

- **Command:** `postal smtp-server`
- **Ports:** 25
- **Capabilities required:** `NET_BIND_SERVICE`

This is the main SMTP server for receiving messages from clients and other  MTAs. As with the web server, you can configure this to run on any port  by changing the `smtp_server.default_port` option in the `postal.yml` config file or setting the `PORT` environment variable.

You can run multiple SMTP servers and load balance between them to add additional capacity for SMTP connections.



#### The worker(s)

- **Command:** `postal worker`

This runs a worker which will receive jobs from the message queue.  Essentially, this handles processing all incoming and outgoing e-mail.  If you're needing to process lots of e-mails, you may wish to run more  than one of these. You can run as many of these as you wish.



### Configuration

The image expects all configuration to be mounted at `/config`. At a minimum, this directory must contain a `postal.yml` and a `signing.key`. You can see a minimal example `postal.yml` in the [installation tool repository](https://github.com/postalserver/install/blob/main/examples/postal.v3.yml). For a full example, [see here](https://github.com/postalserver/postal/blob/main/doc/config/yaml.yml).

The `signing.key` can be generated using the following command:

```
openssl genrsa -out path/to/signing.key 2018
```



### Networking

If you wish to utilise IP pools, you will need to run Postal using host  networking. This is because Postal will need to be able to determine  which physical IPs are available to it and be able to send and receive  traffic on those IPs.

If you are not using IP pools, there is no need to use host networking and you can expose the ports listed above as appropriate.



### Waiting for services

The container's entrypoint supports waiting for external services to be  ready before starting the underlying process. To use this you need to  set the `WAIT_FOR_TARGETS` environment variable with a list of services and ports. For example, `mariadb:3306`, replacing `mariadb` with the hostname or IP of your MariaDB server. You can specify multiple endpoint by separating them with a space.

The default maximum time to wait is 30 seconds, you can override this using the `WAIT_FOR_TIMEOUT` environment variable.



## Debugging

This page contains information on how to identify problems with your installation.



### DNS

Whilst Postal can verify DNS records on its own, it can be useful to check what the rest of the internet is seeing.

You can make use of [Whats My DNS](https://whatsmydns.net) for a quick global check or the `dig` command if you have it on a terminal, i.e. `dig txt yourdomain.com` or `dig a yourdomain.com`.



### SMTP

The quickest way to ensure the internet can connect to your Postal SMTP is with `telnet postal.yourdomain.com 25`. You can proceed to attempt sending a message manually if you are  familiar with the raw SMTP commands to further verify your Postal  installation is working correctly.



#### SMTP SSL

If you aren't sure about whether the SSL certificate you have provided to Postal is set up correctly you can use `openssl s_client -connect postal.yourdomain.com:25 -starttls smtp` to get some information about your certificate from the point of view of SMTP.



## Wildcards & Address Tags

Postal supports the use of wildcards and address tags in routes.



### Using a wildcard

Wildcards will allow you to receive all e-mail for every address on a domain.  However, for most use cases, this isn't recommended because it means  that large volumes of spam may be processed by your mail server that  would otherwise have been rejected by Postal without troubling you.

Just enter `*` in the name box to create a route for this.



### Using address tags

Postal supports the use of "tags" on e-mail addresses which means you can add a single route but still receive from multiple addresses. For example, if you add a route for `email` you will also receive messages for `email+anything@yourdomain.com` without any additional configuration.



aaaaaaaaaaaaaa

