记一次git多用户提交失败的折腾经验







 先假设我有两个账号，一个是github上的，一个是公司gitlab上面的。先为不同的账号生成不同的ssh-key ssh-keygen -t rsa -f ~/.ssh/id_rsa_work -c xxx@gmail.com 然后根据提示连续回车即可在~/.ssh目录下得到id_rsa_work和id_rsa_work.pub两个文件，id_rsa_work.pub文件里存放的就是我们要使用的key ssh-keygen -t rsa -f ~/.ssh/id_rsa_github -c xxx@gmail.com 然后根据提示连续回车即可在~/.ssh目录下得到id_rsa_github和id_rsa_github.pub两个文件，id_rsa_gthub.pub文件里存放的就是我们要使用的key
    把id_rsa_xxx.pub中的key添加到github或gitlab上，这一步在github或gitlab上都有帮助，不再赘述
    编辑 ~/.ssh/config，设定不同的git 服务器对应不同的key



从上面一步可以看到，ssh区分账号，其实靠的是HostName这个字段，因此如果在github上有多个账号，很容易的可以把不同的账号映射到不同的HostName上就可以了。

```shell
host github.com4panxibei
    Hostname github.com
    User panxibei
	PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa

host github.com4xizhisoft
    Hostname github.com
    User xizhisoft
	PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_xizhisoft
```



测试是否通过Host名称来区分不同的账号，于此同时可以正确地访问相应的远程仓库。

ssh -T git@github.com_foo1

```
$ ssh -T git@github.com_foo1
Hi gituser1! You've successfully authenticated, but GitHub does not provide shell access.
```









提交错误开始了！

```shell
user@pc MINGW64 /c/www/project (dev)
$ git push origin dev
ERROR: Permission to gituser2/project.git denied to gituser1.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

一顿折腾



在2017年，git新发布的版本2.13.0包含了一个新的功能includeIf配置，可以把匹配的路径使用对应的配置用户名和邮箱；

在~/目录下面存在三个配置文件，

    .gitconfig // 全局通用配置文件
    .gitconfig-self // 个人工程配置文件
    .gitconfig-work // 公司工程配置文件

全局通用配置文件~/.gitconfig里面的内容是：主要是通过includeIf配置匹配不用的目录映射到不同配置文件上，





最终解决方法：

同时你的github的repo ssh url就要做相应的修改了，比如根据上面的配置,原连接地址是:

git@github.com:testA/gopkg.git

那么根据上面的配置，就要把github.com换成A.github.com, 那么ssh解析的时候就会自动把testA.github.com 转换为 github.com,修改后就是

git@A.github.com:testA/gopkg.git

直接更改 repo/.git/config 里面的url即可

这样每次push的时候系统就会根据不同的仓库地址使用不同的账号提交了

```shell
[remote "origin"]
	url = git@github.com_foo1:gituser1/project.git
```

