UrBackup Server 2.4.x 管理手册中文版（三）安装客户端

副标题：安装客户端~

英文：administration-manual-for-urbackup-server-3

关键字：administration,manual,urbackup,backup,server,client



前一篇我们介绍了 `UrBackup` 服务端的安装，与之相对我们今天要介绍的客户端安装就要简单得多了。

如果你是在 `Windows` 下安装 `UrBackup` 客户端，那基本不需要了解什么操作知识就可以直接上手了。

不过，由于 `UrBackup` 是开源支持多平台的特性，所以也有必要介绍一下在除 `Windows` 平台下的安装方法。

此外，还有在面对批量用户的情况下，应该考虑批量自动的处理方法。

OK，我们一起来学习一下！



### 3 客户端的安装

##### 3.1 Windows 客户端安装

如果你打算在与服务端相同子网的网络中使用客户端，或者客户端在设置期间位于本地网络中，那么可以这样来安装客户端。

- 从 `http://www.urbackup.org` 下载客户端程序。
- 运行安装程序。
- 保留备份项目的默认值，手动选择备份路径或从服务器配置客户端（参见第 `9.3.4` 节）。
- 服务器会自动发现客户端并开始备份。



如果客户端只能通过 `Internet` 或 `NAT` 等非本地网络的方式访问，那么可以这样安装客户端。

- 打开 `Web` 管理界面，在状态页面上添加一个新的 `Internet` 客户端。

  图01

  图02

  

- 从网上下载到客户端上并安装。

  或者，为新客户端创建一个帐户（在 `Web` 界面的 `设置` > `用户` 中）并将 `用户名/密码` 发送给客户端的用户（注意，用户名大小写敏感）。

  然后，用户就可以从服务端状态页面上下载客户端安装程序并进行安装。

  **注意，经过测试，从服务端状态页面并不能找到可下载的客户端程序。**

  

- 在客户端上选择所需备份路径或在服务器上配置适当的默认备份路径（参见第 `9.3.4` 节）。

- 一旦与客户端建立连接，服务器将自动开始备份。

这是最简单的添加 `Internet` 客户端的方法，添加 `Internet` 客户端的其他方法详见第 `8` 节。



##### 3.2 自动部署到多台 `Windows` 计算机

首先，如果你想选择不同于安装后默认设置的备份路径，可以自行配置一般默认备份路径，统一为每个客户端默认备份相应的文件夹（请参阅第 `9.3.4` 节），然后再使用以下方法之一安装客户端。



* 本地网络客户端

将 `MSI` 客户端安装程序通过组策略添加到域控制器。

或者，你可以使用带有开关 `/S` 的 `NSIS (.exe)` 安装程序进行静默安装，并使用 `psexec` 之类的东西。

服务器将自动寻找并备份新客户端。



* 广域网客户端

从以下链接中获取 `Python` 脚本，并将脚本放在服务端可被客户端访问的 `URL` 链接中。

> https://urbackup.atlassian.net/wiki/display/US/Download+custom+client+installer+via+Python 



该脚本在客户端上访问并执行，可自动在服务器上创建客户端，执行环境为 `Python 3`，当前支持 `UrBackup 2.x` 。

你还可以在执行脚本时添加静默安装开关 `/S`，这样它就无需用户干预了。



**批量部署UrBackup客户端脚本.py.7z**

下载链接：https://pan.baidu.com/s/1IWkkh0zH1CZCRUb7iI3MkA

提取码：rzd4



**脚本中只需修改前面的 `server_url` 之类的变量。**

