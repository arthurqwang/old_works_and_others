<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<head>
<title>ŵ����Ѽ����ũ�������-��Ʒ���ƵǼǰ�</title>
</head>
<%
verify_user() '����û�Ȩ�ޣ�is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

dim dlwm2   '����Ա����ͨ�ͻ����ֿ�,dlwm2-��ͨ
dlwm2=trim(request("dlwm"))
'response.write oid
conn_init()    '�������ݿ�����

    set rs=server.createobject("adodb.recordset")
	sql="select * from userlist where dlwm='" & dlwm2 & "'"
	rs.open sql,conn,1,1

	dlwm=trim(rs("dlwm"))
	dlmm=trim(rs("dlmm"))
	ndxm=trim(rs("ndxm"))
	cysj=trim(rs("cysj"))
	gddh=trim(rs("gddh"))
	czhm=trim(rs("czhm"))
	jstx=trim(rs("jstx"))
	dzyj=trim(rs("dzyj"))
	qtfs=trim(rs("qtfs"))
check_modify_del_user()
rs.close

%>


<script language="javascript">
function getCookie(name){var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));if(arr != null) return decodeURI(arr[2]); return null;}
function setCookie(cookiename,cookievalue,cookieexpdate)
{
    document.cookie = cookiename + "=" + encodeURI(cookievalue)
    + "; path=" + "/"
    + "; expires=" + cookieexpdate.toGMTString();
}

function WriteAll()
{
    var d = new Date();
    d.setTime(d.getTime()+1000*60*30);
    setCookie("ggymdlwm", "", d);
    setCookie("ggymadm", "", d);
    setCookie("ggymndxm", "", d);
    setCookie("ggymcysj", "", d);
}

function ReadAll()
{
    alert(getCookie("ggymdlwm"));
    alert(getCookie("ggymadm"));
    alert(getCookie("ggymndxm"));
    alert(getCookie("ggymcysj"));
}

</script>

<body>
<center><a href="http://guaguayami.blog.sohu.com" target="_blank">
<img border="0" src="http://www.kxqbz.com/guaguayami/images/bar3-1.gif"></a>
<font color=#0000ff><br>Ϊ��������Ϣ��ȫ�������Ǽǽ�������<a href=# onclick="WriteAll();window.top.close();"><font color=#fff0000>�˳��Ǽ�</font></a>�����رմ���<br></font>
<h3>�޸��û���Ϣ</h3>
<%
if can_modify_del_user<>1 then
response.write "</center>���û���Ϣ�����޸�"
end_this_file()
end if
%>


<table border="0"><tr><td align="left"><font size="2">
����<font color="#ff0000">��Ϣ���׼ȷ�����Ǳ�֤����й</font><br>
����<font color="#ff0000">��*�ı���</font><br>
<form name='or1' method='post' action='http://www.kxqbz.com/guaguayami/mdfyusr2.asp?dlwm=<% response.write dlwm %>'>

������¼����:<% response.write dlwm %><br>

������¼����:<input type='text'  name='dlmm'  size='25'  value='<% response.write dlmm %>' >*<br>

������������:<input type='text'  name='ndxm'  size='25'  value='<% response.write ndxm %>' >*<br>

���������ֻ�:<input type='text'  name='cysj'  size='25'  value='<% response.write cysj %>' >*<br>

�����̶��绰:<input type='text' name='gddh'  size='25'   value='<% response.write gddh %>'><br>

�����������:<input type='text' name='czhm'  size='25'   value='<% response.write czhm %>'><br>

������ʱͨѶ:<input type='text' name='jstx'  size='25'  value='<% response.write jstx %>'><br>

���������ʼ�:<input type='text' name='dzyj'  size='25'   value='<% response.write dzyj %>'><br>

����������ʽ:<input type='text' name='qtfs'  size='25'   value='<% response.write qtfs %>'><br>

�������<font color="#118811">�Ѻ�����</font>:<a href="http://guaguayami.blog.sohu.com" target="_blank"><font color="#ff0000">ŵ����Ѽ����ũ�������</font></a><br>

������<input type='submit' name='djcxhxg' value='�޸�' >��<input type='reset' name='ct' value=' ���� ' >

</form>
</font></td></tr></table>
</center>
<%
end_this_file()
%>
</body>
</html>














