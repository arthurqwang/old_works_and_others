<%@ CODEPAGE = "936" %>
<%

'#################################
'
'        �������׼���ϵͳ
'          V1.0 - 030521
'    Ajiang   info@ajiang.net 
'         www.ajiang.net
'
'     ��Ȩ���С���ϮŲ�ñؾ�
'
'#################################


'##### �� �� �� �� �� �� #####

' 1������IP����
SaveIP		= 1

' 2�������ļ���
DataFile	= "countdata.mdb"

' 3��ͳ��������
CountName	= "����������̳����ͳ��"

' 4���Ƿ�����ʹ����������
CanUpgrade	= 0

' ˵����

'     1.��������Ϊ50��ֻ�е��������ҳ�����г���50���˷�������
' ����ҳ�����ٷ��ʲŻ��������������ϴη��ʵ���η���֮��û��
' ��ô���˷��ʣ��򲻼�����

'     2.�������ݽ�����������ļ��У�����ʹ�ô������·�����ִ�

'     3.������ΪFSO��Ĭ�����֣��еķ������ѽ�FSO������

'     4.�йش˲����÷������ readme.txt



'##### �� �� �� �� ʼ �� #####�����������޸ģ�

' �������д���
on error resume next

' �õ����ļ�������
mename=Request.ServerVariables("SCRIPT_NAME")

' �������ݶ���

tpage=Request("tpage")

if tpage<> "noado" then

Set conn=server.createobject("adodb.connection")
If Err<>0 then Response.Redirect mename & "?tpage=noado"

DBPath = Server.MapPath(DataFile)
conn.Open "driver={Microsoft Access Driver (*.mdb)};dbq=" & DBPath

end if

'*******************************
'        ת����Ӧ��ҳ��
'*******************************

select case tpage

'***************************************************************
'                                                       �鿴ҳ��

case "view"

%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="CopyRight" content="Ajiang http://www.ajiang.net info@ajiang.net">
<TITLE><%=CountName%> - �鿴ͳ������</TITLE>
<style>
<!--
BODY
{
	FONT-FAMILY: ����;
	FONT-SIZE: 9pt
}
TD
{
	FONT-SIZE: 9pt
}
A
{
	COLOR: #000000;
	TEXT-DECORATION: none
}
A:hover
{
	COLOR: #3F8805;
	TEXT-DECORATION: underline
}
.input
{
	BORDER: #111111 1px solid;
	FONT-SIZE: 9pt;
	BACKGROUND-color: #F8FFF0
}
.backs
{
	BACKGROUND-COLOR: #ffffff;
	COLOR: #000000;

}
.backq
{
	BACKGROUND-COLOR: #ffffff
}
.backc
{
	BACKGROUND-COLOR: #3F8805;
	BORDER: medium none;
	COLOR: #ffffff;
	HEIGHT: 18px;
	font-size: 9pt
}
.fonts
{
	COLOR: #3F8805
}
-->
</STYLE>
</HEAD>
<BODY>
<center><a href="http://www.digitaloilfield.org.cn" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3>���ͳ��</h3></center>
<%
strold=ReadData()
'response.write strold&"---------"&date()
if not(isnull(strold) or len(strOld)<6) then
	
	'�ֽ������ļ����������
	vstr=split(strold,vbcrlf)
	
	'����������ƽ��ÿ�������
	vdays=now()-cdate(vstr(4))
	vdayavg=vstr(1)/vdays
	vdays=int((vdays*10^3)+0.5)/10^3
	if vdays<1 then vdays="0" & vdays
	vdayavg=int((vdayavg*10^3)+0.5)/10^3

