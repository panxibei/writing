仅一条命令实现文件传输，真实上演在公司 Ctrl+C 在家 Ctrl+V（下）

副标题：通过简易命令行分享文件~

英文：file-transfer-with-only-one-command-ctrl-c-in-company-and-ctrl-v-at-home-2

关键字：sharing,file,command,transfer,transfer.sh,shell,function,共享,传输



前几天晚上做的恶梦至今仍挥之不去，我依然清楚地记得梦中那一行命令代码以及手机上的神秘下载链接。

于是我今天又坐到了电脑前面，打算一探究竟，揭开梦中那个网站的神秘面纱。



> 前文参考：《仅一条命令实现文件传输，真实上演在公司 Ctrl+C 在家 Ctrl+V（上）》
>
> 文章链接：https://www.sysadm.cc/index.php/xitongyunwei/896-file-transfer-with-only-one-command-ctrl-c-in-company-and-ctrl-v-at-home-1



我试着回忆了一下，想起了那个名字，小心翼翼地在地址栏内输入 `transfer.sh` ，然后轻轻地回车。

```
https://transfer.sh/
```

没想到很快打开了一个页面简单的网页。

图01



还真的有这样一个网站啊！

虽然我已经做到了充分的心理准备，但多多少少还是有点小吃惊。

摸索了一会儿，我终于懂了，这个网站就是提供共享服务，专门用来传输文件的！

而令人称奇的是，文件传输方式只是命令行，而且只用一条命令搞定一切。



嗯？用命令行方式来传输文件，有什么用，不麻烦吗？

当然有用了，在很多场景下，用命令行可比图形操作可能来得更方便些！

比如，`Linux` 服务器上想传个文件到自己电脑上，那么可以这样做。

```
# 使用 cURL 上传文件
$ curl --upload-file ./hello.txt https://transfer.sh/hello.txt

# ↓ 返回用于下载的链接信息
https://transfer.sh/RT9fzc/hello.txt
```

图02



然后我们再跑到自己的电脑上，输入上面的下载链接即可获取到这个文件了。

图03



很显然，在没有图形界面或是图形操作不方便的情况下，使用命令方式传文件也是完全可行的。

那这个 `transfer.sh` 能保证文件安全吗，可以传多大文件，又能保留多久呢？

经过我一番调查研究，现在我就将我了解到的内容和小伙伴们分享一下吧。



嗯，针对前面提到的这些问题，官网上也有说明，大概总结如下。

* 可以定制 `Shell` 函数
* 使用 `URL` 形式分享文件
* 无限上传
* 文件保留 `336` 小时
* 完全免费
* 可加密文件
* 最大量化下载
* 支持 `Amazon S3` , `Google Drive` , `Storj`及本地文件系统



好吧，我们先来看看网页上罗列的一些基于命令行的其他用法。



### 一些好玩的用法

##### 使用 `Shell` 函数上传文件

注意，以下命令行里的 `transfer` 是个自定义函数，具体代码后面就有。

```
# 使用 Shell 函数上传文件
$ transfer hello.txt
##################################################### 100.0%

# ↓ 返回用于下载的链接信息
https://transfer.sh/i4Ejz8/hello.txt
```



**1、在 `Linux` 上我们可以这样写 `transfer` 函数**

在 `.bashrc` 或 `.zshrc` 中创建一个 `Shell` 函数。

```
# Add this to .bashrc or .zshrc or its equivalent
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;}
```

上面的代码怎么感觉乱乱的哈，其实它是将函数代码写成了一行。

嗯，空格和回车啥时候这么值钱了？

反正将这些代码复制粘贴后，保存并将文件名命名为 `transfer` 即可。

哦，对了，别忘记给它赋予执行权限哦！

```
$ sudo chmod +x transfer
```



好了，现在就可以用这个 `Shell` 函数自由地上传文件了。

```
# Now you can use transfer function
$ transfer hello.txt
```



**2、`Windows` 上我们可以这样写 `transfer` 函数**

`Win10` 已经自带有 `cUrl` 命令了，所以可以直接用 `cUrl` 来传输文件。

不过也可以通过官方示例的代码自定义 `transfer` 函数。

将下例代码（第一行去掉）保存为一个批处理文件，比如 `transfer.cmd` 。

```
#Save this as transfer.cmd in Windows 10 (which has curl.exe)
@echo off
setlocal EnableDelayedExpansion EnableExtensions
goto main
:usage
  echo No arguments specified. >&2
  echo Usage: >&2
  echo   transfer ^<file^|directory^> >&2        
  echo   ... ^| transfer ^<file_name^> >&2       
  exit /b 1
:main
  if "%~1" == "" goto usage
  timeout.exe /t 0 >nul 2>nul || goto not_tty
  set "file=%~1"
  for %%A in ("%file%") do set "file_name=%%~nxA"
  if exist "%file_name%" goto file_exists
    echo %file%: No such file or directory >&2
    exit /b 1
:file_exists
  if not exist "%file%\" goto not_a_directory
  set "file_name=%file_name%.zip"
  pushd "%file%" || exit /b 1
  set "full_name=%temp%\%file_name%"
  powershell.exe -Command "Get-ChildItem -Path . -Recurse | Compress-Archive -DestinationPath ""%full_name%"""
  curl.exe --progress-bar --upload-file "%full_name%" "https://transfer.sh/%file_name%"
  popd
  goto :eof
:not_a_directory
  curl.exe --progress-bar --upload-file "%file%" "https://transfer.sh/%file_name%"
  goto :eof
:not_tty
  set "file_name=%~1"
  curl.exe --progress-bar --upload-file - "https://transfer.sh/%file_name%"
  goto :eof
```



