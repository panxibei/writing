:: --------------------------------------------1--------------------------------------
:: ����mrtg�����ļ�

set strIP=x.x.x.x
:: �����������һ����public
set strComminuty=public
set strPath=x_x_x_x
set strCfgFilename=mrtg_x_x_x_x.cfg

mkdir c:\wamp\www\%strPath%
start /b /w perl cfgmaker %strComminuty%@%strIP% --global "WorkDir: c:\wamp\www\%strPath%" --output %strCfgFilename%

:: ��������� RunAsDaemon: yes
echo Options[_]: growright, bits>> %CD%\tmp1.txt
echo RunAsDaemon: yes>> %CD%\tmp1.txt
type %strCfgFilename% >> %CD%\tmp1.txt

del /f /q %CD%\%strCfgFilename%

rename %CD%\tmp1.txt %strCfgFilename%

pause


:: -------------------------------------------2-----------------------------------------
:: ע�⣬output�����·����index.html���ļ����������������֣������豸�����֣�
:: mrtg.cfg�ļ������޸�Ϊʵ�ʶ�Ӧ�豸�������ļ���

set strPath=x_x_x_x
set strCfgFilename=mrtg_x_x_x_x.cfg

del /F /S /Q c:\wamp64\www\%strPath%\*.*

perl indexmaker --output=c:\wamp64\www\%strPath%\index.html %strCfgFilename% --columns=1

:: start /Dc:\mrtg\bin wperl mrtg --logging=eventlog %strCfgFilename%

pause


:: -------------------------------------------3----------------------------------------
:: ��װ������Ҫ����ԱȨ�ޣ�

set strServiceName=MRTG_x_x_x_x
set strSrvanyPath=c:\mrtg\bin
set strSrvanyPathReg=c:\\mrtg\\bin

%strSrvanyPath%\instsrv %strServiceName% %strSrvanyPath%\srvany.exe

:: �ֶ���������ע�������
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