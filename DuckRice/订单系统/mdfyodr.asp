<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<head>
<title>ŵ����Ѽ����ũ�������-��Ʒ���ƵǼǰ�</title>
</head>

<%
verify_user() '����û�Ȩ�ޣ�is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

oid=trim(request("oid"))
'response.write oid
conn_init()    '�������ݿ�����

    set rs=server.createobject("adodb.recordset")
	sql="select * from orderlist where oid=" & oid
	rs.open sql,conn,1,1
'    'oid=rs("oid")

	dgxs=trim(rs("dgxs"))
	pzdj=trim(rs("pzdj"))
       dim pzdj0,pzdj1,pzdj2
       if pzdj="�ؼ�" then pzdj0="checked"
       if pzdj="һ��" then pzdj1="checked"
       if pzdj="����" then pzdj2="checked"

	ddlx=trim(rs("ddlx"))
       dim ddlx0,ddlx1
       if ddlx="�ֻ�����" then ddlx0="checked"
       if ddlx="���Ԥ��" then ddlx1="checked"

	shfs=trim(rs("shfs"))
       dim shfs0,shfs1
       if shfs="�ؿ�ֱ��" then shfs0="checked"
       if shfs="ͬ����ȡ" then shfs1="checked"

	xzdh=trim(rs("xzdh"))
	shr=trim(rs("shr"))
	shdh=trim(rs("shdh"))
	shdz=trim(rs("shdz"))
	yzbm=trim(rs("yzbm"))
	qtsm=trim(rs("qtsm"))

	dqzt=trim(rs("dqzt"))
       dim dqzt1,dqzt2,dqzt3,dqzt4,dqzt5,dqzt6,dqzt7,dqzt8,dqzt9,dqzt10,dqzt11,dqzt12
       if dqzt="1 ���µǼ�" then dqzt1="selected"
       if dqzt="2 ��������" then dqzt2="selected"
       if dqzt="3 ��ǩ��ͬ" then dqzt3="selected"
       if dqzt="4 �ص�����" then dqzt4="selected"
       if dqzt="5 ��������" then dqzt5="selected"
       if dqzt="6 �ѽ�����" then dqzt6="selected"
       if dqzt="7 �ѽ�ȫ��" then dqzt7="selected"
       if dqzt="8 �Ѿ�����" then dqzt8="selected"
       if dqzt="9 �Ѿ��ջ�" then dqzt9="selected"
       if dqzt="10 ��ִͣ��" then dqzt10="selected"
       if dqzt="11 ��������" then dqzt11="selected"
       if dqzt="12 �������" then dqzt12="selected"

	dgdj=trim(rs("dgdj"))
	zje=trim(rs("zje"))
	yjje=trim(rs("yjje"))
	bz=trim(rs("bz"))
check_modify_del_order()
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

<h3>�޸Ķ�����Ϣ</h3>
<%
if can_modify_del_order<>1 then
response.write "</center>������Ϣ���������޸�"
end_this_file()
end if


%>

<table border="0"><tr><td align="left"><font size="2">
����Ѽ�׼�����ũ��Ʒ�����ڴ��޸�<br>
������Ѽ������Ĳ�Ʒ��������˵����ע��<br>
����<font color="#ff0000">��Ϣ���׼ȷ�����Ǳ�֤����й</font><br>
<form name='or1' method='post' action='http://www.kxqbz.com/guaguayami/mdfyodr2.asp?oid=<% response.write oid %>'>

������¼����:<% response.write dlwm %>
������������:<% response.write ndxm %><br><br>

������������:<input type='text' name='dgxs'  size='25' id='k7'  value='<% response.write dgxs %>'><br>

����Ʒ�ʵȼ�:<input type='radio' name='pzdj' value='0' <% response.write pzdj0 %>>�ؼ�
           ��<input type='radio' name='pzdj' value='1' <% response.write pzdj1 %>>һ��
           ��<input type='radio' name='pzdj' value='2' <% response.write pzdj2 %>>����<br>

