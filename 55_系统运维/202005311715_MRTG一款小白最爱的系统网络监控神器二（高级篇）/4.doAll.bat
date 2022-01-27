:: --------------------------------------------1--------------------------------------
:: 生成mrtg配置文件

set strIP=x.x.x.x
:: 下面这个团体一般是public
set strComminuty=public
set strPath=x_x_x_x
set strCfgFilename=mrtg_x_x_x_x.cfg

mkdir c:\wamp\www\%strPath%
start /b /w perl cfgmaker %strComminuty%@%strIP% --global "WorkDir: c:\wamp\www\%strPath%" --output %strCfgFilename%

:: 别忘记添加 RunAsDaemon: yes
echo Options[_]: growright, bits>> %CD%\tmp1.txt
echo RunAsDaemon: yes>> %CD%\tmp1.txt
type %strCfgFilename% >> %CD%\tmp1.txt

del /f /q %CD%\%strCfgFilename%

rename %CD%\tmp1.txt %strCfgFilename%

pause


:: -------------------------------------------2-----------------------------------------
:: 注意，output后面接路径。index.html的文件名可以是其他名字（例如设备的名字）
:: mrtg.cfg文件名可修改为实际对应设备的配置文件名

set strPath=x_x_x_x
set strCfgFilename=mrtg_x_x_x_x.cfg

del /F /S /Q c:\wamp64\www\%strPath%\*.*

perl indexmaker --output=c:\wamp64\www\%strPath%\index.html %strCfgFilename% --columns=1

:: start /Dc:\mrtg\bin wperl mrtg --logging=eventlog %strCfgFilename%

pause


:: -------------------------------------------3----------------------------------------
:: 安装服务（需要管理员权限）

set strServiceName=MRTG_x_x_x_x
set strSrvanyPath=c:\mrtg\bin
set strSrvanyPathReg=c:\\mrtg\\bin

%strSrvanyPath%\instsrv %strServiceName% %strSrvanyPath%\srvany.exe

:: 手动导入以下注册表内容
:: ============================================
:: Windows Registry Editor Version 5.00
:: 
:: [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MRTG_x_x_x_x\Parameters]
:: "Application"="c:\\perl64\\bin\\wperl.exe"
:: "AppParameters"="c:\\mrtg\\bin\\mrtg --logging=eventlog c:\\mrtg\\bin\\mrtg_x_x_x_x.cfg"
:: "AppDirectory"="c:\\mrtg\\bin\\"
:: ============================================

echo Windows Registry Editor Version 5.00>>%strSrvanyPath%\%strServiceName%.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\%strServiceName%\Parameters]>>%strSrvanyPath%\%strServiceName%.reg
echo "Application"="c:\\perl64\\bin\\wperl.exe">>%strSrvanyPath%\%strServiceName%.reg
echo "AppParameters"="%strSrvanyPathReg%\\mrtg --logging=eventlog %strSrvanyPathReg%\\%strServiceName%.cfg">>%strSrvanyPath%\%strServiceName%.reg
echo "AppDirectory"="%strSrvanyPathReg%\\">>%strSrvanyPath%\%strServiceName%.reg

reg import %strSrvanyPath%\%strServiceName%.reg /reg:64

pause