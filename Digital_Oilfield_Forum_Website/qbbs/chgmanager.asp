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

function check4()
{
	if ((document.addbt4.name.value.length<1) ||( document.addbt4.cname.value.length<1) )
		alert("���ֲ���Ϊ��");
	else{
		document.addbt4.way.value="�޸�";
        document.addbt4.submit();
		}
}
//-->
</SCRIPT>
<body class=clblue>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3>�����������޸�</h3></p></center>
<%		dim strSQL,iBt,i,byOrder,rsB,iB,j,rs
		set rsB=server.CreateObject("ADODB.RecordSet")
		set rs=server.CreateObject("ADODB.RecordSet")
		dim showmaster
%>
<center><p>


 <%
rs.Open "select * from Board order by boardid desc",conn,1
 if rs.EOF then
	response.write "��̳���治���ڣ���"
	else
%>


	<%	if request("method")="modify"  then 
	dim sql
	sql="select * from Board where boardid=" & request("boardid")
			rsB.open sql,conn,1,3
			if rsB.RecordCount>=1 then
			showmaster=trim(rsb("boardmaster"))
			
	%>
	<form name=addbt4 method="post" action="chgmanager.asp">
	<INPUT TYPE="hidden" name=method value="modified">
	<INPUT TYPE="hidden" name=boardid value="<%=request("boardid")%>">
	��̳���ƣ�<INPUT TYPE="text" size=10 NAME="name" value="<%=rsb("boardname")%>" class=bline1><br>
	���������룺<INPUT TYPE="text" size=10 NAME="cname" value="<%=rsb("masterpwd")%>" class=bline1><br>
	������mail��<INPUT TYPE="text" size=10 NAME="email" value="<%=rsb("masteremail")%>" class=bline1><br>
	������������<INPUT TYPE="text" size=10 NAME="userid" value="<%=showmaster%>" class=bline1>
		<INPUT TYPE="hidden" name=way value="�޸�">
	<br>&nbsp;&nbsp;<INPUT name="way1" class=buttonface TYPE=submit value="����޸�" onClick="check4()">
	</form>
	<%		rsB.close
			end if
		end if%>

	     <%	if request("method")="modified"  then 
		   showmaster=trim(request("userid"))
			strSQL="update Board set boardname='"+trim(request("name"))
			strSQL=strSQL+"',masterpwd='"+trim(request("cname"))+"',masteremail='"+trim(request("email"))+"',boardmaster='"+showmaster+"' "
			strSQL=strSQL+" where boardid="+request("boardid")
			rsB.open strSQL,conn,1
			response.write "�����������޸ĳɹ��ˣ�"
		  end if 
end if 	%>
</center>
</body>
</html>