%>
<table width="100%" height="60%">
  <tr>
    <td width="100%" valign=top>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#000000" width="300" align=center>
	<tr height=18 class=backs align=center><td width=300 colspan=2><%=CountName%></td></tr>
	<tr height="18" class=backq>
		<td align=left width="130">&nbsp;�������</td>
		<td align=left width="170">&nbsp;<%=vstr(0)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;�ܷ�����(IP)</td>
		<td align=left>&nbsp;<%=vstr(1)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;���շ�����(IP)</td>
		<td align=left>&nbsp;<%=vstr(2)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;���շ�����(IP)</td>
		<td align=left>&nbsp;<%=vstr(3)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;��ʼͳ������</td>
		<td align=left>&nbsp;<%=vstr(4)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;ͳ������</td>
		<td align=left>&nbsp;<%=vdays%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;ƽ���շ�����(IP)</td>
		<td align=left>&nbsp;<%=vdayavg%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;����շ�����(IP)</td>
		<td align=left>&nbsp;<%=vstr(7)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;��������</td>
		<td align=left>&nbsp;<%=vstr(8)%></td>
	</tr>
	
</table>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#3F8805" width="300" align=center>
	
</table>
    </td>
  </tr>
</table>
<%else%>
<table width="100%" height="95%">
  <tr>
    <td width="100%" valign=middle>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#3F8805" width="250" align=center>
	<tr height="18" class=backq>
		<td align=center width=250 height=80>��û���κ�ͳ�����ݡ��뽫Ƕ������<br>����Ҫͳ�Ƶ�ҳ�档</td>
	</tr>
</table>
    </td>
  </tr>
</table>
<%end if%>
</body>
</html>
<%

'***************************************************************
'                                            ��֧��ADO�Ĵ���ҳ��
case "upgrade"
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=CountName%> - �Ӿɰ汾����</TITLE>
<style>
<!--
BODY
{
	FONT-FAMILY: ����;
	FONT-SIZE: 9pt
}
TD
{
	FONT-SIZE: 9pt
}
A
{
	COLOR: #000000;
	TEXT-DECORATION: none
}
A:hover
{
	COLOR: #3F8805;
	TEXT-DECORATION: underline
}
.input
{
	BORDER: #111111 1px solid;
	FONT-SIZE: 9pt;
	BACKGROUND-color: #F8FFF0
}
.backs
{
	BACKGROUND-COLOR: #3F8805;
	COLOR: #ffffff;

}
.backq
{
	BACKGROUND-COLOR: #EEFEE0
}
.backc
{
	BACKGROUND-COLOR: #3F8805;
	BORDER: medium none;
	COLOR: #ffffff;
	HEIGHT: 18px;
	font-size: 9pt
}
.fonts
{
	COLOR: #3F8805
}
-->
</STYLE>
</HEAD>
<BODY>
<table width="100%" height="95%">
  <tr>
    <td width="100%" valign=middle>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#3F8805" width="250" align=center>
<%
if canupgrade=true then

textdata	=Request("textdata")
fsostr		=Request("fsostr")

if fsostr="" or textdata="" then
%>
	<form action="<%=mename%>">
	<input type="hidden" name="tpage" value="upgrade">
	<tr height="18" class=backq>
		<td align=left width="320" height=120>
		<br>&nbsp;�ˡˡ� �汾���� �ˡˡ�
		<br>
		<br>&nbsp;����ɰ汾δ�����κ��޸ģ��������ı���
		<br>&nbsp;�е������벻Ҫ�Ķ�
		<br>&nbsp;1��ԭ���������ݵ��ı��ļ���
		<br>&nbsp;�� <input name="textdata" value="countdata.txt" size=25 class=input>
		<br>&nbsp;2������FSO����ʹ�õ��ִ�
		<br>&nbsp;�� <input name="fsostr" value="Scripting.FileSystemObject6" size=25 class=input>
		<br>
		<br>&nbsp;<INPUT type="submit" value="��ʼ����" class=backc>
		<br><br></td>
	</tr>
	</form>
<%
else
	strok=""
	' �����ļ��ľ���·��
	thedatafile=server.MapPath(textdata)
	'����FSO���������֧��FSO����ת�����ҳ
	Set FSO = CreateObject(FSOstr)
	If Err<>0 then
		strok="<br>��Ϊ��������֧��FSO���ݶ�������ʧ�ܡ�"
	else
		' ��������ļ��Ƿ����
		infile=fso.FileExists(thedatafile)
		if infile=false then
			strok="<br>��Ϊ��ָ�����ı������ļ������ڣ�����ʧ�ܡ�"
		else
			set thefile=fso.OpenTextFile(thedatafile)
			stroldfile=thefile.readall
			thefile.close
			set thefile=nothing
			writedata stroldfile
			strok="<br>�汾������ɣ�"
		end if
	end if
