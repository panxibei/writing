SuperTux

副标题：

英文：

关键字：





`Apache` 编辑 `httpd.conf` 配置文件。

```
# 核心：启用头模块（如果未启用，先执行这行，否则跳过）
LoadModule headers_module modules/mod_headers.so

# 配置跨源隔离头（必须同时添加这3个）
<IfModule mod_headers.c>
    # 开启跨源隔离核心头
    Header set Cross-Origin-Opener-Policy "same-origin"
    Header set Cross-Origin-Embedder-Policy "require-corp"
    Header set Cross-Origin-Resource-Policy "same-site"
    
   	# 允许字体跨源，修复方块乱码
    Header set Access-Control-Allow-Origin "*"
    
    # 可选：确保WASM文件MIME类型正确（SuperTux网页版依赖WASM）
    AddType application/wasm .wasm
</IfModule>
```



`Nginx` 编辑 `nginx.conf` 配置文件。

```
server {
    listen 80;
    server_name your-domain.com; # 替换为你的域名/IP
    root /path/to/supertux; # SuperTux 网页文件目录

    # 核心：添加跨源隔离头
    add_header Cross-Origin-Opener-Policy same-origin;
    add_header Cross-Origin-Embedder-Policy require-corp;
    add_header Cross-Origin-Resource-Policy same-site;

    # 可选：确保 MIME 类型正确
    types {
        application/wasm wasm;
        text/javascript js;
    }
}
```

