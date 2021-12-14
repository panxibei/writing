自己动手搭建超酷文件传输服务 Transfer.sh

副标题：

英文：

关键字：



自己动手搭建超酷文件传输服务 Transfer.sh



在 `C` 盘根目录下新建一个文件夹 `tmp` 。

```
mkdir C:\tmp
```



然后按照以下参数启动服务。

```
transfersh-v1.3.0-windows-amd64.exe ^
	--provider=local ^
	--listener :80 ^
	--temp-path=/tmp/ ^
	--basedir=C:\tmp\
```



* `--provider=local`

  实际临时文件存放到本地。

* `--listener :80`

  `transfer.sh` 服务开启 `80` 端口侦听。

* `--temp-path=/tmp/`

  `transfer.sh` 服务内部的临时文件夹为 `/tmp/` 。

* `--basedir=C:\tmp\`

  设定本地文件夹 `C:\tmp\` 与服务内部目录 `/tmp/` 相互映射，作为临时文件存放地。



注意，在命令执行前请确保服务器端口已在防火墙中开放。

好了，命令执行后服务就开始运行了。

图a05



这个时候，我们打开浏览器，在地址栏内输入 `http://服务端的IP` 后回车。

我们会惊喜地发现，我们自己的 `transfer.sh` 服务器已经在正常运行中了。

图a06



我们可以看到，虽然与官方首页长得挺像，但里面的命令参数或链接都变成了我们自己服务器的IP地址了。

当然如果我们使用域名方式访问服务器也是可以的，只要保证能够正常解析域名即可，那样的话我们看到的页面上就是服务器的域名了。

接下来我们就试一下，看看能不能拿来传输文件。



假定有一个文件 `hello.txt` ，输入以下命令，我们将这个文件上传到服务器。

```
curl --upload-file ./hello.txt http://服务器IP/hello.txt
```

图a07



从返回的结果中我们得到了一个下载链接，比如：

```
http://服务器IP/5liLmu/hello.txt
```



我们回到服务端来看看有没有什么变化。

嘿，果不其然，在服务端指定的本地文件夹 `C:\tmp` 中新生成了一个 `5liLmu` 的文件夹。

并且这个文件夹的名字与我们刚才上传时生成的随机字符串一致。



好，我们再来看看文件上传之后到底是怎么存放的。

原来只有两个文件，一个就是我们上传的文件，另一个是以 `metadata` 为后缀的元数据文件。

图a08



让我们看看这个 `metadata` 里面到底是什么东东。

用记事本打开它，可以看到如下的内容。

```
{
	"ContentType":"text/plain; charset=utf-8",
	"Downloads":0,
	"MaxDownloads":-1,
	"MaxDate":"0001-01-01T00:00:00Z",
	"DeletionToken":"7vEDa9tajs8U"
}
```

这个格式有点眼熟啊，感觉就是个 `Json` 格式嘛！

当然了，实际上以上内容是写在一行的，为了大家查看方便直观稍稍换了行。

这个 `Json` 就是以 `key-value` 的形式保存的数据信息，那么具体各个 `key` 的意思我想小伙伴大概能了解了吧。

比如 `MaxDonloads` 它的值是 `-1` ，表示无限下载。

这里有一个比较有趣的 `key` ，就是那个 `DeletionToken` ，后面跟着一串奇怪的字符。

这个又是什么意思呢？



从字面意思我们也能猜出个八九不离十，就是删除令牌啊！

那么它就是用于删除我们上传文件的。



### 如何删除我们上传的文件呢

其实我们通过上传命令中追加 `-H "X-Url-Delete"` 参数即可从客户端获取删除令牌。

```
# -I 用于查看返回信息
curl -I -H "X-Url-Delete" --upload-file ./hello.txt http://server_ip/hello.txt
```



从图中我们就可以从返回信息中看到一行带有删除令牌的信息。

没错，那最后一串奇怪的字符就是删除令牌了。

```
X-Url-Delete: http://server_ip/0czFd5/hello.txt/NcPETCcGExW2
```

图a09



然后，怎么删？

很简单，拿刚才的令牌信息，照抄下面的命令就行了。

```
curl -X http://server_ip/0czFd5/hello.txt/NcPETCcGExW2
```

