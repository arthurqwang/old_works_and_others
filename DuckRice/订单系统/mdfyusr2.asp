<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<meta http-equiv=refresh content="2;URL=showall.asp">
</head>



<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://guaguayami.blog.sohu.com" target="_blank">
<img border="0" src="http://www.kxqbz.com/guaguayami/images/bar3-1.gif"></a>

<h3>�ͻ���Ϣ/������Ϣ����</h3></p></center>

<%

on error resume next
verify_user() '����û�Ȩ�ޣ�is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

dlwm=trim(request("dlwm"))  '�����������
'response.write oid
conn_init()    '�������ݿ�����


ndxm=trim(request("ndxm"))
cysj=trim(request("cysj"))
gddh=trim(request("gddh"))
czhm=trim(request("czhm"))
jstx=trim(request("jstx"))
dzyj=trim(request("dzyj"))
qtfs=trim(request("qtfs"))

'********************** �������ݿ�
can_add_user =0 

check_new_user()  '������û��������Ƿ���д,���ͨ����can_add_user =1����ʾӦ�����ݿ���û�
if can_add_user=1 then updateuser()    '�����ݿ�����û�

response.write "<br>���ڴ������Ե�...<br>"

'conn_reconnect()   'Ϊ�˱�֤���¼���ļ�¼�ܹ���ѯ������������������һ��

end_this_file()   '���������򣬼����ļ���β
'response.redirect "showall.asp"  '�ڱ��ļ�ͷ������

'*****************************����ȫ������

%>

