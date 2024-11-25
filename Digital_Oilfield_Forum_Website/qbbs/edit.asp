<%@ LANGUAGE="VBSCRIPT" %>
<%option explicit%>
<!--#include file="newconn.asp"-->
<%
   dim Announceid
   dim boardid
   dim action
   dim Author
   boardid=1

   if not (isNUll(request("boardid")) or isEmpty(request("boardid")) or (request("BoardID")="") ) then
      boardid=request("boardid")
	  else 
	boardid=1 '默认进入第1个版面
   end if

 if ( request("BoardID")="" or request("Announceid")="" or request("action")="") then
      response.redirect "config.htm"
 else
	  Announceid= request("Announceid")
	  action=request("action")
	  Author=request("Author")
   end if
dim tmp
tmp=""
if action="manage" then tmp="主持人"
if action="author" then tmp="作者"
    
%>
<HTML>
<HEAD>
   <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
   <META HTTP-EQUIV="Content-Language" CONTENT="zh-CN">
   <META NAME="GENERATOR" CONTENT="Mozilla/4.05 [en] (Win95; I) [Netscape]">
  <TITLE><%=tmp%>编辑本贴</TITLE>
</HEAD>
<BODY  bgcolor="#FFffff">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<center>
<table border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="#ffffff">
  <tr>
    <td>
      <table border="0" align="center" bgcolor="#FFFFFF" cellspacing="0" cellpadding="5">
        <tr bgcolor="#ffffff"> 
          <td align="center"><span class="heading"><h3><%=tmp%>编辑本贴</h3></span></td>
        </tr>
        <tr> 
          <td>
<table><tr><td>
<form action="echkedit.asp" method="POST" name="chatform">
<input type="hidden" name="boardID" value="<%=boardID%>">
<input type="hidden" name="announceID" value="<%=AnnounceID%>">
<input type="hidden" name="action" value="<%=action%>">
<input type="hidden" name="Author" value="<%=Author%>">
</td></tr>
<tr><td><%=tmp%>名称</td><td><input type=Text name="username" size="10"></td></tr>
<tr><td><%=tmp%>密码</td><td><input type=password name="password" size="10"></td></tr>
<%  if action="manage" then%>
<tr><td>方式</td><td  colspan="2">
<input type="radio" name="mode" value="1"  checked>修改本贴
<input type="radio" name="mode" value="2">删除本贴 <br>
<input type="radio" name="mode" value="0" >置为精华
<input type="radio" name="mode" value="3">查询IP
</td></tr>
<% end if %>
<%  if action="Author" then %>
<input type="hidden" name="mode" value="1"> 
<% end if %>
<tr><td colspan="3">
<input type="submit" value="确定">&nbsp;&nbsp;<input  value="离开"  onclick="Javascript:window.close();" type="Button">
</form>
  </td></tr></table>
       </td>
        </tr>
      </table>
    </td>
  </tr>
</table></center>
</BODY>
</HTML>