mykonos-island-voxels

副标题：

英文：

关键字：







该项目为纯HTML/CSS/ES模块——没有构建步骤 需要在此基础上进行开发。因为浏览器拒绝加载 ES 模块 来自`file://`网址,你确实需要通过HTTP来服务它。



```
http://localhost/mykonos-island-voxels
```





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







游戏里的场地大小是写死在配置里的 14 x 14，所以不能在游戏里直接扩大地图的尺寸，但可以通过在源码层面上进行修改，把 width 和 height 改大，比如 20 x 20、24 x 24；但也请注意：地图越大，首次加载和渲染会更重。



搭建好的小岛是可以保存的，可以通过 S 键手动保存，也可以通过左侧工具栏当中的 “Save”，下次重新打开同一个地址时，会自动读取上次存档，存档存在浏览器的 localStorage 里，不是服务器。

也就是说你正常关掉标签页、关掉 Chrome，再回来，一般还在；但前提是还是这个浏览器、这个地址 127.0.0.1:59286；如果清浏览器站点数据 / [无痕模式](https://zhida.zhihu.com/search?content_id=275487958&content_type=Article&match_order=1&q=无痕模式&zhida_source=entity) / 换端口 / 换浏览器，可能就没了 