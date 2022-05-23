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



在 `filebrowser` 根目录中新生成的 `filebrowser.db` 文件一看就是一个数据库文件。

这个文件好像不是我们常见的比如 `SQLite` 之类的文件格式，而且直接用文本编辑器打开也会乱码无法查看。

不过我们可以使用如下命令来查看这个数据库文件。

```
filebrowser.exe config cat
```

输出结果可能是这样的。

```
Sign up:          false
Create User Dir:  false
Auth method:      json
Shell:              

Branding:
  Name:                    
  Files override:          
  Disable external links:  false
  Color:                   

Server:
  Log:           stdout
  Port:          8080
  Base URL:      
  Root:          .
  Socket:        
  Address:       127.0.0.1
  TLS Cert:      
  TLS Key:       
  Exec Enabled:  false

Defaults:
  Scope:         .
  Locale:        en
  View mode:     mosaic
  Single Click:  false
  Commands:      
  Sorting:
    By:   
    Asc:  false
  Permissions:
    Admin:     false
    Execute:   true
    Create:    true
    Rename:    true
    Modify:    true
    Delete:    true
    Share:     true
    Download:  true

Auther configuration (raw):

{
  "recaptcha": null
}
```



细心的小伙伴可能会发现，哎，怎么输出结果中的地址和端口仍然是默认值呢？

实际上它就是包含默认值的一个数据库文件，如果想要改变这些默认值，那么就要用到下面的命令了。

```
filebrowser.exe config set [flags]
```

比如，我们想将侦听地址修改为 `0.0.0.0` ，那么我们应该这样做。

```
filebrowser.exe config set -a 0.0.0.0
```

命令执行成功后直接输出 `filebrowser.db` 的内容结果。

图c01



那么，修改端口怎么做呢？

```
filebrowser.exe config set -p 8888
```

很简单，对吧？

当然你完全可以将想要修改的参数都放在一条命令行上。

```
filebrowser.exe config set -a 0.0.0.0 -p 8888
```



所以你看，其他参数也是以此类推，具体可以查看帮助信息。

```
filebrowser.exe config set --help
```



有一点需要小伙伴们注意，在执行修改默认配置命令时，必须先退出正在运行的 `filebrowser` 服务，否则会报错失败的哦！

OK，我们将 `filebrowser.json` 这个前面我们手动设定的配置文件移动到其他地方，或者删除它，或者重命名它，总之就是要让它失效。

接下来我们就直接运行 `filebrowser` 并且不带任何参数看看。

```
filebrowser.exe
```

果然，看到 `No config file used` 字样没？

我们修改过的数据库文件 `filebrowser.db` 生效了，我们不再需要手动指定参数，也不再需要手动撸一个 `json` 配置文件，就可以做到在 `0.0.0.0:8888` 这个地址上跑服务了。

图c02



文件管理







用户管理

依次找到左侧导航栏 `设置` > `用户管理` > `新建` 。



















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



