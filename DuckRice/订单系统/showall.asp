<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://guaguayami.blog.sohu.com" target="_blank">
<img border="0" src="http://www.kxqbz.com/guaguayami/images/bar3-1.gif"></a>
<font color=#0000ff><br>Ϊ��������Ϣ��ȫ�������Ǽǽ�������<a href=# onclick="WriteAll();window.top.close();"><font color=#fff0000>�˳��Ǽ�</font></a>�����رմ���<br></font>
<h3>�ͻ���Ϣ/������Ϣ����</h3></p></center>

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



<%
on error resume next
conn_init()    '�������ݿ�����
verify_user() '����û�Ȩ�ޣ�is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"
if is_adm=1 and request("only_single_user")=1 then response.write "<center><a href='showall.asp'><font size=3 color=#aa0000>[������ҳ��]</font></a><br></center>"
showuser()   '��ʾ�û���Ϣ
showorder()  '��ʾ������Ϣ
if is_adm=1 and only_single_user=1 then response.write "<center><a href='showall.asp'><font size=3 color=#aa0000>[������ҳ��]</font></a><br></center>"

end_this_file()   '���������򣬼����ļ���β

'*****************************����ȫ������

%>


