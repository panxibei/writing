奇葩的 PowerShell 内部错误，代码 80010106

副标题：







换个方式，通过命令提示符窗口执行看看。

```
PowerShell.exe -PSConsoleFile %SystemRoot%\System32\ServerMigrationTools\ServerMigration.psc1
```

图2



还是不行，但是很奇迹地出现了错误提示。

如果系统是英文版的，那么应该就有像下面这样的错误。

```
Internal Windows PowerShell error. COM initialization failed while reading Windows PowerShell console file with error 80010106.
```



有了具体的错误提示，至少离真相近了一步，上网搜吧。

找来找去都不知道这玩意儿是个啥，结果最后发现有大神指出其实只要这样那样。

相关帖子链接：

```
https://social.technet.microsoft.com/Forums/lync/en-US/ecf0a798-46d5-4925-8174-4f47dd5d332e/cannot-open-any-powershell-console-psc1-files?forum=winserverpowershell
```

图3



从图中也可以看出，虽然最初的问题描述并不相同，但最终还是指向了 `Powershell` 运行产生了错误 `80010106` 。

那么这个错误怎么解决呢？

说实话，我看完大神寥寥数语后仍是一头雾水，说什么把最近项目显示数量从2变成10就行了。

这都什么跟什么啊，真是青蛙跳井--不懂不懂不懂！

再找找吧！

直到找到这个帖子：

```
https://grzegorzkulikowski.info/2011/05/16/internal-windows-powershell-error-com-initialization-failed-while-reading-windows-powershell-console-file-with-error-80010106/
```

图4



好像有点那意思了，似乎是说开始菜单选项卡里有个最近打开项目什么的......

经过一番肉搏，终于被我找到了这个说不上来有啥用的东西。

其实就在 `控制面板` > `外观` > `任务栏和导航` 。

图5



随后真的就找到了他们所说的 `最近打开的项目` 。

图6



我最初打开的时候，并没有勾选任何项目，而且显示项目数也为 `0` 。

于是我将第二项打上勾，并将显示项目数设定为 `10` 。

然后再尝试打开 `Windows Server 迁移工具` ，奇迹出现了，居然就好使了！

图7



我去，这是什么奇葩问题啊！

我试着将那一项的勾去掉，显示项目数默认变为 `0` ，确定后再试着打开 `Windows Server 迁移工具` ，居然仍然好使！

我还在怀疑这个故障无法复现时，随手将第二项打上勾，显示项目数再变成 `0` 后，发现故障回来了！

这下明白了，这个问题与这个显示项目数有关。



至此，奇葩问题暂时得到解决，至于为什么会是这样，这中间的关系还真是无法搞懂。

小伙伴们，如果你遇到了 `PowerShell` 在执行时遇到 `80010106` 错误时，不妨按本文尝试一下，希望能帮到你们！



WeChat@网管小贾 | www.sysadm.cc

