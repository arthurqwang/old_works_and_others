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

is_adm=0
dlwm=""
ndxm=""
verify_user() '����û�Ȩ�ޣ�is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

conn_init()    '�������ݿ�����


dgxs=trim(request("dgxs"))
pzdj=trim(request("pzdj")) & ""  'ת�����ַ��ͣ���Ϊ������ radio�����
ddlx=trim(request("ddlx")) & ""
shfs=trim(request("shfs")) & ""
xzdh=trim(request("xzdh"))
shr=trim(request("shr"))
shdh=trim(request("shdh"))
shdz=trim(request("shdz"))
yzbm=trim(request("yzbm"))
qtsm=trim(request("qtsm"))

'����������ȱʡ��ֵ�����ÿ�
if dgxs="ÿ��20�1����" then dgxs=""
if xzdh="�뿴������Ƭѡ��غ�" then xzdh=""
if shr="��������Ŷ��ȱʡ�����Լ�" then shr=""
if shdh="ȱʡ�����ĳ����ֻ�" then shdh=""
if shdz="����ϸ׼ȷ��д" then shdz=""
if qtsm="���綩��Ѽ�ӡ��󶹡������" then qtsm=""



'********************** �������ݿ�
can_add_order =0

check_new_order()   '����ύ���¶���,ͨ���� can_add_order=1
if can_add_order=1 then addorder()    '�����ݿ���¶���

response.write "<br>���ڴ������Ե�...<br>"

'conn_reconnect()   'Ϊ�˱�֤���¼���ļ�¼�ܹ���ѯ������������������һ��

end_this_file()   '���������򣬼����ļ���β
'response.redirect "showall.asp"  '�ڱ��ļ�ͷ������

'*****************************����ȫ������

%>


