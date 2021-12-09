仅一条命令实现文件传输，真实上演在公司 Ctrl+C 在家 Ctrl+V（下）

副标题：

英文：

关键字：



“不行！我们还是跑吧！”

顶哥正用一双充满恐惧的眼睛盯着我，我下意识地一哆嗦。



不知道是从何时起，我稀里糊涂地入职了现在这家名不见经传的只有几个人的小公司。

直到今天我也不知道这家公司到底是干什么的，只知道他们招收程序员，估计是干代码板砖的活儿。

和我唯一混熟的就只有眼前这位顶哥，大名谢顶顶，40+的年龄，重点网红985毕业，曾在某大厂工作过，只因年龄优化才委身来这小破公司做技术。

顶哥比我早来几个月，很明显他早已清楚这家公司是干什么的，还多次极力劝我离开。

可是这次却与以往大不一样了......



“真要跑了，老板绝对不会放过我们的！”，我有点害怕。

顶哥似乎坚定了信心：“兄弟，你不像我，你还年轻，35岁之前肯定还是有机会的。”

“顶哥，我34了！”，我翻了个白眼。

“那你为什么要来这儿，他们这是违法的勾当！”

“违法？不就是让我们来写代码的吗？能有什么问题？”

“兄弟啊，别听他们忽悠，他们就是利用了我们这种心理。他们将我们开发的APP用于诈骗获利，你说他们是不是违法！”

“技术无罪，我又没有参与诈骗，不算违法吧！前台的小红不也和我差不多时间进来的嘛，她就每天给客户打个电话，也算是犯罪？”

“狡辩！最近我看过一些新闻，警方对通过APP实施诈骗的行为也做为犯罪行为大力打击。”，不知怎的，顶哥突然甩了甩仅有的几根头发，“兄弟，哥比你痴长几岁，就听哥一句劝，今晚咱就跑吧！”



最终我还是听了顶哥的话，可是，老板随时都会知道人跑了，到时被他找到我们，我们可就惨了！

于是顶哥和我商量，决定将这里的犯罪证据带走，然后交给警方。

可是问题又来了，监控之下屋里的电脑没办法堂而皇之地拿出去，而我们又没有 `U` 盘之类的移动设备，这可怎么办呢？



很快，顶哥说他有主意了，公司的电脑都是联外网的，有办法将文件发出去。

我说哥啊，你要是在电脑里留下痕迹，那老板肯定很发现的。

顶哥说没事，他有办法用一条命令搞定文件发送！

要不怎么说顶哥是个老鸟，由他带我飞可放心多了，不过这一条命令就能搞定文件发送？



到了半夜里，夜深人静，我们终于开始行动了！

顶哥说，至少有两个地方保存着关键资料，一个是里屋的 `Linux` 服务器上，还一个是他写代码用的自己的电脑上。

我们先来到了服务器面前，面对着黑漆漆的屏幕，顶哥真的用一条命令就将文件发送了出去。

得益于平日养成的良好的版本管理和备份习惯，整个资料都早已经打包成 `app.zip` 了。

```shell
# 使用 cURL 上传文件
$ curl --upload-file ./app.zip https://transfer.sh/app.zip

# ↓ 返回用于下载的链接信息
https://transfer.sh/ST8gyt/app.zip
```



顶哥说：“看见没有，赶快用手机，把输出链接拍下来。”

我突然明白了，这个输出链接可以用于在其他任何联网电脑上下载刚才上传的文件。

为了擦掉使用命令的痕迹，我们又清除了刚才的 `history` 历史命令。



接下来还有一部分证据资料没有完全上传到服务器上，还留在了开发电脑上。

我们转身来到顶哥那台电脑前，这台电脑是 `Windows 10` 系统。

我问顶哥，`Win10` 也能一条命令发送文件吗？

顶哥说当然，`Win10` 已经自带有 `cUrl` 命令了。

如法炮制，我们又很顺利地将文件传了出去。











`transfer.sh`



使用 `cURL` 上传文件

```
# 使用 cURL 上传文件
$ curl --upload-file ./hello.txt https://transfer.sh/hello.txt

# ↓ 返回用于下载的链接信息
https://transfer.sh/RT9fzc/hello.txt
```



使用 `Shell` 函数上传文件

```
# 使用 Shell 函数上传文件
$ transfer hello.txt
##################################################### 100.0%

# ↓ 返回用于下载的链接信息
https://transfer.sh/i4Ejz8/hello.txt
```



使用 `Web` 浏览器上传文件