%>
	<tr height="18" class=backq>
		<td align=center width="250" height=120>
		�ˡˡ� �汾���� �ˡˡ�
		<br><%=strok%>
		</td>
	</tr>
<%
end if

else	'�Ƿ���������
%>
	<tr height="18" class=backq>
		<td align=center width="250" height=120>
		�ˡˡ� �汾���� �ˡˡ�
		<br><br>��ϵͳ��������������Ϊ��ֹ��
		</td>
	</tr>
<%
end if
%>
</table>
    </td>
  </tr>
</table>
</body>
</html>

<%
'***************************************************************
'                                            ��֧��ADO�Ĵ���ҳ��
case "noado"
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=CountName%> - ������Ϣ</TITLE>
<style>
<!--
BODY
{
	FONT-FAMILY: ����;
	FONT-SIZE: 9pt
}
TD
{
	FONT-SIZE: 9pt
}
A
{
	COLOR: #000000;
	TEXT-DECORATION: none
}
A:hover
{
	COLOR: #3F8805;
	TEXT-DECORATION: underline
}
.input
{
	BORDER: #111111 1px solid;
	FONT-SIZE: 9pt;
	BACKGROUND-color: #F8FFF0
}
.backs
{
	BACKGROUND-COLOR: #3F8805;
	COLOR: #ffffff;

}
.backq
{
	BACKGROUND-COLOR: #EEFEE0
}
.backc
{
	BACKGROUND-COLOR: #3F8805;
	BORDER: medium none;
	COLOR: #ffffff;
	HEIGHT: 18px;
	font-size: 9pt
}
.fonts
{
	COLOR: #3F8805
}
-->
</STYLE>
</HEAD>
<BODY>
<table width="100%" height="95%">
  <tr>
    <td width="100%" valign=middle>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#3F8805" width="250" align=center>
	<tr height="18" class=backq>
		<td align=center width="250" height=80>�Բ������ķ�������֧��ADO����<br>�����޷�ʹ�ñ�ϵͳ��</td>
	</tr>
</table>
    </td>
  </tr>
</table>
</body>
</html>

<%


'***************************************************************
'                                                       ����ҳ��

case else

' ��ҳ�������ڣ���ֹ©ͳ��
Response.Expires = -1

' ���ͻ���IP
vip=Request.ServerVariables("Remote_Addr")

'��ȡ������
strOld=ReadData()

'�����û��ͳ������
if isnull(strold) or len(strOld)<6 then
	vtop=1
	vips=1
	vtoday=1
	vyesterday = 0
	vstarttime = now()
	vtodaytime = date()
	vmax=1
	vmaxtime=date()
	SaveStr=vtop & VbCrlf & vips & VbCrlf & vtoday & VbCrlf & vyesterday & VbCrlf & _
		vstarttime & VbCrlf & vtodaytime & vbcrlf & "#" & vip & "#"  & vbcrlf & vmax & vbcrlf & vmaxtime

	'д�����ݿ�
	WriteData(savestr)

'����Ѿ�����ͳ������
else
	
	'�ֽ������ļ����������
	vstr=split(StrOld,vbcrlf)
	
	vtop=vstr(0)
	vips=vstr(1)
	vtoday=vstr(2)
	vyesterday=vstr(3)
	vstarttime=vstr(4)
	vtodaytime=vstr(5)
	vsaveips=vstr(6)

	if ubound(vstr)>7 then
		vmax=vstr(7)
		vmaxtime=vstr(8)
	else
		vmax=0
	end if


    if cdate(vtodaytime)<>date() then
	    vyesterday=vtoday
	    vtoday=1
		vtodaytime=date()
	end if
	
	'������������׷��ֵ
	vtop=vtop+1
	if instr(vsaveips,"#" & vip & "#")=false then
		vips=vips+1
		if cdate(vtodaytime)=date() then
			vtoday=vtoday+1
