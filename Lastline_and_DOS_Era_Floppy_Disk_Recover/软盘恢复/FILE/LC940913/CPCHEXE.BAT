@echo off
echo Format: CPCHEXE A: or CPCHEXE B:
echo Press  Ctrl+C  to stop...
pause
echo on
del %1*.exe
del %1lsth.inf
mkhigh
copy delll.exe %1/v
copy fatrsave.exe %1/v
copy install.exe %1/v
copy mngrboot.exe %1/v
copy lastlin1.exe %1/v
copy lastlin2.exe %1/v
copy lastlin3.exe %1/v
copy lsth.inf %1/v
copy loadll.exe %1/v
