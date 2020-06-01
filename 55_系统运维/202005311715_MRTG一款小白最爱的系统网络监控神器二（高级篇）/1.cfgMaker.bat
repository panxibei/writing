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