'		else
'			vyesterday=vtoday
'			vtoday=1
'			vtodaytime=date()
		end if
		if clng(vtoday)>clng(vmax) then
			vmax=vtoday
			vmaxtime=date()
		end if
		vsaveips=left(vsaveips,len(vsaveips)-1)
		vsaveips=right(vsaveips,len(vsaveips)-1)
		howip=split(vsaveips,"#")
		
		if ubound(howip) < SaveIP then
			vsaveips="#" & vsaveips & "#" & vip & "#"
		else
			vsaveips=replace("#" & vsaveips,"#" & howip(0) & "#","#") & "#" & vip & "#"
		end if
	end if
	
	'д�������ļ�
	SaveStr=vtop & VbCrlf & vips & VbCrlf & vtoday & VbCrlf & vyesterday & VbCrlf & _
		vstarttime & VbCrlf & vtodaytime & vbcrlf & vsaveips & vbcrlf & vmax & vbcrlf & vmaxtime

	'д�����ݿ�	
	WriteData(Savestr)

end if

'����Ҫ�����
style=Request("style")
select case style
case "counter"	'LOGO
	outstr="<table width='88' border='0' cellspacing='0' cellpadding='0' height='31' background='http://www.digitaloilfield.org.cn/accounter/count_i.gif'><tr><td height='5' width='24'></td><td height='5' width='57'></td><td height='5' width='7'></td></tr><tr><td height='16'></td><td height='16' align='center' valign='top'><marquee behavior='loop' scrollDelay='100' scrollAmount='3' style='font-size: 12px; line-height=15px'><a href='" & mename & "?tpage=view' target='_blank' style='color: #ffffff; text-decoration: none'>"
	outstr=outstr & "<font face='Arial, Verdana, san-serif' color='#407526'>�ܷ�����: " & vips & " &nbsp;���շ���: " & vtoday & " &nbsp;���շ���: " & vyesterday & " &nbsp;����շ���: " & vmax & " &nbsp;��������: " & vmaxtime
	outstr=outstr & "</font>"
	outstr=outstr & "</a></marquee></td><td height='16'></td></tr><tr><td height='10'></td><td height='10'></td><td height='10'></td></tr></table>"

case "icon"		'ICON
	outstr="<a href='" & mename & "?tpage=view' title='" & CountName &  _
		"\n�������: " & vtop & _
		"\n��������(IP): " & vips & _
		"\n���շ�����(IP): " & vtoday & "\n���շ�����(IP): " & vyesterday & _
		"\n���ÿ��(IP): " & vmax & _
		"\n��������: " & vmaxtime
	outstr=outstr & "' target='_blank'><img border='0' src='" & theurl & _
	"http://www.digitaloilfield.org.cn/accounter/count_i.gif'></a>"

case "atext"		'�������ӵķ�����
	outstr="<a href='" & mename & "?tpage=view' title='" & CountName &  _
		"\n�������: " & vtop & _
		"\n��������: " & vips & _
		"\n���շ�����: " & vtoday & "\n���շ�����: " & vyesterday & _
		"\n���ÿ��: " & vmax & _
		"\n��������: " & vmaxtime
	outstr=outstr & "' target='_blank'>" & vips & "</a>"

case "textview"		'�������ӵ������
	outstr=vtop
	
case "textip"		'�������ӵķ�����
	outstr=vips
	
end select

'���
Response.Write "document.write(" & chr(34) & outstr & chr(34) & ")"

end select	'ѡ��Ҫ�����ҳ��


if tpage<> "noado" then

	' �ر����ݶ���
	set conn=nothing

end if

'****************** �Զ��庯�� ********************

'��ȡ���ݿ��е�����
function ReadData()
	set rs=conn.Execute("select * from data")
	ReadData=rs(0)
	set rs=nothing
end function

'������д�����ݿ�
function WriteData(strcontent)
	conn.Execute("update data set content='" & strcontent & "'")
end function

%>