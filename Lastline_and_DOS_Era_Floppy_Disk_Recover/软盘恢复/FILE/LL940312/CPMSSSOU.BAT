@echo off
Echo Format: CPCHSOU A: or CPCHSOU B:
echo Press  Ctrl+C  to stop...
pause
echo on
del %1*.*
copy DELMSS.C %1/v           
copy SAVEFAT.C %1/v
copy IBMPC.C %1/v           
copy INSTALL.C %1/v          
copy MSS1.C %1/v             
copy MSS2.C %1/v          
copy MSS3.C %1/v           
copy MKHIGH.C   %1/v         
copy BTMNGR.C %1/v          
copy TWINDOW.C   %1/v        
copy TWINGRA.C   %1/v        
copy DOS.H       %1/v     
copy KEYS.H      %1/v      
copy TWINDOW.H   %1/v         
copy TWINGRA.H   %1/v         
copy DELMSS.PRJ   %1/v          
copy SAVEFAT.PRJ %1/v            
copy INSTALL.PRJ  %1/v           
copy MSS2.PRJ %1/v            
copy MSS3.PRJ %1/v            
copy BTMNGR.PRJ %1/v            
copy GRAPHICS.LIB %1/v        
copy SOURCE.C     %1/v          
copy MSSHZ.LIB     %1/v   
copy CPMSSEXE.BAT  %1/v          
copy CPMSSSOU.BAT   %1/v
