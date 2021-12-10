仅一条命令实现文件传输，真实上演在公司 Ctrl+C 在家 Ctrl+V（下）

副标题：通过简易命令行分享文件~

英文：file-transfer-with-only-one-command-ctrl-c-in-company-and-ctrl-v-at-home

关键字：sharing,file,command,transfer,transfer.sh,shell,function,共享,传输



前几天做的恶梦至今挥之不去，我仍然清楚地记得梦中那一行命令代码以及手机上的那个神秘下载链接。

于是我今天又坐到了电脑前面，打算进一步探究一下这个神秘的文件传输网站。



我小心翼翼地在地址栏内输入 `transfer.sh` ，然后回车。

```
https://transfer.sh/
```

很快打开了一个很页面简单的网页。

图b01



还真的有这样一个网站啊！

虽然我已经做到了心中有数，但还是有点小吃惊。

摸索了一会儿，我终于懂了，这个网站就是提供共享服务，专门用来传输文件的！

而文件传输的方式使用的却是命令行方式。



用命令行方式来传输文件，有什么用？

当然有用了，很多场景下，用命令行可比图形操作来得更方便些啊！

比如，`Linux` 服务器上想传个文件到自己电脑上，那么可以这样做。

```
# 使用 cURL 上传文件
$ curl --upload-file ./hello.txt https://transfer.sh/hello.txt

# ↓ 返回用于下载的链接信息
https://transfer.sh/RT9fzc/hello.txt
```



然后我们再跑到自己的电脑上，输入上面的下载链接即可获取到这个文件。

很显然，在没有图形界面或是图形操作不方便的情况下，使用命令方式传文件也是可行的。

那这个 `transfer.sh` 能保证文件安全吗，可以传多大文件，又保留多久呢？



嗯，针对这些问题，官网上也有说明，总结如下。

* 可以定制 `Shell` 函数
* 使用 `URL` 形式分享文件
* 无限上传
* 文件保留 `336` 小时
* 免费
* 可加密文件
* 最大量化下载



而网页上就是罗列介绍了一些基本的命令行方式来传输文件的方法。

















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

