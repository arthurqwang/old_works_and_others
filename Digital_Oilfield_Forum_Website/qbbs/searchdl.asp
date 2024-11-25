<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->

<html><head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>DO资料下载中心</title>
<link rel="stylesheet" type="text/css" href="style.css"></head>
<body bgcolor='#FFFFFF' alink='#330099' link='#330099' vlink='#666699'>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p>
<table border="0" width="800"><tr><td valign="top" align="right" width="200"><img border="0" src="images/download.jpg"></td><td valign="bottom" align="left"><font face="黑体" size="6">数字油田论坛 - 资料下载中心</font></td></tr></table>
<br>

<table border="0">
  <tr>
    <td><form method="POST" action="searchdl.asp">
          <div class="smallFont" align="center"><table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd"><tr><td><font color="#336699">搜索资料下载中心</font>&nbsp;&nbsp;关键词：<input class="smallInput" type="text" name="keywords" size="17" value="<% = trim(request("keywords")) %>">
		  <input class="buttonface" type="submit" value="检索" name="cmdTopic">&nbsp;&nbsp;&nbsp;<a href="showdownload.asp"><font size=2 color=#996633>显示全部资料</font></a></td></tr></table></div>
        </form>
    </td>		
  </tr>
</table>
<br>


<table border="0" width="800">
<tr<td colspan=""2><font size=3 color=#996633>搜索结果：</font></td></tr>
<%
    dim rs,sql,i,keywords
    keywords=trim(request("keywords"))
    if keywords<>"" then
    i=1
    set rs=server.createobject("adodb.recordset")
    sql="select * from dllist order by priority desc,seq desc"
       rs.open sql,conn,1,1
 	 do while not rs.EOF 
      if (instr(rs("topic"),keywords)>0 and (not isnull(instr(rs("topic"),keywords)))) or  (instr(rs("shorttopic"),keywords)>0 and (not isnull(instr(rs("shorttopic"),keywords)))) or (instr(rs("author"),keywords)>0 and (not isnull(instr(rs("author"),keywords)))) or (instr(rs("format"),keywords)>0 and (not isnull(instr(rs("format"),keywords)))) or (instr(rs("size"),keywords)>0 and (not isnull(instr(rs("size"),keywords)))) or (instr(rs("url"),keywords)>0 and (not isnull(instr(rs("url"),keywords)))) or (instr(rs("explain"),keywords)>0 and (not isnull(instr(rs("explain"),keywords))))  then
    '  if keywords="555" then
       response.write "<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td><font size=2 color=#666666>"
       if rs("folderornot")=1 then response.write "<img border='0' src='images/folder.gif' title='文件夹'>"
       response.write rs("topic")
       if rs("important")=1 then response.write "<img border='0' src='images/important.gif' title='重要文档'>"
       if trim(rs("needpass"))<>"" then response.write "<img border='0' src='images/lock.gif' title='需要密码'>"
       if rs("author")<>"" then response.write "，"&rs("author")
       if rs("format")<>"" then response.write "，"&rs("format")
       if rs("size")<>"" then response.write "，"&rs("size")
       response.write "<a href='"
       response.write rs("url")&"' target='_blank'><font color='#336699'>"
       if rs("folderornot")>0 then
         response.write "[进入目录]</a>"
       else
         response.write "[下载/浏览]</a>"
       end if
       if rs("explain")<>"" then response.write "<br>&nbsp;&nbsp;&nbsp;说明：<font color='#666666'>"&rs("explain") 
       response.write "</font></font></td></tr>"
       i=i+1
      end if
      rs.MoveNext
     loop
     rs.Close
     end if
     if i>1 then
       response.write "<tr><td colspan='2'><font size='2' color='#996633'>共找到"&(i-1)&"个匹配记录。</font></td></tr>"
     else
       response.write "<tr><td colspan='2'><font size='2' color='#996633'>未找到匹配记录。</font></td></tr>"
     end if
%>
</table>
</center>
</body>
</html>
