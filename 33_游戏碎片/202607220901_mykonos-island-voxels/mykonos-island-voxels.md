mykonos-island-voxels

副标题：

英文：

关键字：







游戏开始加载。

图a01

图a02





这个游戏只用到了纯 `HTML/CSS/ES` 模块，不需要安装啥的，直接就能用。

不过因为浏览器会拒绝加载来自 `file://` 开头的 `ES` 模块，所以我们就需要通过 `HTTP` 服务来启动它。

`file://` 开头是啥意思呢？

就是把文件当成本地去运行 `Web` 页面，那样是不行的，所以还是要老老实实搭建个 `Web` 引擎，然后通过 `http` 访问网站式的方式来打开它。

比如，我搭建了一个 `Web` 网站，然后放到了 `mykonos-island-voxels` 目录，于是我就可以这样运行。

```
http://localhost/mykonos-island-voxels
```

图a03



运行 `Web` 引擎，最简单可以使用 `Caddy` 程序（单文件，文末打包下载），像下面以命令行方式运行。

```
caddy_windows_amd64.exe file-server
```



不会输入命令行的朋友可以直接运行批处理文件，双击即可。

图a08



`Web` 引擎启动后，它就在后台运行了，这时就可以直接打开浏览器访问游戏了。

图a07









整个游戏的文件结构，想要动手修改可以按这个来。

```
.
├── index.html               # 站点入口
├── styles.css               # UI样式 (未使用框架)
├── src/
│   ├── main.js              # 主脚本文件，启动、资源加载、初始化场景
│   ├── config.js            # 配置脚本，网格大小、磁贴调光、调色板、调试标志
│   ├── core/
│   │   ├── Game.js          # 游戏状态 + 工具调度
│   │   ├── Camera.js        # 平移/缩放/更改通知
│   │   ├── Renderer.js      # 分层画布缓存 + 动画
│   │   └── InputManager.js  # 鼠标 + 触摸 + 键盘
│   ├── grid/
│   │   ├── IsoGrid.js       # 屏幕 ↔ 单元计算
│   │   └── TileMap.js       # 地形 + 物体,占用指数
│   ├── building/
│   │   └── PlacementSystem.js
│   ├── assets/
│   │   ├── assetManifest.js # 75+资源定义
│   │   ├── assetLoader.js   # PNG → 画布显示 + 画布阴影
│   │   ├── imageToAsset.js  # 剪影提取,锚点推断
│   │   └── voxelRenderer.js # PNG缺失时程序回滚
│   ├── ui/
│   │   ├── UIManager.js
│   │   ├── Toolbar.js
│   │   ├── AssetPalette.js
│   │   ├── HUD.js
│   │   └── Audio.js         # WebAudio 剪辑路由 + 防抖
│   └── persistence/
│       └── SaveSystem.js
├── assets/                  # PNG资源包 (预生成)
├── *.ogg                    # 位置 / UI音效
├── netlify.toml
└── netlify-build.mjs
```





游戏里的场地大小是写在配置文件中的，默认是 `14 x 14` 。

在游戏里面没办法直接扩大地图的尺寸，不过通过修改配置文件源码实现。

把其中的 `width` 和 `height` 改大，比如 20 x 20、24 x 24，就可以了。

图a04



但是请注意哈，地图越大，首次加载和渲染会更慢。

图a05





搭建好的小岛是可以保存的，可以通过按下 `S` 键手动保存，也可以通过左侧工具栏当中的 `Save` 保存。

下次重新打开同一个地址时，会自动读取上次存档，存档存在浏览器的 `localStorage` 里，并不在服务器中。

也就是说，你正常关掉标签页、关掉浏览器，然后再回来，一般还在。

但前提是还是用的这个浏览器、这个地址访问地址。

如果清除了浏览器站点数据，或使用无痕模式，或更换了网址端口，或干脆换了浏览器，那么可能就真的没了。

 



我做了简单的汉化，除了右侧第一个“地形”之外，其他地方都改成了中文。

图a06





