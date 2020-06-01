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