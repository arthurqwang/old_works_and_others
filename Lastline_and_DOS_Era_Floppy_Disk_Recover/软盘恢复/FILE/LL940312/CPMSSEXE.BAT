@echo off
echo Format: CPCHEXE A: or CPCHEXE B:
echo Press  Ctrl+C  to stop...
pause
echo on
del %1*.exe
del %1msshz.lib
mkhigh
copy delmss.exe %1/v
copy savefat.exe %1/v
copy btmngr.exe %1/v
copy mss1.exe %1/v
copy mss2.exe %1/v
copy mss3.exe %1/v
copy msshz.lib %1/v
copy install.exe %1/v
