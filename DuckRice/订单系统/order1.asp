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

conn_init()    '�������ݿ�����

response.cookies("ggymdlwm")=""   '�������cookieԭ���û���Ϣ
response.cookies("ggymadm")="" 
response.cookies("ggymndxm")=""

'****************** ��ȡ "�Ǽ� ��ѯ �޸�" ������

is_adm=0
dlwm=""
ndxm=""

dlwm=trim(request("dlwm"))
dlmm=trim(request("dlmm"))
ndxm=trim(request("ndxm"))
cysj=trim(request("cysj"))
gddh=trim(request("gddh"))
czhm=trim(request("czhm"))
jstx=trim(request("jstx"))
dzyj=trim(request("dzyj"))
qtfs=trim(request("qtfs"))

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
if dlwm="����" then dlwm=""
if dlmm="����" then dlmm=""
if ndxm="�״εǼǱ���" then ndxm=""
if cysj="�״εǼǱ���" then cysj=""
if jstx="����QQ��MSN��" then jstx=""
if dgxs="ÿ��20�1����" then dgxs=""
if xzdh="�뿴������Ƭѡ��غ�" then xzdh=""
if shr="��������Ŷ��ȱʡ�����Լ�" then shr=""
if shdh="ȱʡ�����ĳ����ֻ�" then shdh=""
if shdz="����ϸ׼ȷ��д" then shdz=""
if qtsm="���綩��Ѽ�ӡ��󶹡������" then qtsm=""



'********************** �������ݿ�

can_add_user =0 
can_add_order =0
user_exist =0
pw_ok =0
log_in =0
is_adm =0

find_user()   '������ݿ��е��û�������֤��ͨ���������������ͨ������ֵ��Ӧ����
if user_exist=0 then check_new_user()  '������û��������Ƿ���д,���ͨ����can_add_user =1����ʾӦ�����ݿ���û�
if can_add_user=1 then adduser()    '�����ݿ�����û�

check_new_order()   '����ύ���¶���,ͨ���� can_add_order=1
if can_add_order=1 then addorder()    '�����ݿ���¶���

response.write "<br>���ڴ������Ե�...<br>"

'conn_reconnect()   'Ϊ�˱�֤���¼���ļ�¼�ܹ���ѯ������������������һ��

end_this_file()   '���������򣬼����ļ���β
'response.redirect "showall.asp"  '�ڱ��ļ�ͷ������

'*****************************����ȫ������

%>