```python
import http.client as http
import json
from urllib.parse import urlparse
from urllib.parse import urlencode
from base64 import b64encode
import hashlib
import socket
import shutil
import os
import binascii
  
#############################
# Settings. Please edit.
#############################
  
#Your server URL. Do not forget the 'x' at the end
server_url = 'http://example.com:55414/x'
  
  
#If you have basic authentication via .htpasswd
server_basic_username = ''
server_basic_password = ''
  
  
# Login user needs following rights
#   "status": "some"
#   "add_client": "all"
# Optionally, to be able to
# install existing clients:
#   "settings": "all"
server_username='adduser'
server_password='foo'
  
  
#############################
# Global script variables.
# Please do not modify.
# Only modify something after this line
# if you know what you are doing
#############################
  
session=""
  
def get_response(action, params, method):
    global server_url;
    global server_basic_username;
    global server_basic_password;
    global session;
      
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8'
    }
      
    if('server_basic_username' in globals() and len(server_basic_username)>0):
        userAndPass = b64encode(str.encode(server_basic_username+":"+server_basic_password)).decode("ascii")
        headers['Authorization'] = 'Basic %s' %  userAndPass
      
    curr_server_url=server_url+"?"+urlencode({"a": action});
      
    if(len(session)>0):
        params["ses"]=session
      
    if method=='GET':
        curr_server_url+="&"+urlencode(params);
      
    target = urlparse(curr_server_url)
     
    if not method:
        method = 'GET'
         
    if method=='POST':
        body = urlencode(params)
    else:
        body = ''
      
    if(target.scheme=='http'):
        h = http.HTTPConnection(target.hostname, target.port)
    elif(target.scheme=='https'):
        h = http.HTTPSConnection(target.hostname, target.port)
    else:
        print('Unkown scheme: '+target.scheme)
        raise Exception("Unkown scheme: "+target.scheme)
      
    h.request(
            method,
            target.path+"?"+target.query,
            body,
            headers)
      
    return h.getresponse();
  
def get_json(action, params = {}):
      
    response = get_response(action, params, "POST")
      
    if(response.status != 200):
        return ""
      
    data = response.read();
      
    response.close()
          
    return json.loads(data.decode("utf-8"))
  
def download_file(action, outputfn, params):
      
    response = get_response(action, params, "GET");
      
    if(response.status!=200):
        return False
      
    with open(outputfn, 'wb') as outputf:
        shutil.copyfileobj(response, outputf)
     
    if os.path.getsize(outputfn)<10*1024:
        return False
     
    return True      
  
def md5(s):
    return hashlib.md5(s.encode()).hexdigest()
  
  
print("Logging in...")
  
salt = get_json("salt", {"username": server_username})
  
if( not ('ses' in salt) ):
    print('Username does not exist')
    exit(1)
      
session = salt["ses"];
      
if( 'salt' in salt ):
    password_md5_bin = hashlib.md5((salt["salt"]+server_password).encode()).digest()
    password_md5 = binascii.hexlify(password_md5_bin).decode()
     
    if "pbkdf2_rounds" in salt:
        pbkdf2_rounds = int(salt["pbkdf2_rounds"])
        if pbkdf2_rounds>0:
            password_md5 = binascii.hexlify(hashlib.pbkdf2_hmac('sha256', password_md5_bin,
                                               salt["salt"].encode(), pbkdf2_rounds)).decode()
     
    password_md5 = md5(salt["rnd"]+password_md5)
      
    login = get_json("login", { "username": server_username,
                                "password": password_md5 })
      
    if('success' not in login or not login['success']):
        print('Error during login. Password wrong?')
        exit(1)
         
    clientname = socket.gethostname()
          
    print("Creating client "+clientname+"...")
          
    new_client = get_json("add_client", { "clientname": clientname})
     
    if "already_exists" in new_client:
        print("Client already exists")
         
        status = get_json("status")
         
        if "client_downloads" in status:
            for client in status["client_downloads"]:        
                if (client["name"] == clientname):
                    print("Downloading Installer...")
                     
                    if not download_file("download_client", "Client Installer.exe",
                                 {"clientid": client["id"] }):
                        print("Downloading client failed")
                        exit(1)
        else:       
            print("Client already exists and login user has probably no right to access existing clients")
            exit(2)
    else:
        if not "new_authkey" in new_client:
            print("Error creating new client")
            exit(3)
             
        print("Downloading Installer...")
                  
        if not download_file("download_client", "Client Installer.exe",
                             {"clientid": new_client["new_clientid"],
                              "authkey": new_client["new_authkey"]
                              }):
              
            print("Downloading client failed")
            exit(1)
          
    print("Sucessfully downloaded client")
    os.startfile("Client Installer.exe")
    exit(0)
```



通过 `Python` 脚本实现批量部署，由于需要每个客户端都具备 `Python` 环境，所以个人感觉比较麻烦，大家可以视实际情况而行。



