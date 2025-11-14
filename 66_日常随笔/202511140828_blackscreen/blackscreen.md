blackscreen

副标题：

英文：

关键字：





> https://blacksreen.app



`body` 下面的一个 `div` ，写了这么几句。

> Black Screen
>
> Just a black web page
>
> Double click to enter fullscreen mode.

图a02



双击可以全屏？

切换到 `调试器` ，找到 `fullscreen.js` 脚本文件，在右侧可以看到完整代码。

```js
function toggleFullScreen() {
  const doc = window.document;
  const docEl = doc.documentElement;

  var requestFullScreen =
    docEl.requestFullscreen ||
    docEl.mozRequestFullScreen ||
    docEl.webkitRequestFullScreen ||
    docEl.msRequestFullscreen;
  var cancelFullScreen =
    doc.exitFullscreen ||
    doc.mozCancelFullScreen ||
    doc.webkitExitFullscreen ||
    doc.msExitFullscreen;

  if (
    !doc.fullscreenElement &&
    !doc.mozFullScreenElement &&
    !doc.webkitFullscreenElement &&
    !doc.msFullscreenElement
  ) {
    requestFullScreen.call(docEl);
  } else {
    cancelFullScreen.call(doc);
  }
}

document.addEventListener("dblclick", () => {
  toggleFullScreen();
});
```

图a03



自己也可以制作一个简单的。

打开记事本程序，在里面输入以下代码，就一句。

```html
<style>body{background-color:000000;}</style>
```

然后保存为 `xxx.html` ，前面的 `xxx` 随便你写什么，只要保持文件后缀是 `html` 的网页格式即可。

