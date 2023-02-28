Putty用户手册

副标题：

英文：

关键字：





# `PuTTY` 用户手册

PuTTY是一个免费的（MIT许可的）Windows Telnet和SSH客户端。本手册记录了PuTTY及其配套实用程序PSCP，PSFTP，Plink，Pageant和PuTTYgen。

*Unix用户注意：*本手册目前主要记录了Windows版本的PuTTY实用程序。因此，提到了Unix版本中没有的一些选项;Unix 版本具有此处未描述的功能;并且根本没有描述 and 命令行和实用程序。目前唯一存在的特定于 Unix 的文档是手册页。`pterm``puttygen``pageant`

本手册的版权为 1997-2022 西蒙·塔瑟姆。保留所有权利。您可以在 MIT 许可下分发本文档。许可证全文见[附录D](AppendixD.html#licence)。

- 第1章 普提简介
  - [1.1 什么是SSH，Telnet，Rlogin和SUPDUP？](Chapter1.html#you-what)
  - [1.2 SSH、Telnet、Rlogin和SUPDUP有何不同？](Chapter1.html#which-one)
- 第 2 章：PuTTY 入门
  - [2.1 启动会话](Chapter2.html#gs-insecure)
  - [2.2 验证主机密钥（仅限 SSH）](Chapter2.html#gs-hostkey)
  - [2.3 登录](Chapter2.html#gs-login)
  - [2.4 登录后](Chapter2.html#gs-session)
  - [2.5 注销](Chapter2.html#gs-logout)
- 第 3 章：使用 PuTTY
  - [3.1 会话期间](Chapter3.html#using-session)
  - [3.2 创建会话的日志文件](Chapter3.html#using-logging)
  - [3.3 更改字符集配置](Chapter3.html#using-translation)
  - [3.4 在 SSH 中使用 X11 转发](Chapter3.html#using-x-forwarding)
  - [3.5 在 SSH 中使用端口转发](Chapter3.html#using-port-forwarding)
  - [3.6 连接到本地串行线路](Chapter3.html#using-serial)
  - [3.7 建立原始 TCP 连接](Chapter3.html#using-rawprot)
  - [3.8 使用 Telnet 协议进行连接](Chapter3.html#using-telnet)
  - [3.9 使用 Rlogin 协议进行连接](Chapter3.html#using-rlogin)
  - [3.10 使用 SUPDUP 协议进行连接](Chapter3.html#using-supdup)
  - [3.11 PuTTY 命令行](Chapter3.html#using-cmdline)
- 第 4 章：配置 PuTTY
  - [4.1 会话面板](Chapter4.html#config-session)
  - [4.2 日志记录面板](Chapter4.html#config-logging)
  - [4.3 端子面板](Chapter4.html#config-terminal)
  - [4.4 键盘面板](Chapter4.html#config-keyboard)
  - [4.5 铃铛面板](Chapter4.html#config-bell)
  - [4.6 功能面板](Chapter4.html#config-features)
  - [4.7 窗口面板](Chapter4.html#config-window)
  - [4.8 外观面板](Chapter4.html#config-appearance)
  - [4.9 行为面板](Chapter4.html#config-behaviour)
  - [4.10 翻译面板](Chapter4.html#config-translation)
  - [4.11 选择面板](Chapter4.html#config-selection)
  - [4.12 复制面板](Chapter4.html#config-selection-copy)
  - [4.13 颜色面板](Chapter4.html#config-colours)
  - [4.14 连接面板](Chapter4.html#config-connection)
  - [4.15 “数据”面板](Chapter4.html#config-data)
  - [4.16 代理面板](Chapter4.html#config-proxy)
  - [4.17 SSH面板](Chapter4.html#config-ssh)
  - [4.18 凯克斯面板](Chapter4.html#config-ssh-kex)
  - [4.19 主机密钥面板](Chapter4.html#config-ssh-hostkey)
  - [4.20 密码面板](Chapter4.html#config-ssh-encryption)
  - [4.21 身份验证面板](Chapter4.html#config-ssh-auth)
  - [4.22 凭据面板](Chapter4.html#config-ssh-auth-creds)
  - [4.23 GSSAPI面板](Chapter4.html#config-ssh-auth-gssapi)
  - [4.24 TTY面板](Chapter4.html#config-ssh-tty)
  - [4.25 X11面板](Chapter4.html#config-ssh-x11)
  - [4.26 隧道面板](Chapter4.html#config-ssh-portfwd)
  - [4.27 错误和更多错误面板](Chapter4.html#config-ssh-bugs)
  - [4.28 “裸`ssh连接`”协议](Chapter4.html#config-psusan)
  - [4.29 串行面板](Chapter4.html#config-serial)
  - [4.30 远程登录面板](Chapter4.html#config-telnet)
  - [4.31 登录面板](Chapter4.html#config-rlogin)
  - [4.32 SUPDUP 面板](Chapter4.html#config-supdup)
  - [4.33 将配置存储在文件中](Chapter4.html#config-file)
- 第 5 章：使用 PSCP 安全地传输文件
  - [5.1 启动 PSCP](Chapter5.html#pscp-starting)
  - [5.2 PSCP 的使用](Chapter5.html#pscp-usage)
- 第 6 章：使用 PSFTP 安全地传输文件
  - [6.1 启动PSFTP](Chapter6.html#psftp-starting)
  - [6.2 运行 PSFTP](Chapter6.html#psftp-commands)
  - [6.3 通过 PSFTP 使用公钥身份验证](Chapter6.html#psftp-pubkey)
- 第 7 章：使用命令行连接工具 Plink
  - [7.1 启动链接](Chapter7.html#plink-starting)
  - [7.2 使用链接](Chapter7.html#plink-usage)
  - [7.3 在批处理文件和脚本中使用 Plink](Chapter7.html#plink-batch)
  - [7.4 在 CVS 中使用 Plink](Chapter7.html#plink-cvs)
  - [7.5 将 Plink 与 WinCVS 结合使用](Chapter7.html#plink-wincvs)
- 第 8 章：使用公钥进行 SSH 身份验证
  - [8.1 公钥认证 - 简介](Chapter8.html#pubkey-intro)
  - [8.2 使用 PuTTYgen，PuTTY 密钥生成器](Chapter8.html#pubkey-puttygen)
  - [8.3 准备公钥认证](Chapter8.html#pubkey-gettingready)
- 第 9 章：使用选美进行身份验证
  - [9.1 选美入门](Chapter9.html#pageant-start)
  - [9.2 选美主窗口](Chapter9.html#pageant-mainwin)
  - [9.3 选美命令行](Chapter9.html#pageant-cmdline)
  - [9.4 使用代理转发](Chapter9.html#pageant-forward)
  - [9.5 加载密钥而不解密](Chapter9.html#pageant-deferred-decryption)
  - [9.6 安全注意事项](Chapter9.html#pageant-security)
- 第 10 章：常见错误消息
  - [10.1 “未为此服务器缓存主机密钥”](Chapter10.html#errors-hostkey-absent)
  - [10.2 “警告 - 潜在的安全漏洞！”](Chapter10.html#errors-hostkey-wrong)
  - [10.3 “此服务器提供了由其他证书颁发机构签名的认证主机密钥......”](Chapter10.html#errors-cert-mismatch)
  - [10.4 “我们的配置需要 SSH 协议版本 2，但远程仅提供（旧的、不安全的）SSH-1”](Chapter10.html#errors-ssh-protocol)
  - [10.5'服务器支持的第一个密码是...低于配置的警告阈值'](Chapter10.html#errors-cipher-warning)
  - [10.6 “远程端发送断开连接消息类型 2（协议错误）：”root 身份验证失败次数过多“”](Chapter10.html#errors-toomanyauth)
  - [10.7 “内存不足”](Chapter10.html#errors-memory)
  - [10.8 “内部错误”、“内部故障”、“断言失败”](Chapter10.html#errors-internal)
  - [10.9 “无法使用密钥文件”、“无法加载私钥”、“无法加载此密钥”](Chapter10.html#errors-cant-load-key)
  - [10.10 “服务器拒绝了我们的密钥”、“服务器拒绝了我们的公钥”、“密钥被拒绝”](Chapter10.html#errors-refused)
  - [10.11 “访问被拒绝”、“身份验证被拒绝”](Chapter10.html#errors-access-denied)
  - [10.12 “没有可用的身份验证方法”](Chapter10.html#errors-no-auth)
  - [10.13 “数据包上收到的MAC不正确”或“数据包上收到的CRC不正确”](Chapter10.html#errors-crc)
  - [10.14 “传入数据包在解密时出现乱码”](Chapter10.html#errors-garbled)
  - [10.15 “PuTTY X11 代理：*各种错误*”](Chapter10.html#errors-x11-proxy)
  - [10.16 “网络错误：软件导致连接中止”](Chapter10.html#errors-connaborted)
  - [10.17 “网络错误：对等方重置连接”](Chapter10.html#errors-connreset)
  - [10.18 “网络错误：连接被拒绝”](Chapter10.html#errors-connrefused)
  - [10.19 “网络错误：连接超时”](Chapter10.html#errors-conntimedout)
  - [10.20 “网络错误：无法分配请求的地址”](Chapter10.html#errors-cannotassignaddress)
- 附录 A：PuTTY 常见问题解答
  - [A.1 引言](AppendixA.html#faq-intro)
  - [A.2 PuTTY 支持的功能](AppendixA.html#faq-support)
  - [A.3 移植到其他操作系统](AppendixA.html#faq-ports)
  - [A.4 在其他程序中嵌入 PuTTY](AppendixA.html#faq-embedding)
  - [A.5 PuTTY的运营细节](AppendixA.html#faq-details)
  - [A.6 操作方法问题](AppendixA.html#faq-howto)
  - [A.7 故障排除](AppendixA.html#faq-trouble)
  - [A.8 安全问题](AppendixA.html#faq-secure)
  - [A.9 行政问题](AppendixA.html#faq-admin)
  - [A.10 杂项问题](AppendixA.html#faq-misc)
- 附录 B：反馈和错误报告
  - [B.1 一般准则](AppendixB.html#feedback-general)
  - [B.2 报告错误](AppendixB.html#feedback-bugs)
  - [B.3 报告安全漏洞](AppendixB.html#feedback-vulns)
  - [B.4 请求额外功能](AppendixB.html#feedback-features)
  - [B.5 请求已请求的功能](AppendixB.html#feedback-feature-priority)
  - [B.6 支持请求](AppendixB.html#feedback-support)
  - [B.7 网络服务器管理](AppendixB.html#feedback-webadmin)
  - [B.8 请求许可](AppendixB.html#feedback-permission)
  - [B.9 镜像 PuTTY 网站](AppendixB.html#feedback-mirrors)
  - [B.10 赞美和赞美](AppendixB.html#feedback-compliments)
  - [B.11 电子邮件地址](AppendixB.html#feedback-address)
- 附录C：PPK文件格式
  - [C.1 概述](AppendixC.html#ppk-overview)
  - [C.2 外层](AppendixC.html#ppk-outer)
  - [C.3 私钥编码](AppendixC.html#ppk-privkeys)
  - [C.4 密钥派生](AppendixC.html#ppk-keys)
  - [C.5 旧版本的PPK格式](AppendixC.html#ppk-old)
- [附录 D：PUTTY 许可证](AppendixD.html#licence)
- 附录E：PuTTY黑客指南
  - [E.1 跨操作系统可移植性](AppendixE.html#udp-portability)
  - [E.2 多个后端同等对待](AppendixE.html#udp-multi-backend)
  - [E.3 某些平台上每个进程多个会话](AppendixE.html#udp-globals)
  - [E.4 C，不是C++](AppendixE.html#udp-pure-c)
  - [E.5 安全意识编码](AppendixE.html#udp-security)
  - [E.6 特定编译器的独立性](AppendixE.html#udp-multi-compiler)
  - [E.7 代码小](AppendixE.html#udp-small)
  - [E.8 单线程代码](AppendixE.html#udp-single-threaded)
  - [E.9 尽可能发送到服务器的击键](AppendixE.html#udp-keystrokes)
  - [E.10 640×480 配置面板的友好性](AppendixE.html#udp-640x480)
  - [E.11 协议代码中的协程](AppendixE.html#udp-ssh-coroutines)
  - [E.12 实现特征的显式 vtable 结构](AppendixE.html#udp-traits)
  - [E.13 照我们说的做，而不是照我们做的做](AppendixE.html#udp-perfection)
- 附录 F：PuTTY 下载密钥和签名
  - [F.1 公钥](AppendixF.html#pgpkeys-pubkey)
  - [F.2 安全细节](AppendixF.html#pgpkeys-security)
  - [F.3 密钥翻转](AppendixF.html#pgpkeys-rollover)
- 附录 G：为 PuTTY 指定的 SSH-2 名称
  - [G.1 连接协议通道请求名称](AppendixG.html#sshnames-channel)
  - [G.2 密钥交换方法名称](AppendixG.html#sshnames-kex)
  - [G.3 加密算法名称](AppendixG.html#sshnames-encrypt)
  - [G.4 代理扩展请求名称](AppendixG.html#sshnames-agent)
- 附录H：PuTTY认证插件协议
  - [H.1 要求](AppendixH.html#authplugin-req)
  - [H.2 运输和配置](AppendixH.html#authplugin-transport)
  - [H.3 数据格式和编组](AppendixH.html#authplugin-formats)
  - [H.4 协议版本控制](AppendixH.html#authplugin-version)
  - [H.5 事件概述和顺序](AppendixH.html#authplugin-overview)
  - [H.6 消息格式](AppendixH.html#authplugin-messages)
  - [H.7 参考文献](AppendixH.html#authplugin-refs)
- [指数](IndexPage.html#Index)

------

如果您想提供有关本手册或 PuTTY 工具本身的反馈，请参阅[反馈页面](https://www.chiark.greenend.org.uk/~sgtatham/putty/feedback.html)。

[PuTTY release 0.78]



