<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<!-- #include file="inc/cfmexp.inc"-->
<style type="text/css">
<!--
.form1 {margin-top: -10px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px}
.input1 {width: 110px;  border-style: solid; border-width: 1px; background-color: #A5BEE7}
.input2 {width: 60px;  height: 16px; font:12px;  border-style: solid; border-width: 1px; border-color: #A5BEE7}
.input3 {width: 15px;  height: 15px; font:12px;  border-style: plane; border-width: 0px; background-color:}
.input4 {width: 30px;  height: 16px; font:12px;  border-style: solid; border-width: 1px; border-color: #A5BEE7}
.button1 {width: 28px;  height: 17px; font:12px; border-style: plane; background-color: #A5BEE7}
-->
</style>


<html>

<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META NAME="GENERATOR" CONTENT="Microsoft FrontPage 4.0">
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>
����������̳ [Digital Oilfield Forum]</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>

<center>
<%
if isexp=1 then 
  response.write "<img src='images/light.gif' border='0'><font size=2 color=#666666>[ר��/�α�����������] ��ǰ��ݣ�"&expertnm&"("&realnm&")���б��<img src='images/expert.gif' border=0>�Ĳ���Ϊ�����������ݡ�&nbsp;</font>"
  response.write "&nbsp;&nbsp;<a href=exitexpert.asp?to=firstpg.asp><img src='images/exit.gif' border=0><font size=2 color=#666666>�˳�</font></a><a href=exppwchg.asp target='_blank'>&nbsp;&nbsp;<img src='images/key.gif' border=0><font size=2 color=#666666>�޸�ע����Ϣ</font></a><a href=othexp.asp target='_blank'>&nbsp;&nbsp;<img src='images/othexp.gif' border=0><font size=2 color=#666666>��ϵ����ר��/�α�</font></a>"
end if
%>
</center>
<br>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;����ר��/�α���ϵ��Ϣ</h3></p>




<table border="0" width="900">
<tr><td colspan="2"><center><font color="#336699" size="3">����������<br>δ��ר��/�α����������벻Ҫ��������Ϣ͸¶����������</font><br><br></center></td></tr>
<%
  if isexp=1 then
    dim rs,sql,i
    i=1
    set rs=server.createobject("adodb.recordset")
    sql="select * from experts order by active,realnm"
    rs.open sql,conn,1,1
 	do while not rs.EOF 
       response.write "<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td><font size=2 color=#666666>"
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>������</font><font color=#000000>"&rs("realnm")&"</font>"
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>�û���</font>"&rs("expertnm")

       
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>��λ��</font>"&rs("unitnm")
       response.write "&nbsp;&nbsp;<font size=2 color=#996633>Email��</font>"&"<a href='mailto:"&rs("email")&"'>"&rs("email")&"</a>"
       if rs("tel")<>"" then response.write "&nbsp;&nbsp;<font size=2 color=#996633>�绰��</font>"&rs("tel")
       if rs("folder")<>0 then 
         response.write "&nbsp;&nbsp;<a href='../experts/"&rs("folder")&"/brief.txt' target='_blank'>���</a>"
         response.write "&nbsp;&nbsp;<a href='../experts/"&rs("folder")&"/intro.htm' target='_blank'>����</a>"
       end if
       if rs("memo")<>"" then response.write "<br>&nbsp;&nbsp;<font size=2 color=#996633>����˵����</font>"&rs("memo")
       response.write "</td></tr>"
       rs.MoveNext
       i=i+1 
    loop
    rs.Close
  else
       response.write"<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td><font size=2 color=#ff6666>�Բ�����û��Ȩ�ޡ�����ר��/�α��ʺŵ�¼��</td></tr>"
  end if
%>
</table>
</center>
</body>
</html>