##### 给定一些上传条件

```
# 最大下载数：1个，最大保留日期：5天
$ curl -H "Max-Downloads: 1" -H "Max-Days: 5" --upload-file ./hello.txt https://transfer.sh/hello.txt

# ↓ 返回用于下载的链接信息
https://transfer.sh/RT9fzc/hello.txt

# 下载这个文件
$ curl https://transfer.sh/RT9fzc/hello.txt -o hello.txt
```



##### 同时上传多个文件

```
# 用 -F 指定多个文件
$ curl -i -F filedata=@/tmp/hello.txt -F filedata=@/tmp/hello2.txt https://transfer.sh/

# 下载的同时可打包成 zip 或 tar 文件
$ curl https://transfer.sh/(RT9fzc/hello.txt,i4Ejz8/world.txt).tar.gz
$ curl https://transfer.sh/(RT9fzc/hello.txt,i4Ejz8/world.txt).zip
```



##### 在传输之前使用 `gpg` 加密文件

```
# 使用 gpg 加密文件，密码在 /tmp/hello.txt 中
$ cat /tmp/hello.txt|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt

# 下载并解密
$ curl https://transfer.sh/RT9fzc/test.txt|gpg -o- > /tmp/hello.txt
```



##### 还可以上传文件扫描病毒

```
# 使用 Clamav 扫描病毒或恶意软件
$ wget http://www.eicar.org/download/eicar.com
$ curl -X PUT --upload-file ./eicar.com https://transfer.sh/eicar.com/scan

# 将恶意软件上载到 VirusTotal，返回永久链接
$ curl -X PUT --upload-file nhgbhhj https://transfer.sh/test.txt/virustotal
```



##### 备份并加密 `mysql` 数据库后再传输

```
# 备份，加密并传输
$ mysqldump --all-databases|gzip|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt
```



##### 带上传输链接发送邮件（使用 `Shell` 函数）

```
# Transfer and send email with link (uses shell function)
$ transfer /tmp/hello.txt | mail -s "Hello World" user@yourmaildomain.com
```



##### 使用 `Keybase.io`

```
# 从 keybase 导入密钥
$ keybase track [them]

# 给接受方加密
$ cat somebackupfile.tar.gz | keybase encrypt [them] | curl --upload-file '-' https://transfer.sh/test.txt

# 解密
$ curl https://transfer.sh/RT9fzc/test.md |keybase decrypt
```



##### 当然用 `wget` 上传文件也是可以的，不一定要 `curl`

```
# wget
$ wget --method PUT --body-file=/tmp/file.tar https://transfer.sh/file.tar -O - -nv
```



##### 传输持续输出的日志文件

```
# grep syslog for pound and transfer
$ cat /var/log/syslog|grep pound|curl --upload-file - https://transfer.sh/pound.log
```



##### 用 `Powershell` 照样可以玩上传

```
# Upload using Powershell
PS H:\> invoke-webrequest -method put -infile .\file.txt https://transfer.sh/file.txt
```



##### 用 `HTTPie` 玩上传

```
# HTTPie
$ http https://transfer.sh/ -vv < /tmp/test.log
```



##### 用第三方的 `Python` 客户端上传

```
# transfersh-cli (https://github.com/tanrax/transfersh-cli)
$ transfersh photos.zip

# Uploading file
# Download from here: https://transfer.sh/RT9fzc/photos.zip
# It has also been copied to the clipboard!
```



##### 传输前使用 `openssl` 加密文件

```
# Encrypt files with password using openssl
$ cat /tmp/hello.txt|openssl aes-256-cbc -pbkdf2 -e|curl -X PUT --upload-file "-" https://transfer.sh/test.txt

# Download and decrypt
$ curl https://transfer.sh/RT9fzc/test.txt|openssl aes-256-cbc -pbkdf2 -d > /tmp/hello.txt
```



##### 使用 `Web` 浏览器上传文件

最后，如果你感觉前面的好麻烦啊，那就打开浏览器，点击 `click to browse` 后浏览文件即可，不过这就不是命令行方式了。

```
# 使用Web浏览器上传文件
Drag your files here, or click to browse.
```

图04



### 写在最后

在现今的网络时代，通常还有不少人用邮件甚至是U盘传输着文件。

当然在中国可能大家也用微信或其他的社交软件充当文件传输工具。

可是如果你仔细观察，就会发现这些东西的本质并不是用来传文件的，而且体验也不是很好。

比如，你要分享文件给多个人，但又想保密不让更多的人知道，那么 `transfer.sh` 就可以实现多人下载，并且只有知道密码的人才能下载。

而邮件也好、微信也罢，好像没有这么灵活吧！

因此，如果你经常有文件传输的需求，而且对传输过程或都说效果还有点小要求，那么可以来关注一下这个神秘的 `transfer.sh` 。

最后还要告诉小伙伴们一件事，这个 `transfer.sh` 还是个开源项目，下期有空的话，我也会尝试搭建一个自己用的私人 `transfer.sh` ，到时会将这个过程分享给大家。

自己可以随时 `transfer.sh` ，想想就很棒啊，小伙伴们赶快尝试一下吧！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc

