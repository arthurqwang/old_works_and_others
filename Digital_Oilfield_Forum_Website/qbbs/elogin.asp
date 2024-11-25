<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>管理者登陆</title>
<link rel="stylesheet" href="forum.CSS">
</head>

<body>
<%
   dim sql,rs
   dim sel
   dim boardid
   boardid=0
   if not (isNUll(request("boardid")) or isEmpty(request("boardid")) or (request("BoardID")="") ) then
      boardid=request("boardid")
   end if
   set rs=server.createobject("adodb.recordset")
   sql="select * from board"
   rs.open sql,conn,1,1
%>
<div align="center"><center>

<table border="0" cellspacing='1' width="90%">
  <tr>
    <td>　
<form method="POST" name="frmNewUser" action="echklogin.asp" target="BoardList">
      <table width="45%" border="1" cellspacing="0" cellpadding="0" align="center"
      bordercolordark="#FFFFFF" bordercolorlight="#000000">
        <tr>
          <td><table width="100%" border="0" cellspacing='1' cellpadding='1'>
		<tr><td width="33%" align="right">分论坛:</td>
		<td width="67%"><select class="smallSel" name="lstBoard" size="1">
	  <%
	     do while not rs.eof
                    if boardid=cstr(rs("boardid")) then
                       sel="selected"
                    else
                       sel=""
                    end if
		    response.write "<option " & sel & " value='"+CStr(rs("BoardID"))+"'>"+rs("Boardname")+"</option>"+chr(13)+chr(10)
		    rs.movenext
             loop
	  %>        
      </select></td>
            <tr>
                      <td width="33%" align="right" height="30">用户名：</td>
              <td width="67%"><input name="username" maxlength="20" class="smallInput" size="20"> </td>
            </tr>
            <tr>
                      <td width="33%" align="right" height="30">密 码：</td>
              <td width="67%"><input type="password" name="password" maxlength="16" class="smallInput"
              size="20"> </td>
            </tr>
            <tr>
              <td colspan="2" height="15"><input name="action" type=hidden maxlength="20" class="smallInput" size="20" value="chgmanage"></td>
            </tr>
          </table>
          </td>
        </tr>
        <tr align="center">
          <td height="40">
                  <input class="buttonface" type="submit" name="Submit" value="确定"> 
          &nbsp; 
                  <input class="buttonface" type="reset" name="Submit2" value="重写">
                   </td>
        </tr>
      </table>
    </form>
    <p align="center">　</td>
  </tr>
</table>
</center></div>
</body>
</html>