以命令行方式安装Windows功能，居然可以有这么多不同的命令！

副标题：一文区分不同的Windows功能安装命令



前一阵我在搜集相关素材用以完成 [《如何离线安装XPS查看器》](https://www.sysadm.cc/index.php/xitongyunwei/781-how-to-install-xps-viewer-offline) 一文时，偶然搜索到了一篇老外的博客。

这篇博客挺有意思，讲的是使用命令行方式安装Windows功能，可以通过多种不同的命令来实现。

这引起了我的好奇，于是我把它的内容翻译加工并总结了一下，分享给小伙伴儿们。

老外博客链接：https://hahndorf.eu/blog/WindowsFeatureViaCmd



正式开始之前，先来啰嗦几句，说说 Windows 功能 是指什么。

在 Window7 系统中它被称作 `打开或关闭 Windows 功能` 。

图1



而在 Windows10 系统中它则被称作 `启用或关闭 Windows 功能` 。

图2



同时，Windows10 系统中还有另一个叫作 `可选功能` 的新东东。

图3



好了，可以开始了。

通常我们都是用鼠标指指点点就完成功能的安装和卸载的。

但是，要想完美地使用命令行来安装Windows功能，以下命令你会选择哪一个呢？

* Add-WindowsCapability
* Enable-WindowsOptionalFeature
* Install-WindowsFeature
* Add-WindowsFeature
* dism.exe
* pkgmgr.exe



What F*？你可能要尖叫起来了！

什么鬼，哪儿来这么多命令啊？

嘿嘿别着急，长相相似的它们还是有区别的，接着往下看就是了。



### 先提一嘴 `Add-WindowsCapability` ，它是个新来的

先说一点，这个 `*-WindowsCapability` 样式的命令其实是 `Windows 10` 和 `Server 2016` 及其后续版本中新添加的。

它与 `Enable-WindowsOptionalFeature`  命令功能及其相似，并且更加强大的是，它还可以从 `Windows Update` 或本地存储库下载程序包。



### 这些命令分别用在哪些支持平台上呢

|                               | Vista+2008 | Win7 | 2008R2 | Win8.* | 2012R* | Win10 | 2016 | Nano | Source                |
| ----------------------------- | :--------: | :--: | :----: | :----: | :----: | :---: | :--: | :--: | :-------------------- |
| Enable-WindowsOptionalFeature |            |      |        |   *    |   *    |   *   |  *   |  *   | Dism module           |
| Get-WindowsOptionalFeature    |            |      |        |   *    |   *    |   *   |  *   |  *   | Dism module           |
| Get-WindowsCapability         |            |      |        |        |        |   *   |  *   |  ?   | Dism module           |
| Install-WindowsFeature        |            |      |        |        |   *    |       |  *   |      | ServerManager module  |
| Get-WindowsFeature            |            |      |   *    |        |   *    |       |  *   |      | ServerManager module  |
| Add-WindowsFeature            |            |      |   *    |        |   A    |       |  A   |      | ServerManager module  |
| dism.exe                      |            |  *   |   *    |   *    |   *    |   *   |  *   |  *   | %SystemRoot%\System32 |
| pkgmgr.exe                    |     *      |  *   |   *    |   *    |   *    |   *   |  *   |  *   | %SystemRoot%\System32 |

A = An alias for Install-WindowsFeature（Install WindowsFeature的别名）



这张表格很重要，从中能看出来，来源是 `Server Manager`  的命令只能在服务器上使用，或者在工作站上安装远程管理工具时可用。

如果你要在一般的客户端计算机上使用，那么不好意思请使用 `Dism` 命令。

 同时为了彻底的安全起见，请使用 `dism.exe` 。

 如果你还在用 `Vista/Server 2008`，那么你还是看看 `pkgmgr.exe` 吧。



### 为啥会有两套不同的 `PowerShell` 命令呢

问得好！

我猜测可能微软存在两支截然不同的团队。

其一服务器管理团队，他们创建了相应的命令行以支持服务器管理中的功能。

另外一支 `dism` 团队（？），它们创建了 `dism.exe` 却猛然发现已经另有类似功能的程序，可是他们又不想放弃他们的程序。

其实我看这些命令不止两套，挺乱的，接着往下看。



### 不同功能

让我们看看命令的详细说明:

```
PS C:\> Install-WindowsFeature [-Name] <Feature[]> [-ComputerName <String>] [-Credential <PSCredential>]
 [-IncludeAllSubFeature] [-IncludeManagementTools] [-LogPath <String>] [-Restart] [-Source <String[]>] [-Confirm]
 [-WhatIf] [<CommonParameters>]

PS C:\> Install-WindowsFeature [-ComputerName <String>] [-Credential <PSCredential>] [-LogPath <String>] [-Restart]
 [-Source <String[]>] [-Vhd <String>] -ConfigurationFilePath <String> [-Confirm] [-WhatIf] [<CommonParameters>]

PS C:\> Install-WindowsFeature [-Name] <Feature[]> [-ComputerName <String>] [-Credential <PSCredential>]
 [-IncludeAllSubFeature] [-IncludeManagementTools] [-LogPath <String>] [-Source <String[]>] -Vhd <String>
 [-Confirm] [-WhatIf] [<CommonParameters>]
```

 

和这个比较一下：

```
PS C:\> Enable-WindowsOptionalFeature [-All] [-LimitAccess] [-LogLevel <LogLevel>] [-LogPath <String>] [-NoRestart]
 [-PackageName <String>] [-ScratchDirectory <String>] [-Source <String[]>] [-SystemDrive <String>]
 [-WindowsDirectory <String>] -FeatureName <String[]> -Online [<CommonParameters>]

PS C:\> Enable-WindowsOptionalFeature [-All] [-LimitAccess] [-LogLevel <LogLevel>] [-LogPath <String>] [-NoRestart]
 [-PackageName <String>] [-ScratchDirectory <String>] [-Source <String[]>] [-SystemDrive <String>]
 [-WindowsDirectory <String>] -FeatureName <String[]> -Path <String> [<CommonParameters>]
```



一个很大的区别是，服务器管理命令可以针对远程计算机工作，而 `dism` 只能在本地工作，当然它可以针对离线脱机环境的安装。

`Install-WindowsFeature` 支持一个很棒的技巧，如果您想知道已经安装了哪些其他功能，可以使用 `-whatif` 开关。

这在使用 `*-includealsubfeature` 时有效，但在安装角色时，它只列出它将要安装的所有子功能。

同样，`UnInstall-WindowsFeature` 命令的使用方法相同，你试试看就知道了。

```
PS C:\> UnInstall-WindowsFeature -Name NET-Framework-45-Features -whatif
```

像这样你可以查看到 `.Net Framework` 都有哪些子功能而不用真的卸载它。



### 不同的 Windows 功能名称

两组命令行都各自使用了自己命名的功能名称 :-(。

`dism module` 命令行使用与其字面意思相同的名称 `dism.exe` ，所以如果你以前用惯了就可以继续接着用。

服务器管理命令行则使用了不同的名称。

在服务器 `2012 R2` 系统上执行以下测试。

```powershell
PS C:\> Get-WindowsFeature | Select Name | Sort Name
```

结果返回 267 项功能。

```powershell
PS C:\> Get-WindowsOptionalFeature -Online | Select FeatureName | Sort FeatureName
```

结果返回 311 项功能，和下面命令返回的结果完全一样：

```powershell
PS C:\> Dism.exe -Online -Get-Features
```



### Windows功能名称列表

| *-WindowsOptionalFeature (Dism)                              | *-WindowsFeature (Server-Manager)                            |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ActiveDirectory-PowerShell <br/>ADCertificateServicesManagementTools <br/>ADCertificateServicesRole <br/>AdminUI <br/>Application-Server <br/>Application-Server-HTTP-Activation <br/>Application-Server-MSMQ-Activation <br/>Application-Server-Pipe-Activation <br/>Application-Server-TCP-Activation <br/>Application-Server-TCP-Port-Sharing <br/>Application-Server-WAS-Support <br/>Application-Server-WebServer-Support <br/>AppServer <br/>AS-Dist-Transaction <br/>AS-Ent-Services <br/>AS-Incoming-Trans <br/>AS-NET-Framework <br/>AS-Outgoing-Trans <br/>AS-WS-Atomic <br/>AuthManager <br/>BdeAducExtTool <br/>BiometricFramework <br/>BitLocker <br/>BitLocker-NetworkUnlock <br/>BitLocker-RemoteAdminTool <br/>Bitlocker-Utilities <br/>BITS <br/>BITSExtensions-AdminPack <br/>BITSExtensions-Upload <br/>BusScan-ScanServer <br/>CCFFilter <br/>CertificateEnrollmentPolicyServer <br/>CertificateEnrollmentServer <br/>CertificateServices <br/>CertificateServicesManagementTools <br/>ClientForNFS-Infrastructure <br/>CoreFileServer <br/>CoreFileServer-RSAT <br/>DamgmtTools <br/>DataCenterBridging <br/>Dedup-Core <br/>DesktopExperience <br/>DfsMgmt <br/>DFSN-Server <br/>DFSR-Infrastructure-ServerEdition <br/>DHCPServer <br/>DHCPServer-Tools <br/>DirectoryServices-ADAM <br/>DirectoryServices-ADAM-Tools <br/>DirectoryServices-AdministrativeCenter <br/>DirectoryServices-DomainController <br/>DirectoryServices-DomainController-Tools <br/>DirectoryServices-ISM-Smtp <br/>DirectPlay <br/>DNS-Server-Full-Role <br/>DNS-Server-Tools <br/>DSC-Service <br/>EnhancedStorage <br/>FailoverCluster-AdminPak <br/>FailoverCluster-AutomationServer <br/>FailoverCluster-CmdInterface <br/>FailoverCluster-FullServer <br/>FailoverCluster-Mgmt <br/>FailoverCluster-PowerShell <br/>FaxServiceConfigRole <br/>FaxServiceRole <br/>FileAndStorage-Services <br/>FileServerVSSAgent <br/>File-Services <br/>File-Services-Search-Service <br/>FRS-Infrastructure <br/>FSRM-Infrastructure <br/>FSRM-Infrastructure-Services <br/>FSRM-Management <br/>Gateway <br/>Gateway-UI <br/>HCAP-Server <br/>HCSRuntime <br/>HCSUI <br/>IAS NT Service <br/>IdentityServer-SecurityTokenService <br/>IIS-ApplicationDevelopment <br/>IIS-ApplicationInit <br/>IIS-ASP <br/>IIS-ASPNET <br/>IIS-ASPNET45 <br/>IIS-BasicAuthentication <br/>IIS-CertProvider <br/>IIS-CGI <br/>IIS-ClientCertificateMappingAuthentication <br/>IIS-CommonHttpFeatures <br/>IIS-CustomLogging <br/>IIS-DefaultDocument <br/>IIS-DigestAuthentication <br/>IIS-DirectoryBrowsing <br/>IIS-FTPExtensibility <br/>IIS-FTPServer <br/>IIS-FTPSvc <br/>IIS-HealthAndDiagnostics <br/>IIS-HostableWebCore <br/>IIS-HttpCompressionDynamic <br/>IIS-HttpCompressionStatic <br/>IIS-HttpErrors <br/>IIS-HttpLogging <br/>IIS-HttpRedirect <br/>IIS-HttpTracing <br/>IIS-IIS6ManagementCompatibility <br/>IIS-IISCertificateMappingAuthentication <br/>IIS-IPSecurity <br/>IIS-ISAPIExtensions <br/>IIS-ISAPIFilter <br/>IIS-LegacyScripts <br/>IIS-LegacySnapIn <br/>IIS-LoggingLibraries <br/>IIS-ManagementConsole <br/>IIS-ManagementScriptingTools <br/>IIS-ManagementService <br/>IIS-Metabase <br/>IIS-NetFxExtensibility <br/>IIS-NetFxExtensibility45 <br/>IIS-ODBCLogging <br/>IIS-Performance <br/>IIS-RequestFiltering <br/>IIS-RequestMonitor <br/>IIS-Security <br/>IIS-ServerSideIncludes <br/>IIS-StaticContent <br/>IIS-URLAuthorization <br/>IIS-WebDAV <br/>IIS-WebServer <br/>IIS-WebServerManagementTools <br/>IIS-WebServerRole <br/>IIS-WebSockets <br/>IIS-WindowsAuthentication <br/>IIS-WMICompatibility <br/>InkAndHandwritingServices <br/>Internet-Explorer-Optional-amd64 <br/>IPAMClientFeature <br/>IPAMServerFeature <br/>iSCSITargetServer <br/>iSCSITargetServer-PowerShell <br/>iSCSITargetStorageProviders <br/>iSNS_Service <br/>KeyDistributionService-PSH-Cmdlets <br/>LegacyComponents <br/>Licensing <br/>Licensing-Diagnosis-UI <br/>Licensing-UI <br/>LightweightServer <br/>ManagementOdata <br/>MediaPlayback <br/>Microsoft-Hyper-V <br/>Microsoft-Hyper-V-Management-Clients <br/>Microsoft-Hyper-V-Management-PowerShell <br/>Microsoft-Hyper-V-Offline <br/>Microsoft-Hyper-V-Online <br/>Microsoft-Windows-Deployment-Services <br/>Microsoft-Windows-Deployment-Services-Admin-Pack <br/>Microsoft-Windows-Deployment-Services-Deployment-Server <br/>Microsoft-Windows-Deployment-Services-Legacy-SIS <br/>Microsoft-Windows-Deployment-Services-Transport-Server <br/>Microsoft-Windows-FCI-Client-Package <br/>Microsoft-Windows-GroupPolicy-ServerAdminTools-Update <br/>MicrosoftWindowsPowerShell <br/>MicrosoftWindowsPowerShellISE <br/>MicrosoftWindowsPowerShellRoot <br/>MicrosoftWindowsPowerShellV2 <br/>Microsoft-Windows-ServerEssentials-ServerSetup <br/>Microsoft-Windows-Web-Services-for-Management-IIS-Extension <br/>MSMQ <br/>MSMQ-ADIntegration <br/>MSMQ-DCOMProxy <br/>MSMQ-HTTP <br/>MSMQ-Multicast <br/>MSMQ-RoutingServer <br/>MSMQ-Server <br/>MSMQ-Services <br/>MSMQ-Triggers <br/>MSRDC-Infrastructure <br/>MultipathIo <br/>NetFx3 <br/>NetFx3ServerFeatures <br/>NetFx4 <br/>NetFx4Extended-ASPNET45 <br/>NetFx4ServerFeatures <br/>NetworkDeviceEnrollmentServices <br/>NetworkLoadBalancingFullServer <br/>NetworkLoadBalancingManagementClient <br/>NFS-Administration <br/>NIS <br/>NPAS-Role <br/>NPSManagementTools <br/>OEM-Appliance-OOBE <br/>OnlineRevocationServices <br/>OnlineRevocationServicesManagementTools <br/>P2P-PnrpOnly <br/>PeerDist <br/>PKIClient-PSH-Cmdlets <br/>Printing-AdminTools-Collection <br/>Printing-Client <br/>Printing-Client-Gui <br/>Printing-InternetPrinting-Client <br/>Printing-InternetPrinting-Server <br/>Printing-LPDPrintService <br/>Printing-LPRPortMonitor <br/>Printing-Server-Foundation-Features <br/>Printing-Server-Role <br/>Printing-XPSServices-Features <br/>PSync <br/>QWAVE <br/>RasCMAK <br/>RasRoutingProtocols <br/>RasServerAdminTools <br/>RemoteAccess <br/>RemoteAccessMgmtTools <br/>RemoteAccessPowerShell <br/>RemoteAccessServer <br/>RemoteAssistance <br/>Remote-Desktop-Services <br/>ResumeKeyFilter <br/>RightsManagementServices <br/>RightsManagementServices-AdminTools <br/>RightsManagementServicesManagementTools <br/>RightsManagementServices-Role <br/>RMS-Federation <br/>RPC-HTTP_Proxy <br/>RSAT <br/>RSAT-ADDS-Tools-Feature <br/>RSAT-AD-Tools-Feature <br/>RSAT-Hyper-V-Tools-Feature <br/>RSAT-NIS <br/>RSAT-RDS-Tools-Feature <br/>SBMgr-UI <br/>SearchEngine-Server-Package <br/>Security-SPP-Vmw <br/>ServerCore-Drivers-General <br/>ServerCore-EA-IME <br/>ServerCore-EA-IME-WOW64 <br/>ServerCore-FullServer <br/>ServerCore-WOW64 <br/>Server-Drivers-General <br/>Server-Drivers-Printers <br/>ServerForNFS-Infrastructure <br/>Server-Gui-Mgmt <br/>Server-Gui-Shell <br/>ServerManager-Core-RSAT <br/>ServerManager-Core-RSAT-Feature-Tools <br/>ServerManager-Core-RSAT-Role-Tools <br/>Server-Manager-RSAT-File-Services <br/>ServerMediaFoundation <br/>ServerMigration <br/>Server-Psh-Cmdlets <br/>Server-RSAT-SNMP <br/>ServicesForNFS-ServerAndClient <br/>SessionDirectory <br/>SimpleTCP <br/>SIS-Limited <br/>SMB1Protocol <br/>SMBBW <br/>SmbDirect <br/>SMBHashGeneration <br/>SmbWitness <br/>Smtpsvc-Admin-Update-Name <br/>Smtpsvc-Service-Update-Name <br/>SNMP <br/>Storage-Services <br/>TelnetClient <br/>TelnetServer <br/>TFTP <br/>TIFFIFilter <br/>TlsSessionTicketKey-PSH-Cmdlets <br/>UpdateServices <br/>UpdateServices-API <br/>UpdateServices-Database <br/>UpdateServices-RSAT <br/>UpdateServices-Services <br/>UpdateServices-UI <br/>UpdateServices-WidDatabase <br/>User-Interfaces-Infra <br/>VmHostAgent <br/>VolumeActivation-Full-Role <br/>WAS-ConfigurationAPI <br/>WAS-NetFxEnvironment <br/>WAS-ProcessModel <br/>WAS-WindowsActivationService <br/>WCF-HTTP-Activation <br/>WCF-HTTP-Activation45 <br/>WCF-MSMQ-Activation45 <br/>WCF-NonHTTP-Activation <br/>WCF-Pipe-Activation45 <br/>WCF-Services45 <br/>WCF-TCP-Activation45 <br/>WCF-TCP-PortSharing45 <br/>WebAccess <br/>Web-Application-Proxy <br/>WebEnrollmentServices <br/>WindowsFeedbackForwarder <br/>Windows-Identity-Foundation <br/>Windows-Internal-Database <br/>WindowsMediaPlayer <br/>WindowsPowerShellWebAccess <br/>WindowsServerBackup <br/>WindowsServerBackupSnapin <br/>WindowsStorageManagementService <br/>WINSRuntime <br/>WINS-Server-Tools <br/>WirelessNetworking <br/>WMISnmpProvider <br/>WorkFolders-Server <br/>WSS-Product-Package <br/>Xps-Foundation-Xps-Viewer | AD-Certificate <br/>ADCS-Cert-Authority <br/>ADCS-Device-Enrollment <br/>ADCS-Enroll-Web-Pol <br/>ADCS-Enroll-Web-Svc <br/>ADCS-Online-Cert <br/>ADCS-Web-Enrollment <br/>AD-Domain-Services <br/>ADFS-Federation <br/>ADLDS <br/>ADRMS <br/>ADRMS-Identity <br/>ADRMS-Server <br/>Application-Server <br/>AS-Dist-Transaction <br/>AS-Ent-Services <br/>AS-HTTP-Activation <br/>AS-Incoming-Trans <br/>AS-MSMQ-Activation <br/>AS-Named-Pipes <br/>AS-NET-Framework <br/>AS-Outgoing-Trans <br/>AS-TCP-Activation <br/>AS-TCP-Port-Sharing <br/>AS-WAS-Support <br/>AS-Web-Support <br/>AS-WS-Atomic <br/>Biometric-Framework <br/>BitLocker <br/>BitLocker-NetworkUnlock <br/>BITS <br/>BITS-Compact-Server <br/>BITS-IIS-Ext <br/>BranchCache <br/>CMAK <br/>Data-Center-Bridging <br/>Desktop-Experience <br/>DHCP <br/>DirectAccess-VPN <br/>Direct-Play <br/>DNS <br/>DSC-Service <br/>EnhancedStorage <br/>Failover-Clustering <br/>Fax <br/>FileAndStorage-Services <br/>File-Services <br/>FS-BranchCache <br/>FS-Data-Deduplication <br/>FS-DFS-Namespace <br/>FS-DFS-Replication <br/>FS-FileServer <br/>FS-iSCSITarget-Server <br/>FS-NFS-Service <br/>FS-Resource-Manager <br/>FS-SMB1 <br/>FS-SMBBW <br/>FS-SyncShareService <br/>FS-VSS-Agent <br/>GPMC <br/>Hyper-V <br/>Hyper-V-PowerShell <br/>Hyper-V-Tools <br/>InkAndHandwritingServices <br/>Internet-Print-Client <br/>IPAM <br/>IPAM-Client-Feature <br/>iSCSITarget-VSS-VDS <br/>ISNS <br/>LPR-Port-Monitor <br/>ManagementOdata <br/>Migration <br/>MSMQ <br/>MSMQ-DCOM <br/>MSMQ-Directory <br/>MSMQ-HTTP-Support <br/>MSMQ-Multicasting <br/>MSMQ-Routing <br/>MSMQ-Server <br/>MSMQ-Services <br/>MSMQ-Triggers <br/>Multipath-IO <br/>NET-Framework-45-ASPNET <br/>NET-Framework-45-Core <br/>NET-Framework-45-Features <br/>NET-Framework-Core <br/>NET-Framework-Features <br/>NET-HTTP-Activation <br/>NET-Non-HTTP-Activ <br/>NET-WCF-HTTP-Activation45 <br/>NET-WCF-MSMQ-Activation45 <br/>NET-WCF-Pipe-Activation45 <br/>NET-WCF-Services45 <br/>NET-WCF-TCP-Activation45 <br/>NET-WCF-TCP-PortSharing45 <br/>NFS-Client <br/>NLB <br/>NPAS <br/>NPAS-Health <br/>NPAS-Host-Cred <br/>NPAS-Policy-Server <br/>PNRP <br/>PowerShell <br/>PowerShell-ISE <br/>PowerShellRoot <br/>PowerShell-V2 <br/>Print-Internet <br/>Print-LPD-Service <br/>Print-Scan-Server <br/>Print-Server <br/>Print-Services <br/>qWave <br/>RDC <br/>RDS-Connection-Broker <br/>RDS-Gateway <br/>RDS-Licensing <br/>RDS-Licensing-UI <br/>RDS-RD-Server <br/>RDS-Virtualization <br/>RDS-Web-Access <br/>RemoteAccess <br/>Remote-Assistance <br/>Remote-Desktop-Services <br/>Routing <br/>RPC-over-HTTP-Proxy <br/>RSAT <br/>RSAT-AD-AdminCenter <br/>RSAT-ADCS <br/>RSAT-ADCS-Mgmt <br/>RSAT-ADDS <br/>RSAT-ADDS-Tools <br/>RSAT-ADLDS <br/>RSAT-AD-PowerShell <br/>RSAT-ADRMS <br/>RSAT-AD-Tools <br/>RSAT-Bits-Server <br/>RSAT-Clustering <br/>RSAT-Clustering-AutomationServer <br/>RSAT-Clustering-CmdInterface <br/>RSAT-Clustering-Mgmt <br/>RSAT-Clustering-PowerShell <br/>RSAT-CoreFile-Mgmt <br/>RSAT-DFS-Mgmt-Con <br/>RSAT-DHCP <br/>RSAT-DNS-Server <br/>RSAT-Fax <br/>RSAT-Feature-Tools <br/>RSAT-Feature-Tools-BitLocker <br/>RSAT-Feature-Tools-BitLocker-BdeAducExt <br/>RSAT-Feature-Tools-BitLocker-RemoteAdminTool <br/>RSAT-File-Services <br/>RSAT-FSRM-Mgmt <br/>RSAT-Hyper-V-Tools <br/>RSAT-NFS-Admin <br/>RSAT-NIS <br/>RSAT-NLB <br/>RSAT-NPAS <br/>RSAT-Online-Responder <br/>RSAT-Print-Services <br/>RSAT-RDS-Gateway <br/>RSAT-RDS-Licensing-Diagnosis-UI <br/>RSAT-RDS-Tools <br/>RSAT-RemoteAccess <br/>RSAT-RemoteAccess-Mgmt <br/>RSAT-RemoteAccess-PowerShell <br/>RSAT-Role-Tools <br/>RSAT-SMTP <br/>RSAT-SNMP <br/>RSAT-VA-Tools <br/>RSAT-WINS <br/>Search-Service <br/>ServerEssentialsRole <br/>Server-Gui-Mgmt-Infra <br/>Server-Gui-Shell <br/>Server-Media-Foundation <br/>Simple-TCPIP <br/>SMTP-Server <br/>SNMP-Service <br/>SNMP-WMI-Provider <br/>Storage-Services <br/>Telnet-Client <br/>Telnet-Server <br/>TFTP-Client <br/>UpdateServices <br/>UpdateServices-API <br/>UpdateServices-DB <br/>UpdateServices-RSAT <br/>UpdateServices-Services <br/>UpdateServices-UI <br/>UpdateServices-WidDB <br/>User-Interfaces-Infra <br/>VolumeActivation <br/>WAS <br/>WAS-Config-APIs <br/>WAS-NET-Environment <br/>WAS-Process-Model <br/>WDS <br/>WDS-AdminPack <br/>WDS-Deployment <br/>WDS-Transport <br/>Web-App-Dev <br/>Web-AppInit <br/>Web-Application-Proxy <br/>Web-ASP <br/>Web-Asp-Net <br/>Web-Asp-Net45 <br/>Web-Basic-Auth <br/>Web-Cert-Auth <br/>Web-CertProvider <br/>Web-CGI <br/>Web-Client-Auth <br/>Web-Common-Http <br/>Web-Custom-Logging <br/>Web-DAV-Publishing <br/>Web-Default-Doc <br/>Web-Digest-Auth <br/>Web-Dir-Browsing <br/>Web-Dyn-Compression <br/>Web-Filtering <br/>Web-Ftp-Ext <br/>Web-Ftp-Server <br/>Web-Ftp-Service <br/>Web-Health <br/>Web-Http-Errors <br/>Web-Http-Logging <br/>Web-Http-Redirect <br/>Web-Http-Tracing <br/>Web-Includes <br/>Web-IP-Security <br/>Web-ISAPI-Ext <br/>Web-ISAPI-Filter <br/>Web-Lgcy-Mgmt-Console <br/>Web-Lgcy-Scripting <br/>Web-Log-Libraries <br/>Web-Metabase <br/>Web-Mgmt-Compat <br/>Web-Mgmt-Console <br/>Web-Mgmt-Service <br/>Web-Mgmt-Tools <br/>Web-Net-Ext <br/>Web-Net-Ext45 <br/>Web-ODBC-Logging <br/>Web-Performance <br/>Web-Request-Monitor <br/>Web-Scripting-Tools <br/>Web-Security <br/>Web-Server <br/>Web-Stat-Compression <br/>Web-Static-Content <br/>Web-Url-Auth <br/>Web-WebServer <br/>Web-WebSockets <br/>Web-WHC <br/>Web-Windows-Auth <br/>Web-WMI <br/>WFF <br/>Windows-Identity-Foundation <br/>Windows-Internal-Database <br/>WindowsPowerShellWebAccess <br/>Windows-Server-Backup <br/>WindowsStorageManagementService <br/>Windows-TIFF-IFilter <br/>WinRM-IIS-Ext <br/>WINS <br/>Wireless-Networking <br/>WoW64-Support <br/>XPS-Viewer |



### `dism.exe` 和 `PowerShell`

如果你在较旧版本的Windows上不使用 `PowerShell` 的话，那么可以使用 `dism.exe` 来安装可选功能。

下面是一些 `PowerShell` 代码，用于检查是否安装了某项功能。

```powershell
$tempFile = "$env:temp\tempName.log"
& dism.exe /online /get-features /format:table | out-file $tempFile -Force       
$WinFeatures = (Import-CSV -Delim '|' -Path $tempFile -Header Name,state | Where-Object {$_.State -eq "Enabled "}) | Select Name
Remove-Item -Path $tempFile 
```

前面你也已经看到了 *所有Windows功能名称列表* ，这时你可以通过以下演示代码检查是否存在这样的功能。

```
if(($WinFeatures | Where-Object {$_.Name.Trim() -eq "WirelessNetworking"}) -eq $null) {...}
```



### 最后总结发言

说了这么多，其实可以总结为以下几点。

1、`*-WindowsOptionalFeature (Dism) ` 用于客户端计算机。

2、`*-WindowsFeature (Server-Manager)` 用于服务端计算机。

3、`*-WindowsCapability` 用于 `Windows10` 系统。

4、`dism.exe` （Dism）可以用于任何计算机，包括客户端和服务端，包括旧版本的 Windows。



嘿嘿，小伙伴儿们是不是还是有点头晕呢？

说实话，反正我现在还晕着呢。

**总之一句话，具体用哪个命令随时可以参考前面说的 “命令支持平台列表” 那张表格，而 `dism.exe` 命令则是万能的。**

OK，小伙伴儿们，你们 Get 到了吗？



> WeChat@网管小贾 | www.sysadm.cc

