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