##### 3.3 `Linux` 上的客户端安装

如果你打算在与服务端相同子网的网络中使用客户端，或者客户端在设置期间位于本地网络中，那么可以这样来安装客户端。

- 从 `http://www.urbackup.org` 下载便携式二进制 `Linux` 客户端安装程序。

- 运行安装程序。

- 选择一种可用的快照机制。

  如果没有可用的快照机制，请考虑在 `LVM` 或 `btrfs` 上安装 `Linux` ，否则你将不得不在备份期间停止所有正在运行的应用程序，因为备份脚本会在备份周期内改动文件，从而对应用程序的执行造成影响。

- 服务器会自动找到客户端并开始备份。



如果客户端只能通过 `Internet` 或 `NAT` 方式访问，那么可以这样安装客户端。

- 在状态页面上添加一个新的 `Internet` 客户端。

- 下载 `Internet` 客户端的客户端安装程序并将其发送到新客户端。

- 从网上下载到客户端上并安装。

  或者，为新客户端创建一个帐户（在 `Web` 界面的 `设置` > `用户` 中）并将 `用户名/密码` 发送给客户端的用户（注意，用户名大小写敏感）。

  然后，用户就可以从服务端状态页面上下载客户端安装程序并进行安装。

  **注意，经过测试，从服务端状态页面并不能找到可下载的客户端程序。**

  

- 通过命令行选择要在客户端备份的备份路径。

  ````
  urbackupclientctl add-backupdir –path /
  ````

  或在服务器上配置合适的默认备份目录（参见第 `9.3.4` 节）。

- 一旦客户端连接，服务器将自动开始备份。



##### 3.4 `Mac OS X` 客户端安装（追加内容，官网手册没有此内容）

由于官网对于 `Mac OS X` 系统的支持好像仅限于论坛讨论，所以官网主页上未见实际安装步骤。

经过我一个星期的测试，终于不负众望找到了可以使用的安装程序包。

在此强调一下，如果你找的是 `2.4` 或 `2.5` 的安装包，多半是不能直接使用的。



测试系统环境：

* `UrBackup Server 2.4.13 (Windows)`
* `Mac OS X 10.9.3 Mavericks`
* `UrBackup Client 2.0.29`（后面会提供下载）



1、双击 `UrBackup Client 2.0.29` 安装包，点击继续。

图03



2、选择安装位置。

图04



3、确定安装位置并开始安装。

图05



4、输入密码以便开始安装。

图06



5、程序开始验证并安装。

图07



6、很快安装即可完成。

图08



7、在应用程序中可以看到 `UrBackup Client` 。

图09



8、手动运行 `UrBackup Client` 或重启让它自己启动也可以。

点击图标，选择 `Status` 查看当前状态，正常情况下需要几分钟时候服务端即可自动发现并添加到客户端列表中。

图10



9、点击图标，选择 `Infos` 查看版本等信息。

图11



10、点击图标，选择 `Add/Remove backup paths` 添加修改需要备份的路径。

图12



11、点击图标，选择 `Do full file backup` 或 `do incremental file backup` 可以开始执行完全备份和增量备份，当然在服务端也可以执行同样的操作。

图13



我测试的 `Mac OS X` 版本是 `10.9` ，同样在其他更高版上测试也是没问题的。

但请小伙伴们注意，`UrBackup Client` 的 `2.4` 或是 `2.5` 我都没有测试成功，要小心如果失败尽早放弃。



**UrBackup Client 2.0.29.pgk.7z (5.05M)**

下载链接：https://pan.baidu.com/s/1GhT3s7f65W5QOi6KPL4k3g

提取码：bzdv



### 小结

本节向小伙伴们介绍分享了 `UrBackup` 客户端的安装方法，虽然相对服务端的安装来说比较简单，但在实际的安装实践中也可以有多种灵活的方法，大家可以按实际情况定制安装。

由于开源多平台的特质，所以具体的客户端安装方法可以参考官方下载页面，每个不同的平台有相应不同的具体安装方法。

今天分享就到这里，之后会继续介绍 `UrBackup` 的其他特性，敬请期待！



**扫码关注@网管小贾，阅读更多**

网管小贾的博客 / www.sysadm.cc
