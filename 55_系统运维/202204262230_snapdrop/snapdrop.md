snapdrop

副标题：

英文：

关键字：



















### 在 `Docker` 上实现 `SnapDrop`

只要有 `Docker` ，自己也能玩 `SnapDrop` ，走着！



拉取镜像

```
docker pull seji/snapdrop-docker
```

图d01



查看镜像，大小 `145M` 还行，不算大。

图d02



运行容器

```
docker run --rm -p 8080:80 seji/snapdrop-docker:latest
```

我们可以根据实际情况将端口 `8080` 修改为任意我们想要的访问端口，当然直接用 `80` 端口也是可以的。

图d03



我们实际在局域网中测试一下，传输文件完全没问题！

图d04



