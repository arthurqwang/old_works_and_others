<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>论坛管理</title>
</head>
<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<%
   dim sql,rs
   dim username
   dim password
   dim action
   dim mode
   dim announceID
   on error resume next
   action=request("action")
   boardID=request("boardID")
   announceID=request("announceID")
   mode=request("mode")
   username=trim(request("username"))
   password=trim(request("password"))
if action="manage" then  
'-----------------------------------------------------------

set rs=server.createobject("adodb.recordset")
sql="select * from board where boardid="+cstr(boardid)+""
sql=sql&" and boardmaster='"&username&"'"
rs.open sql,conn,1,1
  if not(rs.bof and rs.eof) then
     if password=rs("masterpwd") and username=rs("boardmaster") then 
	   '主持人管理，而且主持人已经登录进去
	    response.cookies("CanEdit")=true
		 
           if mode=1 then 'showEdit action,AnnounceID '主持人修改此贴
		   '*******************************************************
dim tmp
tmp=""
if action="manage" then tmp="主持人"
if action="author" then tmp="作者"
dim rss
set rss=server.createobject("adodb.recordset")
 sql="select Topic,Body from bbs1 where announceID="+cstr(AnnounceID)+""
 rss.open sql,conn,1,1
 if not(rss.eof) then
%>
<center>
<table border="0" align="center" bgcolor="#FFFFFF" cellspacing="0" cellpadding="5">
<tr bgcolor="#808040"><td><span class="heading"><%=tmp%>编辑本贴</span></td></tr>
<tr><form action="editEnd.asp" method="POST"><td>
标题:<br><input type="text" name="title" size=100 value="<%=rss("Topic")%>"></td></tr>
<tr><td><input type="hidden" name="AnnounceID" value="<%=AnnounceID%>">
<input type="hidden" name="action" value="<%=action%>">
<input type="hidden" name="boardID" value="<%=boardID%>">
内容:<br><textarea COLS=100 ROWS=30 name="body"><%=rss("body")%></textarea></td></tr>
<tr><td><input type="submit" value="确定"></form></td></tr></table>
</center>

<%else
    response.write "此贴无法编辑！"
  end if
                     rss.close
		   '*******************************************************
		   end if
		   err.clear
           if mode=2 then
		   sql="DELETE FROM bbs1 WHERE AnnounceID="&announceID&""
           conn.execute sql
		   response.write "已经删除此贴"
		   end if

           if mode=0 then 
		   sql="UPDATE bbs1 SET status=1 WHERE AnnounceID="&announceID&"" 
	       conn.execute sql
		   response.write "已经置为精华"
		   end if

		   if mode=3 then 
		   sql="select Topic,ip,username from bbs1 where AnnounceID="&announceID&""
           set rss=server.createobject("adodb.recordset")
		   set rss=conn.execute(sql)
		      if not rss.eof then
		       response.write rss("username") &"于IP地址:" & rss("ip") & "发表文章:" &rss("Topic")
               response.write "<br><a href='http://dheart.51.net/ip/index.php?searchip="+rss("ip")+"&search=%B2%E9%D1%AF'>"+"检查IP地址宿主"+"</a>(<a href='http://www.dheart.net/' target='_blank'>萍心网</a>提供)"
		      end if
            rss.close 
		   end if
     else
       response.write "Sorry,请输入正确的主持人名字和密码"
     end if
  end if
rs.close
'-----------------------------------------------------------------

end if

if action="author" then  
set rs=server.createobject("adodb.recordset")
sql="select username,userpassword from user where username='" & username &"'"
rs.open sql,conn,1,1
  if not(rs.bof and rs.eof) then
     if password=rs("userpassword") then 
	   '原作者修改，而且原作者已经登录进去
	    response.cookies("CanEdit")=true
		dim title,body,rsedit
         set rsedit=server.createobject("adodb.recordset")
sql="select announceID,Topic,Body from bbs1 where announceID=" +announceID + " and username='" &username &"'"
         rsedit.open sql,conn,1,1
          if not(rsedit.eof) then
		  body=rsedit("Body")
		  title=rsedit("Topic")
		  else
		  response.write "sorry,你无权修改本贴！"
		  response.end
          end if
		  rsedit.close
%>
<center>
<table border="0" align="center" bgcolor="#FFFFFF" cellspacing="0" cellpadding="5">
<tr bgcolor="#808040"><form action="editEnd.asp" method="POST">
<td><span class="heading">原作者编辑本贴</span></td></tr>
<tr><td>标题:<br><input type="text" name="title" size=100 value="<%=title%>"></td></tr>
<input type="hidden" name="AnnounceID" value="<%=AnnounceID%>">
<input type="hidden" name="action" value="<%=action%>">
<input type="hidden" name="boardID" value="<%=boardID%>">
<tr><td>内容:<br><textarea COLS=100 ROWS=30 name="body"><%=body%></textarea><br>
<input type="submit" value="确定"></form></td></tr></table>
</center>
<%
	  else 
       response.write "Sorry,请输入正确的名字和密码!只有原作者才可以编辑此贴"
     end if
  end if
   rs.close
end if
%>
</body>
</html>