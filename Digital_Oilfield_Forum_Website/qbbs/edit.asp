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
	boardid=1 'Ĭ�Ͻ����1������
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
if action="manage" then tmp="������"
if action="author" then tmp="����"
    
%>
<HTML>
<HEAD>
   <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
   <META HTTP-EQUIV="Content-Language" CONTENT="zh-CN">
   <META NAME="GENERATOR" CONTENT="Mozilla/4.05 [en] (Win95; I) [Netscape]">
  <TITLE><%=tmp%>�༭����</TITLE>
</HEAD>
<BODY  bgcolor="#FFffff">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<center>
<table border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="#ffffff">
  <tr>
    <td>
      <table border="0" align="center" bgcolor="#FFFFFF" cellspacing="0" cellpadding="5">
        <tr bgcolor="#ffffff"> 
          <td align="center"><span class="heading"><h3><%=tmp%>�༭����</h3></span></td>
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
<tr><td><%=tmp%>����</td><td><input type=Text name="username" size="10"></td></tr>
<tr><td><%=tmp%>����</td><td><input type=password name="password" size="10"></td></tr>
<%  if action="manage" then%>
<tr><td>��ʽ</td><td  colspan="2">
<input type="radio" name="mode" value="1"  checked>�޸ı���
<input type="radio" name="mode" value="2">ɾ������ <br>
<input type="radio" name="mode" value="0" >��Ϊ����
<input type="radio" name="mode" value="3">��ѯIP
</td></tr>
<% end if %>
<%  if action="Author" then %>
<input type="hidden" name="mode" value="1"> 
<% end if %>
<tr><td colspan="3">
<input type="submit" value="ȷ��">&nbsp;&nbsp;<input  value="�뿪"  onclick="Javascript:window.close();" type="Button">
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