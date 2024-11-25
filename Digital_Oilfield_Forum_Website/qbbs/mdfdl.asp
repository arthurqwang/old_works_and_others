<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
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
   ' dim Cnn
   ' dim sql,seq,topic,shorttopic,folderornot,author,format,size,url,important,needpass,explain,priority
   '    
   ' Set Cnn = Server.CreateObject("ADODB.Connection")
   ' Cnn.Open "Driver={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("database/board.mdb")
    dim rs,sql
    set rs=server.createobject("adodb.recordset")
    sql="select * from dllist where seq="&request("seq")
    rs.open sql,conn,3,3
    if (not rs.eof) then
       rs("topic")=request("topic")
       rs("shorttopic")=request("shorttopic")
       rs("folderornot")=request("folderornot")
       rs("author")=request("author")
       rs("format")=request("format")
       rs("size")=request("size")
       rs("url")=request("url")
       rs("important")=request("important")
       rs("needpass")=request("needpass")
       rs("explain")=request("explain")
       rs("priority")=request("priority")
       rs("newornot")=request("newornot")
       rs("firstdisplay")=request("firstdisplay")
       rs("specialzone")=request("specialzone")
       rs("display")=request("display")

	   rs.update
       response.write "修改成功！"
     else 
	   response.write "操作失败。"
    end if
   rs.close

  '  seq=request("seq")
  '  topic=request("topic")
  '  shorttopic=request("shorttopic")
  '  folderornot=request("folderornot")
  '  author=request("author")
  '  format=request("format")
  '  size=request("size")
  '  url=request("url")
  '  important=request("important")
  '  needpass=request("needpass")
  '  explain=request("explain")
  '  priority=request("priority")
    

   ' sql="update dllist set topic='"&topic&"',shorttopic='"&shorttopic&"',folderornot="&folderornot&",author='"&author&"',format='"
   ' sql=sql&format&"',size='"&size&"',url='"&url&"',important="&important&",needpass="&needpass&",explain='"&explain&"',priority="&priority
   ' sql=sql&" where seq="&seq
'response.write sql

   '   Cnn.execute sql


    response.redirect "dlmng.asp"
%>
 

</body>
</html>