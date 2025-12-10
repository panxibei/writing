blackscreen

副标题：

英文：

关键字：



“大……大师兄……师父……师父被妖怪抓……抓走了……！”

小猪妖正半睡半醒，听闻呼喊声音，不情愿地眯缝着眼睛，斜着看了一眼黄鼠狼精。

“练得不错……像样了，继续努力！”



“不是……师父真的不见了！”

“你好像不是装的……”

“废话！要不是你们不让我说话……赶快起来找找啊！”



小猪妖一个鲤鱼打挺，抄起家伙就跑。

“喂！你倒是先问问方向啊……”

黄鼠狼精朝西指，小猪妖却朝东跑。

“行了，别啰嗦了，快走！”

小猪妖边跑边拽起一旁的猩猩怪。



很快，他们来到了一座雄伟的寺庙前。

“没错！就是这儿，我看着师父进去，到现在都没出来……”

“你怎么不早点说？”小猪妖喘着气，责怪黄鼠狼精。

黄鼠狼精无奈地两手一摊，“你们都在睡觉，又不让我说话……”

“不管了，赶快冲进去救师父吧！”



说完，小猪妖一个箭步冲进庙里，紧接着黄鼠狼精和猩猩怪也跟在后面。



说来也奇怪，他们刚走进这庙宇之中，却发现里面热闹非凡。

有唱戏的、有打把式的、有喝茶的、有吃饭的，好不热闹。

小猪妖他们一度怀疑走错了片场。

这时，小猪妖的眼前出现了几本考编大全。

他随手拿起一本，情不自禁地翻看起来，里面有今年的考编真题与各大妖怪集团的招聘信息，是应有尽有。



黄鼠狼精的面前，出现了一盘精致鸡腿，秀色可餐。

那美女冲他招了招手，轻声细语说她最喜欢有人陪她说话唠嗑。

黄鼠狼不自觉地就想跟她走。



再看猩猩这边，他正坐在一张桌子旁，桌上摆着各种游戏机。



别看猩猩平时超级社恐，这一切突如其来的不真实，反而让他背后发凉。

他惊恐万分，猛然间喊道：“我……我是齐天大圣……！”

瞬间，那些吃的喝的玩的乐的，消失得无影无踪。



三个人瘫坐在一起，觉得这次遇到了超级大麻烦。

看来，这座庙，问题很大啊！



过了好一会儿，野猪从地上蹦了起来。

“对啊，我刚才怎么没想到啊！”

其余两个人用奇怪的眼神看着他，黄鼠狼就说：“你想到什么了？知道在师父了吗？”



“不不……我想到的是，这坐庙实际上，是由一个巨大的屏幕组成的。

不管是我们看到的，还是摸到的，都是一块块电脑屏幕，是幻象！

它们一定是有一个大型的计算机在背后控制着！

”

“那又怎么样……嗯？等等……你的意思是说……”

黄鼠狼睁大了眼睛，看了看野猪，又看了看猩猩。



“没错，我们要先找到控制这里的电脑，最后才能找到师父！”



“哦哦，我懂了，你是说，把电脑关掉，这里就显出原形，我们就能很容易找到师父了！

还是你厉害啊！可是，怎么找，后台控制电脑在哪里呢？”

黄鼠狼摸了摸胡子，还好胡子没掉。



















> https://blacksreen.app



`body` 下面的一个 `div` ，写了这么几句。

> Black Screen
>
> Just a black web page
>
> Double click to enter fullscreen mode.

图a02



双击可以全屏？

切换到 `调试器` ，找到 `fullscreen.js` 脚本文件，在右侧可以看到完整代码。

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

