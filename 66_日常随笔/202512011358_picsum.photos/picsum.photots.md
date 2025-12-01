picsum.photos

副标题：

英文：

关键字：





关键网址，一切都围绕着它来做文章。

```
https://picsum.photos
```





只需在这个网址后添加期望的图像大（宽和高），即可获得一张相应大小的随机图片。

```http
https://picsum.photos/200/300
```



图片的宽和高可以不一样，当然也可以一样。

要获得一个正方形图像，只需添加大小即可。

```http
https://picsum.photos/200
```



在网址后面添加参数 `/id/{image}` 来显示指定的固定图片。

如下 `/id/237` ，就是指 `id` 为 `237` 的图片，图片大小  `200*300` 。

```http
https://picsum.photos/id/237/200/300
```

都有哪些图片呢？

可以打开这个网址链接瞧瞧。

```http
https://picsum.photos/images
```



每次根据种子获取相同的随机图像，只要在网址后面加上参数 `/seed/{seed}`。

这个 `{seed}` 可以是任意的字符串，如下，`/seed/picsum` 。

```http
https://picsum.photos/seed/picsum/200/300
```



通过在网址的最后加上参数 `?grayscale` ，就可以获得灰度图片。

```http
https://picsum.photos/200/300?grayscale
```



通过在网址的最后加上参数 `?blur` 来获得模糊图像。

```http
https://picsum.photos/200/300/?blur
```



给参数 `?blur` 提供一个 `1` 到 `10` 的数字，来调整模糊量（数字越大越模糊）。 

```http
https://picsum.photos/200/300/?blur=2
```



我们可以将前面说的任何选项合并，来实现高级使用方法。

例如，要同时获取具有灰度和模糊性的特定图像，像这样。

```http
https://picsum.photos/id/870/200/300?grayscale&blur=2
```



如果要在浏览器中请求多张大小相同的图片，那么请注意，需要添加参数 `random` 并赋予不同的值来用于防止显示雷同的缓存图像。

```html
<img src="https://picsum.photos/200/300?random=1">
<img src="https://picsum.photos/200/300?random=2">
```



如果需要以文件形式结尾，那么可以在网址结尾处添加 `.jpg` 。

```http
https://picsum.photos/200/300.jpg
```



如果要获取 `WebP` 格式的图像，那么可以在网址结尾处添加 `.webp` 。

```http
https://picsum.photos/200/300.webp
```



在网址后面使用参数 `/v2/list` 来获取图片列表。

```https
https://picsum.photos/v2/list
```

返回的信息是如下 `json` 格式的内容。

```json
[
	{
		"id": "0",
		"author": "Alejandro Escamilla",
		"width": 5616,
		"height": 3744,
		"url": "https://unsplash.com/...",
		"download_url": "https://picsum.photos/..."
	}
]
```

图a01



`API` 将默认为每个页面返回 `30` 条记录，也就是说，它默认是以 `30` 条记录为一页来返回显示的。

因此，如果要请求除第一页的记录，那么需要使用到 `?page` 参数，例如 `?page=2` 。

要更改每页记录的数量，需要使用 `?limit` 参数，例如 `?limit=100` 。

```http
https://picsum.photos/v2/list?page=2&limit=100
```

> `Link` 头包含有关 `下一页/上一页` 的分页信息。



在 `/id/{id}` 和 `/seed/{seed}` 后面加上 `/info`，变成 `/id/{id}/info` 和 `/seed/{seed}/info` ，这样可以获取有关该图像的详细信息。

```http
https://picsum.photos/id/0/info
https://picsum.photos/seed/picsum/info
```

获得的详细信息类似于如下：

```
{
	"id": "0",
	"author": "Alejandro Escamilla",
	"width": 5616,
	"height": 3744,
	"url": "https://unsplash.com/...",
	"download_url": "https://picsum.photos/..."
}
```



当然还可以通过查看图片来查清图像的标识 `Picsum-ID ` 头，或 `EXIF` 元数据中的 `User Comment` 字段。

