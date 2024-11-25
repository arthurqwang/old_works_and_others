<%@ LANGUAGE="VBSCRIPT" %>
<%
if request.cookies("adminok")="" then
  response.redirect "firstpg.asp"
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>管理资料下载中心</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;资料下载中心管理</h3></p>

<%
    dim Cnn
    dim sql,action,seq,msg
   
    Set Cnn = Server.CreateObject("ADODB.Connection")
    Cnn.Open "Driver={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("database/board.mdb")
    
    action=request("action")
    seq=request("seq")

    if action="delete" then
      sql="delete from dllist where seq="&seq
      Cnn.execute sql
    end if

    if action="modify" then
      response.redirect "editdl.asp?seq="&seq
    end if

    if action="release" then
      sql="update dllist set display=1 where seq="&seq
      Cnn.execute sql
    end if
    response.redirect "dlmng.asp"
%>

</body>
</html>