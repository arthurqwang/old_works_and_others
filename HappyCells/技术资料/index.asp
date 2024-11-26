<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
        dim ISSUE_NUM,fs, brief, days,brief_ch,objFSO,Dir,strFileName,begindate     
        ISSUE_NUM=0
        Set objFSO = Server.CreateObject("Scripting.FileSystemObject6")
        do
          brief_ch=Cstr(ISSUE_NUM+1)
          strFileName= Server.MapPath(brief_ch)
          Dir = objFSO.FolderExists(strFileName)
          if not dir then
            exit do
          else
            ISSUE_NUM=ISSUE_NUM+1
          end if
        loop

        response.write "<meta http-equiv='refresh' content='0;url="
        response.write ISSUE_NUM
        response.write "/0.asp'>"
%>

<title>开心情报站 Happy Cells</title>
</head>
<body>
</body>
</html>