filebrowser.org

副标题：

英文：

关键字：









### 安装



打开 `PowerShell` ，输入以下命令。

```powershell
# 下载 filebrowser
iwr -useb https://raw.githubusercontent.com/filebrowser/get/master/get.ps1 | iex

# 启动 filebrowser
filebrowser -r /path/to/your/files
```



启动完毕后，程序给出访问地址。

图



初次使用 `filebrowser` 是以默认配置运行的，因此最初登录时我们需要用到以下默认用户名和密码。

* 用户名：`admin`
* 密码：`admin`



为了保证系统安全，我们经常习惯性地将默认登录密码改掉。

光密码改掉还不保险，那就连用户名也一起改掉，这样就不好猜更安全一点了吧？

实际上官方建议除此之外，最好参考一下命令行配置内容，可以让 `filebrowser` 使用起来更加安全。

怎么配置呢？

我们往下看！





### 配置



查看帮助信息。

```
filebrowser.exe --help
```



不带任何参数，直接启动看看。

```
filebrowser.exe
```

图b02



它会提示没有指定配置文件，并且服务在 `127.0.0.1:8080` 上侦听。

我们打开浏览器来试试看能不能访问，`filebrowser` 本质上就是一个 `Web` 服务器。

```
http://127.0.0.1:8080
```

图b03



果然顺利打开了 `filebrowser` 的登录页面，接着我们输入用户名和密码（都是 `admin` ）。

OK，看到了 `filebrowser` 所在当前目录的文件了。

图b04



细心的小伙伴可能会发现，好像多出来一个文件 `filebrowser.db` ！

没错，这就是数据库文件，在我们没有给它指定的时候，它就会自动创建一个。

但是吧，从页面上看，怎么时间好像不对劲啊，不知道是不是 `BUG` 。

从文件管理器中查看是正常的，的确是刚刚服务启动时创建的。

图b05



接下来我们应该做点什么呢？

这个界面是英文的，总感觉不舒服啊，改了吧！

点击左侧导航栏的 `Settings` ，然后找到 `Language` 一项将其改成中文，最后点击 `Update` 按钮使之生效。

图b06



界面一下子清爽多了，那么紧接着别忘记修改密码哦！

依次找到左侧导航栏的 `设置` > `个人设置` > `更改密码` 。

图b09



前面我们只能用本地回环地址在本机上访问 `filebrowser` ，要想让其他人访问到，那么我们需要加一个参数。

```
filebrowser.exe -a 0.0.0.0
```

图b07



另找一台电脑打开浏览器，试试能不能访问。

这里请注意哈，端口仍然是 `8080` 哦！

```
# x.x.x.x为filebrowser所在电脑的IP地址
http://x.x.x.x:8080
```



要想修改成自己想要的端口，那么再加上一个参数 `-p` 。

```
filebrowser.exe -a 0.0.0.0 -p 8888
```

图b08



嗯，还算简单吧。

不过可能有的小伙伴比我懒得多，这每天都要打参数多麻烦啊！

好的宝贝，我懂了！

来，我们在 `firebrowser` 的根目录下新建一个文本文件，然后输入以下代码，并给它起个好看又好听的名字`.filebrowser.json` 。

```json
{
	"address": "0.0.0.0",
	"port": "8888"
}
```



注意哦，两点！

一是这是个 `json` 文件格式，第行参数最后别忘记加上一个逗号（最后一行可省略）。

二是文件名最前面有一个英文句号（就是一个点），`.filebrowser.json` ，这样的写法实际上在 `Linux` 系统中是指隐藏文件的意思。

好了，启动服务看看效果，再也不用手输参数啦，棒棒哒！

图b10









```
File Browser CLI lets you create the database to use with File Browser,
manage your users and all the configurations without acessing the
web interface.

If you've never run File Browser, you'll need to have a database for
it. Don't worry: you don't need to setup a separate database server.
We're using Bolt DB which is a single file database and all managed
by ourselves.

For this specific command, all the flags you have available (except
"config" for the configuration file), can be given either through
environment variables or configuration files.

If you don't set "config", it will look for a configuration file called
.filebrowser.{json, toml, yaml, yml} in the following directories:

- ./
- $HOME/
- /etc/filebrowser/

The precedence of the configuration values are as follows:

- flags
- environment variables
- configuration file
- database values
- defaults

The environment variables are prefixed by "FB_" followed by the option
name in caps. So to set "database" via an env variable, you should
set FB_DATABASE.

Also, if the database path doesn't exist, File Browser will enter into
the quick setup mode and a new database will be bootstraped and a new
user created with the credentials from options "username" and "password".

Usage:
  filebrowser [flags]
  filebrowser [command]

Available Commands:
  cmds        Command runner management utility
  config      Configuration management utility
  hash        Hashes a password
  help        Help about any command
  rules       Rules management utility
  upgrade     Upgrades an old configuration
  users       Users management utility
  version     Print the version number

Flags:
  -a, --address string                     address to listen on (default "127.0.0.1")
  -b, --baseurl string                     base url
      --cache-dir string                   file cache directory (disabled if empty)
  -t, --cert string                        tls certificate
  -c, --config string                      config file path
  -d, --database string                    database path (default "./filebrowser.db")
      --disable-exec                       disables Command Runner feature
      --disable-preview-resize             disable resize of image previews
      --disable-thumbnails                 disable image thumbnails
      --disable-type-detection-by-header   disables type detection by reading file headers
  -h, --help                               help for filebrowser
      --img-processors int                 image processors count (default 4)
  -k, --key string                         tls key
  -l, --log string                         log output (default "stdout")
      --noauth                             use the noauth auther when using quick setup
      --password string                    hashed password for the first user when using quick config (default "admin")
  -p, --port string                        port to listen on (default "8080")
  -r, --root string                        root to prepend to relative paths (default ".")
      --socket string                      socket to listen to (cannot be used with address, port, cert nor key flags)
      --socket-perm uint32                 unix socket file permissions (default 438)
      --username string                    username for the first user when using quick config (default "admin")

Use "filebrowser [command] --help" for more information about a command.
```

















### `Docker` 下使用 `filebrowser`





```
docker run \
    -v /path/to/root:/srv \
    -v /path/to/filebrowser.db:/database/filebrowser.db \
    -v /path/to/settings.json:/config/settings.json \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -p 8080:80 \
    filebrowser/filebrowser:s6
```



默认情况下 `filebrowser` 已经自带了一个有默认参数的配置文件，因此我们可以只挂载根目录和数据库即可。

当然了，你也可以自定义一个配置文件，里面放上你希望的一些参数。

此外，即使你没有数据库文件（比如 `filebrowser.db` ）也务必给它指定一个空白的数据库文件，否则的话会导致程序出错。

原因是此 `Docker` 镜像会在没有被指定数据库文件的情况下自行创建一个空目录而不是一个空文件，这个 `BUG` 似乎有点奇怪！



