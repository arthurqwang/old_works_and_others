<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>数字油田论坛暨因特奈特主义学术论坛 Digital Oilfield Forum & Internetism Forum</title>
</head>

<body>

<p align="center"><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg"><img border="0" src="../internetism.jpg"></a></p>
<p align="center"><font size="6" face="黑体">论坛全部专家/嘉宾</font></p>
<center>
<table border="0" width="500" cellspacing="0">
<%
        dim experts_num,fs, brief, brief_ch,objFSO,Dir,strFileName,i,j,each_line_num, line_num,n
        each_line_num=4    
        experts_num=0
        Set objFSO = Server.CreateObject("Scripting.FileSystemObject6")
        do
          brief_ch="../experts/"&(experts_num+1)
          strFileName= Server.MapPath(brief_ch)
          Dir = objFSO.FolderExists(strFileName)
          if not dir then
            exit do
          else
            experts_num=experts_num+1
          end if
        loop

        line_num = Fix(experts_num/each_line_num)+1
        n=1
        set fs=server.createobject("MSWC.Nextlink")
        'response.write line_num&" "&n&" "&each_line_num
        j=1
        do while j<=line_num
          response.write "<tr>"
          i=1
          do while i<=each_line_num and n<=experts_num
            response.write "<td><p align='center'><a href='../experts/"&n&"/intro.htm' target='_blank'><img border='0' src='../experts/"&n&"/photo.jpg'><br>"
            brief_ch="../experts/"&n&"/brief.txt"
            brief=fs.getnexturl(brief_ch)
            response.write Left(brief,InStr(brief,"，")-1)
            response.write "</a></td>"
            n=n+1
            i=i+1
          loop
          response.write "</tr>"
           j=j+1
        loop
%>

</table>
</center>
</body>

</html>
