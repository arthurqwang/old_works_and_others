<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<%
if request.cookies("adminok")="" then
  response.redirect "index.html"
end if
   dim sql,rs,rsBoard,BoardName,boardsql
   dim boardmaster
   on error resume next
    if session("masterlogin")="true" then
   boardID=session("manageboard")
    end if   

 set rs=server.createobject("adodb.recordset")
 boardsql="select * from board where boardID="+cstr(boardID)+""
 rs.open boardsql,conn,1,1
if not rs.eof then
    boardname=rs("boardname")
    boardtype=rs("boardtype")
end if
	%>

<html><head><title>�ı���̳����</title>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
 <link rel="stylesheet" type="text/css" href="lun.css"></head>
<script language="JavaScript">
<!--

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_changeProp(objName,x,theProp,theValue) { //v3.0
  var obj = MM_findObj(objName);
  if (obj && (theProp.indexOf("style.")==-1 || obj.style)) eval("obj."+theProp+"='"+theValue+"'");
}

function Set_Color(cvalue) {
	switch (document.netsh.color_Selector.selectedIndex) {
		case 0:			document.netsh.fontcolor.value = cvalue;break;
		case 1:			document.netsh.link.value = cvalue;break;
		case 2:			document.netsh.vlink.value = cvalue; break;
		case 3:			document.netsh.bgcolor.value = cvalue; break;
	}
}
//-->
</script>
<BODY marginheight=0 marginwidth=0 topmargin="0" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<center>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td><br>
<center><h3>�ı���̳����</h3></center>

<form method=POST action="saveboardset.asp" name=netsh>
<input type=hidden name="boardID" value="<%=boardID%>">
��̳���ƣ�<input type=text name="BoardName" value="<%=rs("BoardName")%>"><br>
��̳���<select name="dirnm"><option value="" >��ѡ�����
 <option value="����">����
 <option value="��Ʊ">��Ʊ
 <option value="�ƾ�">�ƾ�
 <option value="���">���
 <option value="��ѧ">��ѧ
 <option value="ʫ��">ʫ��
 <option value="�ڽ�">�ڽ�
 <option value="����">����
 <option value="��ѧ">��ѧ
 <option value="��Ϸ">��Ϸ
 <option value="����">����
 <option value="����">����
 <option value="����">����
 <option value="Ϸ��">Ϸ��
 <option value="����">����
 <option value="����">����
 <option value="����" selected>����
 <option value="����">����
 <option value="����">����
 <option value="����">����
 <option value="����">����
 <option value="����">����
 <option value="��ѧ">��ѧ
