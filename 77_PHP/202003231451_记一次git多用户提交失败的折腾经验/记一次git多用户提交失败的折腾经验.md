记一次git多用户提交失败的折腾经验



作为初学git的小白，平时只是满足一般的git操作日子也照样过。

我喜欢用ssh方式连接仓库，因为这样不用每次都输入用户名和密码。

一个git账号对应多个仓库的操作早已是习以为常了。

突然有一天，我有了两个账号，自此开启了懵B之旅。



首先，照着网上的教程，为两个不同的账号生成了不同的ssh-key。

得到了四个文件，每个账号分别对应两个文件，一个key，一个pub。

`user1` 对应 `id_rsa_user1` 和 `id_sa_user1.pub`

`user2` 对应 `id_rsa_user2` 和 `id_sa_user2.pub`



然后，把 `pub` 的内容添加到 `github` 上。



接下来，编辑 `~/.ssh/config`，设定不同的git服务器对应不同的key。

ssh区分账号，其实靠的是 `host` 这个字段，多个账号可以映射到不同的 `Hostname` 上。

```shell
host github.com4user1
    Hostname github.com
    User user1
	PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_user1

host github.com4user2
    Hostname github.com
    User user2
	PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_user2
```



最后，测试是否通过 `host` 名称来区分不同的账号，于此同时能否正确地访问相应的远程仓库。

```
$ ssh -T git@github.com4user1
Hi user1! You've successfully authenticated, but GitHub does not provide shell access.

$ ssh -T git@github.com4user2
Hi user2! You've successfully authenticated, but GitHub does not provide shell access.
```

看样子是没问题了，不同的账号可以找到相应的 `host` ，之后也正确地连接到了相应的 `Hostname`。



到现在为止，是不是觉得很顺利、很easy呢？

我欢快地来到了项目目录下，开始提交代码。

纳尼？提交错误？！

```shell
user@pc MINGW64 /c/www/project (dev)
$ git push origin dev
ERROR: Permission to user2/project.git denied to user1.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```



刚才明明连接成功了啊。。。

仔细一看，提示中写的是，**`user2` 无法访问 `user1` 的权限**。

明明是 `user2` ，为什么变成访问的是 `user1` 呢？百思不得其解。。。

网上找了半天，发现这个。

>在2017年，git新发布的版本2.13.0包含了一个新的功能 `includeIf` 配置，可以把匹配的路径使用对应的配置用户名和邮箱；
>
>在 `~/` 目录下面存在三个配置文件
>
>    .gitconfig // 全局通用配置文件
>    .gitconfig-self // 个人工程配置文件
>    .gitconfig-work // 公司工程配置文件
>
>全局通用配置文件 `~/.gitconfig` 里面的内容是：主要是通过 `includeIf` 配置匹配不用的目录映射到不同配置文件上。

我尝试了半天，失败！

**原因很简单，这个设定应该是针对不同账号对应的用户名和密码的，并不是用于ssh的访问。**



就在快要放弃的时候，最终还是被我找到了解决方法。

**在编辑 `~/.ssh/config` 之后，需要把不同账号的远程仓库链接也做相应的修改。**

比如原远程仓库连接地址是

```
git@github.com:user1/project1.git
```

那么相应的应该修改为

```
git@github.com4user1:user1/project1.git
```

看出哪里不一样了吗？

其实就是@后面的名称啊，修改为 `~/.ssh/config` 中相应账号的**主机名称**（host），这样ssh才会自动解析成正确的服务地址。



那位说，道理咱都懂，那么具体怎么做呢？

有两个办法：

1、使用命令重新修改远程仓库

```shell
# 删除关联的远程仓库
git remote remove origin
# 添加关联远程仓库
git remote add origin git@github4user1:user1/project1.git
```

2、直接更改项目中git的配置文件 `repo/.git/config` 里面的 `url`

```shell
[remote "origin"]
	url = git@github.com4user1:user1/project1.git
```

这样每次push的时候，只要你是使用ssh方式，系统就会根据不同的仓库地址使用不同的账号提交了。



立马回到项目目录，再次尝试提交代码，果然成功了！

心潮澎湃，感慨万千！有点想哭，有么有？

来来回回折腾了大半天，好歹是解决了，希望能给同样初学的小白们带来帮助。

好了，老板喊我搬砖了。

下次继续努力，加油！！！



**公众号：网管小贾**