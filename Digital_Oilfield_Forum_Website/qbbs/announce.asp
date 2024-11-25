<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/cfmexp.inc"-->
<%
   dim BoardID
   'BoardID=Request("boardID")
   boardid=1
   dim rsBoard
   dim boardname
   dim boardsql
   dim syssayface
   on error resume next
   set rsBoard=server.createobject("adodb.recordset")
   boardsql="select * from board where boardID="&BoardID
   rsboard.open boardsql,conn,1,1
 if (not rsboard.eof) then
   boardname=rsboard("boardname")
   syssayface=rsboard("sayface")
   session("boardname")=rsboard("boardname")
   session("boardID")=boardid
%>
<html>
<head>
<meta NAME="GENERATOR" Content="lousi soft 1.0">
<meta HTTP-EQUIV="Content-Type" content="text/html; charset=gb_2312-80">
<title>数字油田论坛 [Digital Oilfield Forum] ---发表新帖子</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body bgcolor='<%=rsboard("bgcolor")%>' background='<%=rsboard("background")%>' alink='<%=rsboard("link")%>' link='<%=rsboard("link")%>' vlink='<%=rsboard("vlink")%>'>
<center>
<%
if isexp=1 then 
  response.write "<img src='images/light.gif' border='0'><font size=2 color=#666666>您现在处于[专家/嘉宾深入讨论区]，请注意保密。您当前的身份是："&expertnm&"("&realnm&")。有标记<img src='images/expert.gif' border=0>的部分为深入讨论内容。&nbsp;</font>"
  response.write "&nbsp;&nbsp;<a href=exitexpert.asp?to=announce.asp><img src='images/exit.gif' border=0><font size=2 color=#666666>退出</font></a><a href=exppwchg.asp target='_blank'>&nbsp;&nbsp;<img src='images/key.gif' border=0><font size=2 color=#666666>修改密码</font></a>"
end if
%>
</center>
<font size='<%=rsboard("fontsize")%>' color='<%=rsboard("fontcolor")%>'>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<center><form action="SaveAnnounce.asp?boardID=<%=request("boardid")%>" method="POST"
name="frmAnnounce">
<table border="0" cellpadding="1" cellspacing="1">
<tr><td width="10"></td><td align="left" width=340>
<font size='5' color=black><b><center>发表新帖</center></b><br><font color=#666666 size=2>谢绝与本论坛内容无关的帖子。<br>经审查后才能公开发布，请耐心等待。<br>已进入 [专家/嘉宾深入讨论区] 后免除审查。</font></font>&nbsp;&nbsp;<br>
</td><td width="60"></td></tr></table>
<table cellspacing='0' cellpadding='0' border="0">
<tr>
<td valign="top" align="center">
<table cellspacing='0' cellpadding='0' border="0" width="800">

<%
dim verifycode, tu(15)
if isexp<1 then
  response.write "<tr><td><font size='' color='#663399'>用户:</font></td><td>"
  response.write "<input type=text name='username' size=10 maxlength='20' value='"
  response.write request.cookies("userinfo")("UserName")
  response.write "' tabindex='1'>"
  response.write "<font size='2' color='#663399'>第一次发言自动注册为<font size='2' color='#cc6600'>一般用户</font>，如希望注册为<font size='2' color='#cc6600'>[专家/嘉宾]</font>，请到<a href='expreg.asp' target='_blank'><u>深入讨论区</u></a>申请。</font></td></tr>"
  response.write "<tr><td><font size='' color='#663399'>密码:</font></td><td>"
  response.write "<input type=password name='passwd' size=10 maxlength='20' value='"
  response.write request.cookies("userinfo")("Password")
  response.write "' tabindex='2'>"
else
  response.write "<br><font size='' color='#663399'>当前身份: </font><font color=#cc6600>"&realnm&"</font><font size=2>("&expertnm&":专家/嘉宾)</font><font color=#336699 size=2>  如不希望以专家/嘉宾或注册坛友身份发言，请退出 [专家/嘉宾深入讨论区]，但所发帖子需要审查。</font><br>"
  response.write "<input type=hidden name='username' value='"
  response.write expertnm&"'>"
  response.write "<input type=hidden name='passwd' value='"
  response.write expertpw&"'>"
end if
'验证码
  response.write " <font size='' color='#663399'>验证码:</font>"
  response.write "<input type=hidden name='verifycode1' size=6 maxlength='6' value='"
  randomize 
  tu(1)="byei89hh"  '0
  tu(2)="jk6s8gy2"
  tu(3)="98hu6723"
  tu(4)="rt265ww4"
  tu(5)="4i67tntc"
  tu(6)="op45ghes"
  tu(7)="jvcdt55u"
  tu(8)="h8763hbd"
  tu(9)="hdh97dhd"
  tu(10)="56t8bks"   '9
  verifycode=Int(RND(1)*8000)+1000
  verifycode= (verifycode+437)*17
  response.write verifycode
  response.write "'>"
  response.write "<input type=text name='verifycode2' size=6 maxlength='6'>"
  response.write "<img src='images/" & cstr(tu(1+cint(mid(cstr(verifycode/17-437),1,1)))) & ".jpg' border='0'>"
  response.write "<img src='images/" & cstr(tu(1+cint(mid(cstr(verifycode/17-437),2,1)))) & ".jpg' border='0'>"
  response.write "<img src='images/" & cstr(tu(1+cint(mid(cstr(verifycode/17-437),3,1)))) & ".jpg' border='0'>"
  response.write "<img src='images/" & cstr(tu(1+cint(mid(cstr(verifycode/17-437),4,1)))) & ".jpg' border='0'>"

%>

</td>
</tr><tr><td><font size='' color='#663399'>标题:</font></td><td><input type=text name='subject' size=70 maxlength="70" tabindex="3"><input type=submit value='发表' tabindex="5"><input type=submit name=button value="退出"></td>
</tr><tr><td valign="top"><font size='' color='#663399'>内容:</font></td><td><textarea COLS=100 ROWS=25 

name='body' tabindex="4"></textarea></td>
</tr><tr><td colspan="2"><font size='' color='#663399'>音乐MIDI:<input type=text name='midi' size=30 value="http://"></font>
<font size='' color='#663399'> 图片URL:<input type=text name='img' size=30 value="http://"></font>
<input type=submit value='发表'><input type=submit name=button value="退出" ></td>
</tr><tr><td colspan="2"><font size='' color='#663399'>链接名称:<input type=text name='url_title' size=30 value=""></font>
<font size='' color='#663399'>链接URL:<input type=text name='url' size=30 value="http://"></font>
<input type=reset value="重填"><br>
<font size='' color='#663399'>邮件地址:<input type=text name='email' size=30 value="<%=request.cookies("userinfo")("Useremail")%>"></font>
<br>
<p>
</td></tr>
</table>
</td>

</tr></table>
</form>
<%
   else
     response.write "指定的论坛不存在！"
   end if
%>
</font>
</center>
</body>
</html>
