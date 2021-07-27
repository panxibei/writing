

尝试微软家的 Linux 系统 CBL-Mariner







将 `go` 包管理代理原网址 `proxy.golang.org` 更换为 `goproxy.cn` 。

```shell
go env -w GOPROXY=https://goproxy.cn
```



安装 `python-minimal` 时会报错，实际上是因为我们需要安装的是 `python2` 版本，系统认为的是 `python3` 版本，所以找不到而报错。

那么我们可以这样安装它。

```
sudo apt install python2-minimal
```

