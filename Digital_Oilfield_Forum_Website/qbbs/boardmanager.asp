<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!-- #include file="newconn.asp" -->
<html >
<head>
<meta http-equiv="pragma" content="no-cache" >
<link rel="stylesheet" type="text/css" href="forum.css">
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--//
function check3()
{
	if ((document.addbt3.name.value.length<1) ||( document.addbt3.cname.value.length<1) )
		alert("名字不能为空");
	else
        document.addbt3.submit();
}
function check4()
{
	if ((document.addbt4.name.value.length<1) ||( document.addbt4.cname.value.length<1) )
		alert("名字不能为空");
	else{
		document.addbt4.way.value="修改";
        document.addbt4.submit();
		}
}
//-->
</SCRIPT>
<body class=clblue>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<%		dim strSQL,iBt,i,byOrder,rsB,iB,j
		set rsB=server.CreateObject("ADODB.RecordSet")
		dim showmaster
%>
<center><b>论坛版面管理区域</b><p>
<b><a href="boardmanager.asp?method=btmodify">增加版面</a></b>
<b><a href="loginch.asp?method=btmodify" target=BoardAnnounce>修改管理员密码</a></b><p>
<table border=0 width=100%>
<tr>
<td width=70% valign=top>
 <%
rsB.Open "select * from Board order by boardid desc",conn,1
 if rsB.EOF then
	response.write "论坛版面不存在：（"
	else
%>
<div align='center'><center>
<table border='1' width='80%' cellspacing='0' bordercolorlight='#000000' bordercolordark='#FFFFFF'  cellpadding='0'>
<tr>
<td width=10% align=center>ID</td>
<td width=25% align=center>版  面</td>
<td width=25% align=center>斑  竹</td>
<td width=40% align=center>操  作</td>
</tr>
<%do while NOT rsB.EOF%>
<tr>
<td width=10% align=center><%=rsB("boardid")%></td>
<td width=25% align=center><a href="boardmanager.asp?method=modify&boardid=<%=rsB("boardid")%>&name=<%=rsB("boardname")%>"><%=rsB("boardname")%></a></td>
<td width=25% align=center><a href="mailto:<%=rsB("masteremail")%>"><%=rsB("boardmaster")%></a></td>
<td width=40% align=center>请点击相应版面</td>
</tr>
<%
	rsB.MoveNext
	loop
	end if
rsB.Close
%>
</table>
</td>
<td width=30% valign=top>
<!------------------------------------------------------------------------------------------- -->
	<%	if request("method")="btmodify"  then %>
	<form name=addbt3 method="post" action="boardmanager.asp">
	增加板面：<br><br>
	<INPUT TYPE="hidden" name=method value="added">
	版面名称：<INPUT TYPE="text" size=10 NAME="name"  class=bline1><br>
	斑竹密码：<INPUT TYPE="text" size=10 NAME="cname"  class=bline1><br>
	斑竹mail：<INPUT TYPE="text" size=10 NAME="email"  class=bline1><br>
	斑竹姓名：<INPUT TYPE="text" size=10 NAME="userid" class=bline1>
	&nbsp;<INPUT name="way" class=buttonface TYPE=BUTTON value="增加" onClick="check3()">
	</form>
	<%end if%>
<!------------------------------------------------------------------------------------------- -->
	<%	if request("method")="modify"  then 
			rsB.open "select * from Board where boardid="+request("boardid"),conn,1
			if rsB.RecordCount>=1 then
			showmaster=trim(rsb("boardmaster"))
			
	%>
	<form name=addbt4 method="post" action="boardmanager.asp">
	修改信息：<br><br>
	<INPUT TYPE="hidden" name=method value="modified">
	<INPUT TYPE="hidden" name=id value="<%=request("boardid")%>">
	版面名称：<INPUT TYPE="text" size=10 NAME="name" value="<%=rsb("boardname")%>" class=bline1><br>
	斑竹密码：<INPUT TYPE="text" size=10 NAME="cname" value="<%=rsb("masterpwd")%>" class=bline1><br>
	斑竹mail：<INPUT TYPE="text" size=10 NAME="email" value="<%=rsb("masteremail")%>" class=bline1><br>
	斑竹姓名：<INPUT TYPE="text" size=10 NAME="userid" value="<%=showmaster%>" class=bline1>
		<INPUT TYPE="hidden" name=way value="删除">
	<br>&nbsp;&nbsp;<INPUT name="way1" class=buttonface TYPE=BUTTON value="修改" onClick="check4()">
				 &nbsp;&nbsp;<INPUT name="way1" class=buttonface TYPE="submit" value="删除">
	</form>
	<%		rsB.close
			end if
		end if%>
<!-- ------------------------------------------------------------------------------------- -->
	<%	if request("method")="added"  then 
			rsB.open "select * from board",conn,3,2
			rsB.addnew
			showmaster=trim(request("userid"))
			rsB("boardname")=request("name")
			rsB("masterpwd")=request("cname")
			rsB("boardmaster")=showmaster
			rsB("masteremail")=request("email")
			rsB.update
			rsB.close
		end if 	%>
<!---------------------------------------------------------------------------------------------->
	<%	if request("method")="modified"  then 
		  if request("way")="修改" then
			showmaster=trim(request("userid"))
			strSQL="update Board set boardname='"+trim(request("name"))
			strSQL=strSQL+"',masterpwd='"+trim(request("cname"))+"',masteremail='"+trim(request("email"))+"',boardmaster='"+showmaster+"' "
			strSQL=strSQL+" where boardid="+request("id")
			'response.write(strSQL)
			rsB.open strSQL,conn,1
		  else
			rsB.open "delete * from Board where boardid="+request("id"),conn,1
		  end if 
		end if 	%>
</td></tr>
</table>
</body>
</html>
<%
	conn.Close
	set rsB=nothing
	set conn=nothing
%>