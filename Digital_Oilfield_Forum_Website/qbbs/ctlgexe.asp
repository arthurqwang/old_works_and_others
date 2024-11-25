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
<title>BBS文章分类</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;BBS文章分类</h3></p>

<%
    dim rs,sql,catalog,announceid
    announceid=request("announceid")
    catalog=""
    set rs=server.createobject("adodb.recordset")
    sql="select * from bbs1 where announceid="&announceid
    rs.open sql,conn,3,3
    if (not rs.eof) then
       if request("ctlg1")="on" then catalog=catalog&"1"
       if request("ctlg2")="on" then catalog=catalog&"2"
       if request("ctlg3")="on" then catalog=catalog&"3"
       if request("ctlg4")="on" then catalog=catalog&"4"
       if request("ctlg5")="on" then catalog=catalog&"5"
       if request("ctlg6")="on" then catalog=catalog&"6"
       if request("ctlg7")="on" then catalog=catalog&"7"
       if request("ctlg8")="on" then catalog=catalog&"8"
       if request("ctlg9")="on" then catalog=catalog&"9"
       if request("ctlga")="on" then catalog=catalog&"a"
       if request("ctlgb")="on" then catalog=catalog&"b"
       if request("ctlgc")="on" then catalog=catalog&"c"
       if request("ctlgd")="on" then catalog=catalog&"d"
       if request("ctlge")="on" then catalog=catalog&"e"
       if request("ctlgf")="on" then catalog=catalog&"f"
       if request("ctlgg")="on" then catalog=catalog&"g"
       if request("ctlgz")="on" then catalog=catalog&"z"
       if request("ctlg0")="on" then catalog="0"
       if catalog="" then catalog="0"

       rs("catalog")=catalog
 	   rs.update
       response.write "修改成功！"
     else 
	   response.write "操作失败。"
     end if
     rs.close

'     response.redirect "catalog.asp?announceid="&announceid

      response.write chr(13)&"<script language='javascript'>"&chr(13)
      response.write "location.reload('emanage.asp');"&chr(13)
      response.write "</script>"
 
%>
 

</body>
</html>