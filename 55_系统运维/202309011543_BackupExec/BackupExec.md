BackupExec

副标题：

英文：

关键字：









官方支持文档一：

> How to enable Simplified Disaster Recovery backup when some files and/or folders on critical volumes are excluded
>
> https://origin-www.veritas.com/support/en_US/article.100013796



```
HKEY_LOCAL_MACHINE\SOFTWARE\Veritas\Backup Exec For Windows\Backup Exec\Engine\Simplified System Protection\User-Defined Exclusion Resources\D:
```

图x01

图x02



官方支持文档二：

> 重要なボリューム上の一部のファイルやフォルダが除外されている場合に、Simplified Disaster Recovery (SDR) を有効にする方法
>
> https://origin-www.veritas.com/support/en_US/article.100049483

 



```
<Backup Exec 21 以前>
HKEY_LOCAL_MACHINE\SOFTWARE\Symantec\Backup Exec For Windows\Backup Exec\Engine\Simplified System Protection\User-Defined Exclusion Resources\D:

<Backup Exec 21 以降>
HKEY_LOCAL_MACHINE\SOFTWARE\Veritas\Backup Exec For Windows\Backup Exec\Engine\Simplified System Protection\User-Defined Exclusion Resources\D:
```

图y01

图y02







官方关于备份关键系统组件的描述：

> https://www.veritas.com/content/support/en_US/doc/59226269-99535599-0/v60036296-99535599



以下系统资源被视为关键资源，如果您希望能够使用备份集执行完整系统还原，则必须将它们包含在备份中：

- 系统卷（包括 EFI 和实用程序分区）
- 启动卷（不包括操作系统）
- 服务应用程序卷（引导、系统和自动启动）
- 系统状态设备和卷（包括活动目录、系统文件等）
- 任何适用版本的 Windows 上的 Windows Recovery Partition （WinRE）





磁盘布局居然有问题。