</select>(��ѡ��ȷ�����) <br>
��̳˵����<textarea name="des" cols="40"  rows="4"><%=rs("BoardInfo")%></textarea>(��������100��)<br>
�������(������HTML����,����ͼƬ�������):<br>
<textarea name="title" cols="80" rows="10"><%=rs("BoardHead")%>
</textarea><br>
��'��������'��λ���¼���һ�λ�(������HTML����,��:������ �������� �����Լ���ҳ�Ĵ����):<br>
<textarea name="own" cols="80" rows="10" ><%=rs("BoardOwn")%>
</textarea><br>
��ÿ�����ӵײ������Լ����һ�λ�(������HTML����,��:���Լ��Ĺ��banner �����������):<br>
<textarea name="ownad" cols="80" rows="5" ><%=rs("Boardad")%>
</textarea><br>
��̳��ʽ:<input type=radio name="face" value="1" <% if rs("Boardstyle")=1 then response.write "checked"%>>���·����� 
<input type=radio name="face" value="0" <% if rs("boardstyle")=0 then response.write "checked"%>>��ҳʽ<br>
<input type="Checkbox" name="space" value="1" <% if rs("space")=1 then response.write "checked"%>>ÿ��֮������һ���ո�<br>
<input type="Checkbox" name="sayface"  value="1" <% if rs("sayface")=1 then response.write "checked"%>>��Ҫ���Ա������<br>
<input type="Checkbox" name="noonline" value="1" <% if rs("noonline")=1 then response.write "checked"%>>����ʾ��������<br>
��̳��������˳��<br>
&nbsp;&nbsp;<input type="Radio" name="postseq"  value="0" <% if rs("postseq")=0 then response.write "checked"%>>��������ʱ���Ⱥ�<br>
&nbsp;&nbsp;<input type="Radio" name="postseq"  value="1" <% if rs("postseq")=1 then response.write "checked"%>>��������������ʱ���Ⱥ�<br>
<br><center><hr width=80%></center><br>
<p>�����������С����ɫ������,ֻ�ж�������Ч.
<table bgcolor="#E2E2D8"><tr><td>
��ɫ����:��<input type=hidden name="keystr" value=8514016183963f35599019>
<select name=color_Selector>
<option>������ɫ</option>
<option>����ǰɫ</option>
<option>���Ӻ�ɫ</option>
<option>������ɫ</option>
</select>��ѡ����Ӧ��,�ٵ�ѡ������ɫ��.<br>
<IMG src="images/colorpicker.gif" border="0" width="257" height="91" usemap="#colorpicker_map">
<MAP name="colorpicker_map">
<AREA coords="243,75,258,91" href="javascript:Set_Color('#000000')">
<AREA coords="243,60,258,76" href="javascript:Set_Color('#333333')">
<AREA coords="243,45,258,61" href="javascript:Set_Color('#666666')">
<AREA coords="243,30,258,46" href="javascript:Set_Color('#999999')">
<AREA coords="243,15,258,31" href="javascript:Set_Color('#CCCCCC')">
<AREA coords="243,0,258,16" href="javascript:Set_Color('#FFFFFF')">
<AREA coords="207,82,244,91" href="javascript:Set_Color('#660033')">
<AREA coords="225,72,244,83" href="javascript:Set_Color('#990033')">
<AREA coords="207,72,226,83" href="javascript:Set_Color('#993366')">
<AREA coords="231,60,244,73" href="javascript:Set_Color('#CC0066')">
<AREA coords="219,60,232,73" href="javascript:Set_Color('#CC3399')">
<AREA coords="207,60,220,73" href="javascript:Set_Color('#CC6699')">
<AREA coords="234,45,244,61" href="javascript:Set_Color('#FF0099')">
<AREA coords="225,45,235,61" href="javascript:Set_Color('#FF3399')">
<AREA coords="216,45,226,61" href="javascript:Set_Color('#FF6699')">
<AREA coords="207,45,217,61" href="javascript:Set_Color('#FF99CC')">
<AREA coords="184,82,208,91" href="javascript:Set_Color('#660000')">
<AREA coords="162,82,185,91" href="javascript:Set_Color('#663333')">
<AREA coords="192,72,208,83" href="javascript:Set_Color('#990000')">
<AREA coords="177,72,193,83" href="javascript:Set_Color('#993333')">
<AREA coords="162,72,178,83" href="javascript:Set_Color('#996666')">
<AREA coords="196,60,208,73" href="javascript:Set_Color('#CC0000')">
<AREA coords="184,60,197,73" href="javascript:Set_Color('#CC3333')">
<AREA coords="173,60,185,73" href="javascript:Set_Color('#CC6666')">
<AREA coords="162,60,174,73" href="javascript:Set_Color('#CC9999')">
<AREA coords="198,45,208,61" href="javascript:Set_Color('#FF0000')">
<AREA coords="189,45,199,61" href="javascript:Set_Color('#FF3333')">
<AREA coords="180,45,190,61" href="javascript:Set_Color('#FF6666')">
<AREA coords="171,45,181,61" href="javascript:Set_Color('#FF9999')">
<AREA coords="162,45,172,61" href="javascript:Set_Color('#FFCCCC')">
<AREA coords="126,82,163,91" href="javascript:Set_Color('#663300')">
<AREA coords="144,72,163,83" href="javascript:Set_Color('#993300')">
<AREA coords="126,72,145,83" href="javascript:Set_Color('#996633')">
<AREA coords="150,60,163,73" href="javascript:Set_Color('#CC6600')">
<AREA coords="138,60,151,73" href="javascript:Set_Color('#CC6633')">
<AREA coords="126,60,139,73" href="javascript:Set_Color('#CC9966')">
<AREA coords="153,45,163,61" href="javascript:Set_Color('#FF6600')">
<AREA coords="144,45,154,61" href="javascript:Set_Color('#FF9933')">
<AREA coords="135,45,145,61" href="javascript:Set_Color('#FF9966')">
<AREA coords="126,45,136,61" href="javascript:Set_Color('#FFCC00')">
<AREA coords="103,82,127,91" href="javascript:Set_Color('#666600')">
<AREA coords="81,82,104,91" href="javascript:Set_Color('#666633')">
<AREA coords="111,72,127,83" href="javascript:Set_Color('#999900')">
<AREA coords="96,72,112,83" href="javascript:Set_Color('#999933')">
<AREA coords="81,72,97,83" href="javascript:Set_Color('#999966')">
<AREA coords="115,60,127,73" href="javascript:Set_Color('#CCCC00')">
<AREA coords="103,60,116,73" href="javascript:Set_Color('#CCCC33')">
<AREA coords="92,60,104,73" href="javascript:Set_Color('#CCCC66')">
<AREA coords="81,60,93,73" href="javascript:Set_Color('#CCCC99')">
<AREA coords="117,45,127,61" href="javascript:Set_Color('#FFFF00')">
<AREA coords="108,45,118,61" href="javascript:Set_Color('#FFFF33')">
<AREA coords="99,45,109,61" href="javascript:Set_Color('#FFFF66')">
<AREA coords="90,45,100,61" href="javascript:Set_Color('#FFFF99')">
<AREA coords="81,45,91,61" href="javascript:Set_Color('#FFFFCC')">
<AREA coords="45,82,82,91" href="javascript:Set_Color('#336600')">
<AREA coords="63,72,82,83" href="javascript:Set_Color('#339900')">
<AREA coords="45,72,64,83" href="javascript:Set_Color('#669933')">
<AREA coords="69,60,82,73" href="javascript:Set_Color('#66CC00')">
<AREA coords="57,60,70,73" href="javascript:Set_Color('#99CC33')">
<AREA coords="45,60,58,73" href="javascript:Set_Color('#99CC66')">
<AREA coords="72,45,82,61" href="javascript:Set_Color('#99FF00')">
<AREA coords="63,45,73,61" href="javascript:Set_Color('#99FF33')">
<AREA coords="54,45,64,61" href="javascript:Set_Color('#99FF66')">
<AREA coords="45,45,55,61" href="javascript:Set_Color('#CCFF99')">
<AREA coords="22,82,46,91" href="javascript:Set_Color('#006600')">
<AREA coords="0,82,23,91" href="javascript:Set_Color('#336633')">
<AREA coords="30,72,46,83" href="javascript:Set_Color('#009900')">
<AREA coords="15,72,31,83" href="javascript:Set_Color('#339933')">
<AREA coords="0,72,16,83" href="javascript:Set_Color('#669966')">
<AREA coords="34,60,46,73" href="javascript:Set_Color('#00CC00')">
<AREA coords="22,60,35,73" href="javascript:Set_Color('#33CC33')">
<AREA coords="11,60,23,73" href="javascript:Set_Color('#66CC66')">
<AREA coords="0,60,12,73" href="javascript:Set_Color('#99CC99')">
<AREA coords="36,45,46,61" href="javascript:Set_Color('#00FF00')">
<AREA coords="27,45,37,61" href="javascript:Set_Color('#33FF33')">
<AREA coords="18,45,28,61" href="javascript:Set_Color('#66FF66')">
<AREA coords="9,45,19,61" href="javascript:Set_Color('#99FF99')">
<AREA coords="0,45,10,61" href="javascript:Set_Color('#CCFFCC')">
<AREA coords="207,37,244,46" href="javascript:Set_Color('#006633')">
<AREA coords="225,27,244,38" href="javascript:Set_Color('#009933')">
<AREA coords="207,27,226,38" href="javascript:Set_Color('#339966')">
<AREA coords="231,15,244,28" href="javascript:Set_Color('#00CC66')">
<AREA coords="219,15,232,28" href="javascript:Set_Color('#33CC66')">
<AREA coords="207,15,220,28" href="javascript:Set_Color('#66CC99')">
<AREA coords="234,0,244,16" href="javascript:Set_Color('#00FF66')">
<AREA coords="225,0,235,16" href="javascript:Set_Color('#33FF99')">
<AREA coords="216,0,226,16" href="javascript:Set_Color('#66FF99')">
<AREA coords="207,0,217,16" href="javascript:Set_Color('#99FFCC')">
<AREA coords="184,37,208,46" href="javascript:Set_Color('#006666')">
<AREA coords="162,37,185,46" href="javascript:Set_Color('#336666')">
<AREA coords="192,27,208,38" href="javascript:Set_Color('#009999')">
<AREA coords="177,27,193,38" href="javascript:Set_Color('#339999')">
<AREA coords="162,27,178,38" href="javascript:Set_Color('#669999')">
<AREA coords="196,15,208,28" href="javascript:Set_Color('#00CCCC')">
<AREA coords="184,15,197,28" href="javascript:Set_Color('#33CCCC')">
<AREA coords="173,15,185,28" href="javascript:Set_Color('#66CCCC')">
<AREA coords="162,15,174,28" href="javascript:Set_Color('#99CCCC')">
<AREA coords="198,0,208,16" href="javascript:Set_Color('#00FFFF')">
<AREA coords="189,0,199,16" href="javascript:Set_Color('#33FFFF')">
<AREA coords="180,0,190,16" href="javascript:Set_Color('#66FFFF')">
<AREA coords="171,0,181,16" href="javascript:Set_Color('#99FFFF')">
<AREA coords="162,0,172,16" href="javascript:Set_Color('#CCFFFF')">
<AREA coords="126,37,163,46" href="javascript:Set_Color('#003366')">
<AREA coords="144,27,163,38" href="javascript:Set_Color('#003399')">
<AREA coords="126,27,145,38" href="javascript:Set_Color('#336699')">
<AREA coords="150,15,163,28" href="javascript:Set_Color('#0066CC')">
<AREA coords="138,15,151,28" href="javascript:Set_Color('#3399CC')">
<AREA coords="126,15,139,28" href="javascript:Set_Color('#6699CC')">
<AREA coords="153,0,163,16" href="javascript:Set_Color('#0099FF')">
<AREA coords="144,0,154,16" href="javascript:Set_Color('#3399FF')">
<AREA coords="135,0,145,16" href="javascript:Set_Color('#6699FF')">
<AREA coords="126,0,136,16" href="javascript:Set_Color('#99CCFF')">
<AREA coords="103,37,127,46" href="javascript:Set_Color('#000066')">
<AREA coords="81,37,104,46" href="javascript:Set_Color('#333366')">
<AREA coords="111,27,127,38" href="javascript:Set_Color('#000099')">
<AREA coords="96,27,112,38" href="javascript:Set_Color('#333399')">
<AREA coords="81,27,97,38" href="javascript:Set_Color('#666699')">
<AREA coords="115,15,127,28" href="javascript:Set_Color('#0000CC')">
<AREA coords="103,15,116,28" href="javascript:Set_Color('#3333CC')">
<AREA coords="92,15,104,28" href="javascript:Set_Color('#6666CC')">
<AREA coords="81,15,93,28" href="javascript:Set_Color('#9999CC')">
<AREA coords="117,0,127,16" href="javascript:Set_Color('#0000FF')">
<AREA coords="108,0,118,16" href="javascript:Set_Color('#3333FF')">
<AREA coords="99,0,109,16" href="javascript:Set_Color('#6666FF')">
<AREA coords="90,0,100,16" href="javascript:Set_Color('#9999FF')">
<AREA coords="81,0,91,16" href="javascript:Set_Color('#CCCCFF')">
<AREA coords="45,37,82,46" href="javascript:Set_Color('#330066')">
<AREA coords="63,27,82,38" href="javascript:Set_Color('#330099')">
<AREA coords="45,27,64,38" href="javascript:Set_Color('#663399')">
<AREA coords="69,15,82,28" href="javascript:Set_Color('#6600CC')">
<AREA coords="57,15,70,28" href="javascript:Set_Color('#6633CC')">
<AREA coords="45,15,58,28" href="javascript:Set_Color('#9966CC')">
<AREA coords="72,0,82,16" href="javascript:Set_Color('#6600FF')">
<AREA coords="63,0,73,16" href="javascript:Set_Color('#9933FF')">
<AREA coords="54,0,64,16" href="javascript:Set_Color('#9966FF')">
<AREA coords="45,0,55,16" href="javascript:Set_Color('#CC99FF')">
<AREA coords="22,37,46,46" href="javascript:Set_Color('#660066')">
<AREA coords="0,37,23,46" href="javascript:Set_Color('#663366')">
<AREA coords="30,27,46,38" href="javascript:Set_Color('#990099')">
<AREA coords="15,27,31,38" href="javascript:Set_Color('#993399')">
<AREA coords="0,27,16,38" href="javascript:Set_Color('#996699')">
<AREA coords="34,15,46,28" href="javascript:Set_Color('#CC00CC')">
<AREA coords="22,15,35,28" href="javascript:Set_Color('#CC33CC')">
<AREA coords="11,15,23,28" href="javascript:Set_Color('#CC66CC')">
<AREA coords="0,15,12,28" href="javascript:Set_Color('#CC99CC')">
<AREA coords="36,0,46,16" href="javascript:Set_Color('#FF00FF')">
<AREA coords="27,0,37,16" href="javascript:Set_Color('#FF33FF')">
<AREA coords="18,0,28,16" href="javascript:Set_Color('#FF66FF')">
<AREA coords="9,0,18,16" href="javascript:Set_Color('#FF99FF')">
<AREA coords="0,0,9,16" href="javascript:Set_Color('#FFCCFF')">
</map>
<br>
������ɫ��<input type=text name="fontcolor" value="<%=rs("fontcolor")%>" onFocus="MM_changeProp('color_Selector','','selectedIndex','0','SELECT')" ><br>
����ǰɫ��<input type=text name="link" value="<%=rs("link")%>" onFocus="MM_changeProp('color_Selector','','selectedIndex','1','SELECT')" ><br>
���Ӻ�ɫ��<input type=text name="vlink" value="<%=rs("vlink")%>" onFocus="MM_changeProp('color_Selector','','selectedIndex','2','SELECT')" ><br>
������ɫ��<input type=text name="bgcolor" value="<%=rs("bgcolor")%>" onFocus="MM_changeProp('color_Selector','','selectedIndex','3','SELECT')" ><br>
<p>�����С��<select name='fontsize'><option value='-1' <% if rs("fontsize")="-1" then response.write "selected"%>>Сһ��<option value='' <% if rs("fontsize")="" then response.write "selected"%>>����<option value='+1' <% if rs("fontsize")="+1" then response.write "selected"%>>��һ��<option value=''>�Լ�����</select><br>
����ͼƬ��<input type=text name="background" size="40" value="<%=rs("background")%>"><br>
</td></tr></table>
<br><center><hr width=80%></center><br>
ÿҳ������<input type=text name="postsinpage" size="6" value="<%=rs("postsinpage")%>">�� (ֵԽС,��̳�ٶ�Խ��,ע������������������������)<br>
<br>
<input type=submit value="ȷ����������"> <input type=reset>
</form>
</td></tr></table><br>


</center>
</font>
<% 
session("boardsetok")="yes"
rs.Close
set rs=nothing
  %>
</body>
</html>