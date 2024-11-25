<%@ LANGUAGE="VBSCRIPT" %>
<%option explicit%>
<!--#include file="newconn.asp"-->
<html>

<head>
<meta NAME="GENERATOR" Content="Microsoft FrontPage 3.0">
<meta HTTP-EQUIV="Content-Type" content="text/html; charset=gb_2312-80">
<meta HTTP-EQUIV="Expires" CONTENT="0">
<link rel="stylesheet" type="text/css" href="forum.css">
<title>帖子查询</title>
</head>

<body topmargin="0" leftmargin="0">
<!-- Insert HTML here -->
<div align="left">
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
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
  <tr>
    <td><div align="center"><center><table border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><p align="center"><b>帖子查询</b></td>
      <tr>
        <td><form name="queryTopic" method="POST" action="queryResult.asp?type=1" target="BoardList">
          <div class="smallFont" align="center">主　题：<input class="smallInput" type="text" name="txtTopic" size="17">分论坛：<select class="smallSel" name="selBoard" size="1">
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
          </select><input class="buttonface" type="submit" value="查 询" name="cmdTopic"></div>
        </form>
        </td>		
      </tr>

      <tr>
        <td></td>
      </tr>
      <tr>
	    <td><form name="queryUser" method="POST" action="queryResult.asp?type=2" target="BoardList">
          <div class="smallFont" align="center">发言人：<input class="smallInput" type="text" name="txtUser" size="17"> 分论坛：<select class="smallSel" name="selBoard" size="1">
		  	  <%
			  rs.movefirst
			  do while not rs.eof
                             if boardid=cstr(rs("boardid")) then
                                sel="selected"
                             else
                                sel=""
                             end if		    
		             response.write "<option " & sel & " value='"+CStr(rs("BoardID"))+"'>"+rs("Boardname")+"</option>"+chr(13)+chr(10)
		             rs.movenext
    		          loop
			  rs.close
			  %>        
          </select><input class="buttonface" type="submit" value="查 询" name="cmdTopic"></div>
        </form>
        </td>
	  </tr>
    </table>
    </center></div></td>
  </tr>
</table>
</div>
</body>
</html>
