:: ע�⣬output�����·����index.html���ļ����������������֣������豸�����֣�
:: mrtg.cfg�ļ������޸�Ϊʵ�ʶ�Ӧ�豸�������ļ���

set strPath=x_x_x_x
set strCfgFilename=mrtg_x_x_x_x.cfg

del /F /S /Q c:\wamp64\www\%strPath%\*.*

perl indexmaker --output=c:\wamp64\www\%strPath%\index.html %strCfgFilename% --columns=1

:: start /Dc:\mrtg\bin wperl mrtg --logging=eventlog %strCfgFilename%

pause