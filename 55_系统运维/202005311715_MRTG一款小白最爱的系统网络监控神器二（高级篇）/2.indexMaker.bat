:: 注意，output后面接路径。index.html的文件名可以是其他名字（例如设备的名字）
:: mrtg.cfg文件名可修改为实际对应设备的配置文件名

set strPath=x_x_x_x
set strCfgFilename=mrtg_x_x_x_x.cfg

del /F /S /Q c:\wamp64\www\%strPath%\*.*

perl indexmaker --output=c:\wamp64\www\%strPath%\index.html %strCfgFilename% --columns=1

:: start /Dc:\mrtg\bin wperl mrtg --logging=eventlog %strCfgFilename%

pause