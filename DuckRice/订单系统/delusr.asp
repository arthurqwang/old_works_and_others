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

<h3>ɾ���û���Ϣ</h3></p></center>



<%

dim err_t

verify_user() '����û�Ȩ�ޣ�is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"

dlwm=trim(request("dlwm"))

conn_init()    '�������ݿ����� 
   '����û������Ƿ���ڶ������ж����Ͳ���ɾ
        set rs=server.createobject("adodb.recordset")
        sql="select * from orderlist where dlwm='" & dlwm & "'"
        rs.open sql,conn,1,1

        if not rs.eof then 
           response.write "����ɾ�������û����´��ڶ���<br>"
           response.write "���ڴ������Ե�...<br>"
           end_this_file()
        end if

        rs.close

if is_adm=1 then
	set rs=server.createobject("adodb.recordset")
    sql="DELETE FROM userlist WHERE dlwm='" & dlwm & "'"
	Set rs = conn.Execute (sql,err_t)
    if err_t=1 then
      response.write "ɾ���ɹ�<br>"
    else
      response.write "ɾ��ʧ��<br>"
    end if
end if

response.write "���ڴ������Ե�...<br>"

end_this_file()
%>














