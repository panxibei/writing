男房东面对女租客一定要把握好分寸，特别是碰上Windows截图工具没有录屏功能时

副标题：男房东面对女租客一定要把握好分寸，特别是碰上Windows截图工具没有录屏功能时

英文：

关键字：





旧版截图工具没有录屏功能？

图a06



看一下版本，是 `10.x` 的。

图a07









如果电脑上已经有 `Appx` 安装器，那么直接双击就行了。

图a04



如果双击无法运行程序安装，就用命令行吧。

打开 `PowerShell` ，输入以下命令行，回车。

```
Add-AppPackage .\Microsoft.ScreenSketch_2022.2602.49.0_neutral_~_8wekyb3d8bbwe.Msixbundle
```



出现错误，少了依赖程序。

图a01



补足依赖程序。

```
Add-AppPackage .\Microsoft.WindowsAppRuntime.1.8_8000.879.2017.0_x64__8wekyb3d8bbwe.Msix
```



再次安装后，OK。

图a02





新安装的 `截图工具` 程序所在路径：

```
C:\Program Files\WindowsApps\Microsoft.ScreenSketch_11.2602.49.0_x64__8wekyb3d8bbwe\SnippingTool\SnippingTool.exe
```



原来旧版的 `截图工具` 程序，所在路径：

```
C:\Windows\system32\SnippingTool.exe
```





按下快捷组合键：`徽标键+Shift+S` ，弹出选择提示窗口。

图a08





新版果然有录屏功能！

图a03



再看看版本，是新版 `11.x` 的。

图a05