������������:<input type='radio' name='ddlx' value='0' <% response.write ddlx0 %>>�ֻ�����
         ����<input type='radio' name='ddlx' value='1' <% response.write ddlx1 %>>���Ԥ��<br>

�����ջ���ʽ:<input type='radio' name='shfs' value='0' <% response.write shfs0 %>>�ؿ�ֱ��
         ����<input type='radio' name='shfs' value='1' <% response.write shfs1 %>>ͬ����ȡ<br>

����ѡ��غ�:<input type='text'  name='xzdh'  size='18' id='k10' value='<% response.write xzdh %>'><a  href="http://www.kxqbz.com/guaguayami/images/ggg5.jpg" target="_blank">������Ƭ</a><br>
�����ջ��ˡ�:<input type='text'  name='shr'  size='25' id='k10' value='<% response.write shr %>'><br>
�����ջ��绰:<input type='text' name='shdh'  size='25' id='k11' value='<% response.write shdh %>'><br>
�����ջ���ַ:<input type='text'  name='shdz'  size='25' id='k5' value='<% response.write shdz %>'><br>
������������:<input type='text' name='yzbm'  size='25' value='<% response.write yzbm %>'><br>

��������˵��:<input type='text'  name='qtsm'  size='25' id='k' value='<% response.write qtsm %>'><br>
    <% if is_adm=1 then %>
	������ǰ״̬:<select   name='dqzt'  id='k9001'>
			        <option  value="1 ���µǼ�" <% response.write dqzt1  %>>1 ���µǼ�</option>   
			        <option  value="2 ��������" <% response.write dqzt2  %>>2 ��������</option>   
			        <option  value="3 ��ǩ��ͬ" <% response.write dqzt3  %>>3 ��ǩ��ͬ</option>   
			        <option  value="4 �ص�����" <% response.write dqzt4  %>>4 �ص�����</option>   
			        <option  value="5 ��������" <% response.write dqzt5  %>>5 ��������</option>   
			        <option  value="6 �ѽ�����" <% response.write dqzt6  %>>6 �ѽ�����</option>   
			        <option  value="7 �ѽ�ȫ��" <% response.write dqzt7  %>>7 �ѽ�ȫ��</option>   
			        <option  value="8 �Ѿ�����" <% response.write dqzt8  %>>8 �Ѿ�����</option>   
			        <option  value="9 �Ѿ��ջ�" <% response.write dqzt9  %>>9 �Ѿ��ջ�</option>   
			        <option  value="10 ��ִͣ��" <% response.write dqzt10  %>>10 ��ִͣ��</option>   
			        <option  value="11 ��������" <% response.write dqzt11  %>>11 ��������</option>   
			        <option  value="12 �������" <% response.write dqzt12  %>>12 �������</option>   
                 </select><br>


	������������:<input type='text'  name='dgdj'  size='25' id='k' value='<% response.write dgdj %>'><br>
	�����ܽ�:<input type='text'  name='zje'  size='25' id='k' value='<% response.write zje %>'><br>
	�����ѽ����:<input type='text'  name='yjje'  size='25' id='k' value='<% response.write yjje %>'><br>
	����������ע:<input type='text'  name='bz'  size='25' id='k' value='<% response.write bz %>'><br>
     <% end if %>

�������<font color="#118811">�Ѻ�����</font>:<a href="http://guaguayami.blog.sohu.com" target="_blank"><font color="#ff0000">ŵ����Ѽ����ũ�������</font></a><br>

������<input type='submit' name='djcxhxg' value='�޸�' >��<input type='reset' name='ct' value=' ���� ' >

</form>
����* ����Ϣ��������ʹ�ã�������Ǣ̸<br>
</font></td></tr></table>
</center>
<%
end_this_file()
%>
</body>
</html>














