<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="subs.asp"-->

<html>
<head>
<title>ŵ����Ѽ����ũ�������-��Ʒ���ƵǼǰ�</title>
</head>

<%
verify_user() '����û�Ȩ�ޣ�is_adm=1? dlwm=?  ndxm=?
if dlwm="" then response.redirect "ggymreg2.html"
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

<h3>�ǼǶ�����Ϣ</h3>

<table border="0"><tr><td align="left"><font size="2">
����Ѽ�׼�����ũ��Ʒ�����ڴ˵Ǽ�<br>
������Ѽ������Ĳ�Ʒ��������˵����ע��<br>
����<font color="#ff0000">��Ϣ���׼ȷ�����Ǳ�֤����й</font><br>
<form name='or1' method='post' action='http://www.kxqbz.com/guaguayami/order2.asp'>

������¼����:<% response.write dlwm %>
������������:<% response.write ndxm %><br><br>

������������:<input type='text' name='dgxs'  size='25' id='k7' style='color:#999;'  value='ÿ��20�1����' onfocus='if(this.value=="ÿ��20�1����"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="ÿ��20�1����";this.style.color="#999";}'><br>

����Ʒ�ʵȼ�:<input type='radio' name='pzdj' value='0' >�ؼ���<input type='radio' name='pzdj' value='1' >һ����<input type='radio' name='pzdj' value='2' >����<br>

������������:<input type='radio' name='ddlx' value='0' >�ֻ����ס���<input type='radio' name='ddlx' value='1' >���Ԥ��<br>

�����ջ���ʽ:<input type='radio' name='shfs' value='0' >�ؿ�ֱ���<input type='radio' name='shfs' value='1' >ͬ����ȡ<br>

����ѡ��غ�:<input type='text'  name='xzdh'  size='18' id='k102' style='color:#999;'  value='�뿴������Ƭѡ��غ�' onfocus='if(this.value=="�뿴������Ƭѡ��غ�"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="�뿴������Ƭѡ��غ�";this.style.color="#999";}'><a  href="http://www.kxqbz.com/guaguayami/images/ggg5.jpg" target="_blank">������Ƭ</a><br>

�����ջ��ˡ�:<input type='text'  name='shr'  size='25' id='k10' style='color:#999;'  value='��������Ŷ��ȱʡ�����Լ�' onfocus='if(this.value=="��������Ŷ��ȱʡ�����Լ�"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="��������Ŷ��ȱʡ�����Լ�";this.style.color="#999";}'><br>

�����ջ��绰:<input type='text' name='shdh'  size='25' id='k11' style='color:#999;'  value='ȱʡ�����ĳ����ֻ�' onfocus='if(this.value=="ȱʡ�����ĳ����ֻ�"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="ȱʡ�����ĳ����ֻ�";this.style.color="#999";}'><br>

�����ջ���ַ:<input type='text'  name='shdz'  size='25' id='k5' style='color:#999;'  value='����ϸ׼ȷ��д' onfocus='if(this.value=="����ϸ׼ȷ��д"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="����ϸ׼ȷ��д";this.style.color="#999";}'><br>

������������:<input type='text' name='yzbm'  size='25' ><br>

��������˵��:<input type='text'  name='qtsm'  size='25' id='k' style='color:#999;'  value='���綩��Ѽ�ӡ��󶹡������' onfocus='if(this.value=="���綩��Ѽ�ӡ��󶹡������"){this.value="";this.style.color="#000";}' onblur='if(this.value==""){this.value="���綩��Ѽ�ӡ��󶹡������";this.style.color="#999";}'><br>

�������<font color="#118811">�Ѻ�����</font>:<a href="http://guaguayami.blog.sohu.com" target="_blank"><font color="#ff0000">ŵ����Ѽ����ũ�������</font></a><br>

������<input type='submit' name='djcxhxg' value='�Ǽ�' >��<input type='reset' name='ct' value=' ���� ' >

</form>
����* ����Ϣ��������ʹ�ã�������Ǣ̸<br>
</font></td></tr></table>
</center>
</body>
</html>














