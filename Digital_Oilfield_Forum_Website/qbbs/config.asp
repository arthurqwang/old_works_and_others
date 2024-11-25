<%@ LANGUAGE="VBSCRIPT" %>
<%option explicit%>
<!--#include file="newconn.asp"-->
<%
   dim sql,rs
   dim sel
   dim boardid
   boardid=1
   if not (isNUll(request("boardid")) or isEmpty(request("boardid")) or (request("BoardID")="") ) then
      boardid=request("boardid")
	  else 
	boardid=1 '默认进入第1个版面
   end if

   set rs=server.createobject("adodb.recordset")
   sql="select * from board"
   rs.open sql,conn,1,1
%>
<HTML>
<HEAD>
   <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
   <META HTTP-EQUIV="Content-Language" CONTENT="zh-CN">
   <link rel="stylesheet" type="text/css" href="lun.css">
   <TITLE>论坛管理</TITLE>
</HEAD>
<BODY marginheight=0 marginwidth=0 topmargin=10 leftmargin=10 bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3>论坛管理</h3></center>
<center>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td>
<center><font size="-1">[ <a href="about.asp" target="_blank">使用帮助</a>|<a href="point.asp"  target="_blank">积分排行榜</a>|<a href="Article.asp?boardID=<%=boardID%>" target="_blank">帖子排行榜</a>|<a href="#1">主持人专用管理</a> ]</font>
<br>
<hr>
<h3>论坛用户资料修改</h3>
<form method=POST action="boarduserdetail.asp">
<input type=hidden name="action" value="change_usrdata">
仅限于已注册的论坛 [普通用户] 使用<br>如果您已经是注册的 [专家/嘉宾] 请不要在此修改信息
<table border=0 cellpadding="0" cellpadding="0">

<tr>
<td align=right>用户: </td><td><input type=text name="username" size="10"></td>
</tr><tr>
<td align=right>密码: </td><td><input type=password name="password" size="10"></td>
</tr><tr>
<td align=center colspan="2" ><input type="Radio" name="mode" value="everydetails" checked>个人资料
<input type="Radio" name="mode" value="everypassword" >修改密码
<input type="Radio" name="mode" value="everypic" >图片资料
</td></tr>
</table>
<input type=submit value="进入"><input type=reset>
</form>
<hr>
<h3><a name="1"><h3>主持人专用管理</h3></p>普通用户免入</a></h3>
<form method=POST action="eChklogin.asp">
<table border=0 cellpadding="0" cellpadding="0">
<tr>
<td align=right>主持人用户名: </td><td><input type=text name="username" size="10"></td>
</tr><tr>
<td align=right>主持人密码: </td><td><input type=password name="password" size="10"></td>
</tr><tr>
<td align=left colspan="2" >
<input type="Radio" name="action" value="content" checked>管理论坛帖子
<input type="Radio" name="action" value="download">管理资料下载中心<br>
<input type="Radio" name="action" value="expert">管理专家嘉宾
<input type="Radio" name="action" value="boardset">论坛设置修改<br>
<input type="Radio" name="action" value="userdata">管理论坛用户
<input type="Radio" name="action" value="chgmanage">更改管理帐号<br>
<input type="Radio" name="action" value="sendmsg">发送内部消息
</td></tr>
</table>
<input type=submit value="进入"><input type=reset>
</form><hr>
<!--#include file="FooterLogo.asp"-->
</center>
</font></body></html>