```
# 使用Web浏览器上传文件
Drag your files here, or click to browse.
```







* Made for use with shell
* Share files with a URL
* Unlimited upload
* Files stored for 336h0m0s
* For free
* Encrypt your files
* Maximize amount of downloads





给定一些上传条件。

```
# 最大下载数：1个 ,最大保留日期：5天，
$ curl -H "Max-Downloads: 1" -H "Max-Days: 5" --upload-file ./hello.txt https://transfer.sh/hello.txt

# ↓ 返回用于下载的链接信息
https://transfer.sh/RT9fzc/hello.txt

# Download the file
$ curl https://transfer.sh/RT9fzc/hello.txt -o hello.txt
```





在 `.bashrc` 或 `.zshrc` 中创建一个 `Shell` 函数。

```
# Add this to .bashrc or .zshrc or its equivalent
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;}
```

上面的代码怎么感觉乱乱的哈，其实它是将函数代码写成了一行。

嗯，空格和回车啥时候这么值钱了？

反正将这些代码复制粘贴后，保存并将文件名命名为 `transfer` 即可。

哦，对了，别忘记给它赋予执行权限哦。

```
$ sudo chmod +x transfer
```



好了，现在就可以用这个 `Shell` 函数自由地上传文件了。

```
# Now you can use transfer function
$ transfer hello.txt
```





同时上传多个文件。

```
$ curl -i -F filedata=@/tmp/hello.txt -F filedata=@/tmp/hello2.txt https://transfer.sh/

# Combining downloads as zip or tar archive
$ curl https://transfer.sh/(RT9fzc/hello.txt,i4Ejz8/world.txt).tar.gz
$ curl https://transfer.sh/(RT9fzc/hello.txt,i4Ejz8/world.txt).zip
```





在传输之前使用 `gpg` 加密文件。

```
# Encrypt files with password using gpg
$ cat /tmp/hello.txt|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt

# Download and decrypt
$ curl https://transfer.sh/RT9fzc/test.txt|gpg -o- > /tmp/hello.txt
```





扫描病毒

```
# Scan for malware or viruses using Clamav
$ wget http://www.eicar.org/download/eicar.com
$ curl -X PUT --upload-file ./eicar.com https://transfer.sh/eicar.com/scan

# Upload malware to VirusTotal, get a permalink in return
$ curl -X PUT --upload-file nhgbhhj https://transfer.sh/test.txt/virustotal
```





备份并加密 `mysql` 数据库后传输。

```
# Backup, encrypt and transfer
$ mysqldump --all-databases|gzip|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt
```





带上传输链接发送邮件（使用 `Shell` 函数）

```
# Transfer and send email with link (uses shell function)
$ transfer /tmp/hello.txt | mail -s "Hello World" user@yourmaildomain.com
```



使用 `Keybase.io`

```
# Import keys from keybase
$ keybase track [them]
# Encrypt for recipient(s)
$ cat somebackupfile.tar.gz | keybase encrypt [them] | curl --upload-file '-' https://transfer.sh/test.txt
# Decrypt
$ curl https://transfer.sh/RT9fzc/test.md |keybase decrypt
```



还可以用 `wget` 上传文件

```
# wget
$ wget --method PUT --body-file=/tmp/file.tar https://transfer.sh/file.tar -O - -nv
```



Transfer pound logs

```
# grep syslog for pound and transfer
$ cat /var/log/syslog|grep pound|curl --upload-file - https://transfer.sh/pound.log
```





用 `Powershell` 玩上传

```
# Upload using Powershell
PS H:\> invoke-webrequest -method put -infile .\file.txt https://transfer.sh/file.txt
```



用 `HTTPie` 玩上传

```
# HTTPie
$ http https://transfer.sh/ -vv < /tmp/test.log
```





Upload a file using Unofficially client in Python

```
# transfersh-cli (https://github.com/tanrax/transfersh-cli)
$ transfersh photos.zip
# Uploading file
# Download from here: https://transfer.sh/RT9fzc/photos.zip
# It has also been copied to the clipboard!
```



Encrypt your files with openssl before the transfer

```
# Encrypt files with password using openssl
$ cat /tmp/hello.txt|openssl aes-256-cbc -pbkdf2 -e|curl -X PUT --upload-file "-" https://transfer.sh/test.txt

# Download and decrypt
$ curl https://transfer.sh/RT9fzc/test.txt|openssl aes-256-cbc -pbkdf2 -d > /tmp/hello.txt
```



Upload a file or directory in Windows

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

