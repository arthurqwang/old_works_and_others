@echo off
echo Format: CPENSOU A: or CPENSOU B:
Echo Press  Ctrl+C  to stop...
pause
echo on
del %1*.*
copy DELLL.C %1/v           
copy FATRSAVE.C %1/v
copy IBMPC.C %1/v           
copy INSTALL.C %1/v          
copy LASTLIN1.C %1/v             
copy LASTLIN2.C %1/v          
copy LASTLIN3.C %1/v           
copy MKLOW.C   %1/v         
copy MNGRBOOT.C %1/v          
copy TWINDOW.C   %1/v        
copy DOS.H       %1/v     
copy KEYS.H      %1/v      
copy TWINDOW.H   %1/v         
copy DELLL.PRJ   %1/v          
copy FATRSAVE.PRJ %1/v            
copy INSTALL.PRJ  %1/v           
copy LASTLIN2.PRJ %1/v            
copy LASTLIN3.PRJ %1/v            
copy MNGRBOOT.PRJ %1/v            
copy CPENEXE.BAT  %1/v          
copy CPENSOU.BAT   %1/v
