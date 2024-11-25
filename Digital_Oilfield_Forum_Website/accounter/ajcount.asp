<%@ CODEPAGE = "936" %>
<%

'#################################
'
'        阿江简易计数系统
'          V1.0 - 030521
'    Ajiang   info@ajiang.net 
'         www.ajiang.net
'
'     版权所有·抄袭挪用必究
'
'#################################


'##### ★ 参 数 设 置 ★ #####

' 1、保存IP个数
SaveIP		= 1

' 2、数据文件名
DataFile	= "countdata.mdb"

' 3、统计器名称
CountName	= "数字油田论坛访问统计"

' 4、是否允许使用升级功能
CanUpgrade	= 0

' 说明：

'     1.比如设置为50，只有当你访问网页后又有超过50个人访问了这
' 个网页，你再访问才会计数，如果从你上次访问到这次访问之间没有
' 那么多人访问，则不计数。

'     2.计数数据将保存在这个文件中，可以使用带有相对路径的字串

'     3.已设置为FSO的默认名字，有的服务器已将FSO改名，

'     4.有关此参数用法请查阅 readme.txt



'##### ★ 代 码 开 始 ★ #####（以下请勿修改）

' 忽略所有错误
on error resume next

' 得到本文件的名字
mename=Request.ServerVariables("SCRIPT_NAME")

' 创建数据对象

tpage=Request("tpage")

if tpage<> "noado" then

Set conn=server.createobject("adodb.connection")
If Err<>0 then Response.Redirect mename & "?tpage=noado"

DBPath = Server.MapPath(DataFile)
conn.Open "driver={Microsoft Access Driver (*.mdb)};dbq=" & DBPath

end if

'*******************************
'        转入相应的页面
'*******************************

select case tpage

'***************************************************************
'                                                       查看页面

case "view"

%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="CopyRight" content="Ajiang http://www.ajiang.net info@ajiang.net">
<TITLE><%=CountName%> - 查看统计数据</TITLE>
<style>
<!--
BODY
{
	FONT-FAMILY: 宋体;
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
<center><a href="http://www.digitaloilfield.org.cn" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3>浏览统计</h3></center>
<%
strold=ReadData()
'response.write strold&"---------"&date()
if not(isnull(strold) or len(strOld)<6) then
	
	'分解数据文件，获得数据
	vstr=split(strold,vbcrlf)
	
	'访问天数、平均每天访问量
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
		<td align=left width="130">&nbsp;总浏览量</td>
		<td align=left width="170">&nbsp;<%=vstr(0)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;总访问数(IP)</td>
		<td align=left>&nbsp;<%=vstr(1)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;今日访问数(IP)</td>
		<td align=left>&nbsp;<%=vstr(2)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;昨日访问数(IP)</td>
		<td align=left>&nbsp;<%=vstr(3)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;开始统计日期</td>
		<td align=left>&nbsp;<%=vstr(4)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;统计天数</td>
		<td align=left>&nbsp;<%=vdays%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;平均日访问量(IP)</td>
		<td align=left>&nbsp;<%=vdayavg%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;最高日访问量(IP)</td>
		<td align=left>&nbsp;<%=vstr(7)%></td>
	</tr>
	<tr height="18" class=backq>
		<td align=left>&nbsp;发生日期</td>
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
		<td align=center width=250 height=80>还没有任何统计数据。请将嵌入代码放<br>在您要统计的页面。</td>
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
'                                            不支持ADO的错误页面
case "upgrade"
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=CountName%> - 从旧版本升级</TITLE>
<style>
<!--
BODY
{
	FONT-FAMILY: 宋体;
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
		<br>&nbsp;∷∷∷ 版本升级 ∷∷∷
		<br>
		<br>&nbsp;如果旧版本未做过任何修改，则下列文本框
		<br>&nbsp;中的内容请不要改动
		<br>&nbsp;1、原来保存数据的文本文件是
		<br>&nbsp;　 <input name="textdata" value="countdata.txt" size=25 class=input>
		<br>&nbsp;2、创建FSO对象使用的字串
		<br>&nbsp;　 <input name="fsostr" value="Scripting.FileSystemObject6" size=25 class=input>
		<br>
		<br>&nbsp;<INPUT type="submit" value="开始升级" class=backc>
		<br><br></td>
	</tr>
	</form>
<%
else
	strok=""
	' 数据文件的绝对路径
	thedatafile=server.MapPath(textdata)
	'创建FSO对象，如果不支持FSO，则转入错误页
	Set FSO = CreateObject(FSOstr)
	If Err<>0 then
		strok="<br>因为服务器不支持FSO数据对象，升级失败。"
	else
		' 检查数据文件是否存在
		infile=fso.FileExists(thedatafile)
		if infile=false then
			strok="<br>因为您指定的文本数据文件不存在，升级失败。"
		else
			set thefile=fso.OpenTextFile(thedatafile)
			stroldfile=thefile.readall
			thefile.close
			set thefile=nothing
			writedata stroldfile
			strok="<br>版本升级完成！"
		end if
	end if
%>
	<tr height="18" class=backq>
		<td align=center width="250" height=120>
		∷∷∷ 版本升级 ∷∷∷
		<br><%=strok%>
		</td>
	</tr>
<%
end if

else	'是否允许升级
%>
	<tr height="18" class=backq>
		<td align=center width="250" height=120>
		∷∷∷ 版本升级 ∷∷∷
		<br><br>本系统升级功能已设置为禁止！
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
'                                            不支持ADO的错误页面
case "noado"
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=CountName%> - 错误信息</TITLE>
<style>
<!--
BODY
{
	FONT-FAMILY: 宋体;
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
		<td align=center width="250" height=80>对不起，您的服务器不支持ADO数据<br>对象，无法使用本系统。</td>
	</tr>
</table>
    </td>
  </tr>
</table>
</body>
</html>

<%


'***************************************************************
'                                                       计数页面

case else

' 网页立即过期，防止漏统计
Response.Expires = -1

' 检查客户端IP
vip=Request.ServerVariables("Remote_Addr")

'读取旧数据
strOld=ReadData()

'如果还没有统计数据
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

	'写入数据库
	WriteData(savestr)

'如果已经存在统计数据
else
	
	'分解数据文件，获得数据
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
	
	'向现有数据中追加值
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
	
	'写入数据文件
	SaveStr=vtop & VbCrlf & vips & VbCrlf & vtoday & VbCrlf & vyesterday & VbCrlf & _
		vstarttime & VbCrlf & vtodaytime & vbcrlf & vsaveips & vbcrlf & vmax & vbcrlf & vmaxtime

	'写入数据库	
	WriteData(Savestr)

end if

'根据要求输出
style=Request("style")
select case style
case "counter"	'LOGO
	outstr="<table width='88' border='0' cellspacing='0' cellpadding='0' height='31' background='http://www.digitaloilfield.org.cn/accounter/count_i.gif'><tr><td height='5' width='24'></td><td height='5' width='57'></td><td height='5' width='7'></td></tr><tr><td height='16'></td><td height='16' align='center' valign='top'><marquee behavior='loop' scrollDelay='100' scrollAmount='3' style='font-size: 12px; line-height=15px'><a href='" & mename & "?tpage=view' target='_blank' style='color: #ffffff; text-decoration: none'>"
	outstr=outstr & "<font face='Arial, Verdana, san-serif' color='#407526'>总访问量: " & vips & " &nbsp;今日访问: " & vtoday & " &nbsp;昨日访问: " & vyesterday & " &nbsp;最高日访问: " & vmax & " &nbsp;发生日期: " & vmaxtime
	outstr=outstr & "</font>"
	outstr=outstr & "</a></marquee></td><td height='16'></td></tr><tr><td height='10'></td><td height='10'></td><td height='10'></td></tr></table>"

case "icon"		'ICON
	outstr="<a href='" & mename & "?tpage=view' title='" & CountName &  _
		"\n浏览总量: " & vtop & _
		"\n访问总量(IP): " & vips & _
		"\n今日访问量(IP): " & vtoday & "\n昨日访问量(IP): " & vyesterday & _
		"\n最高每日(IP): " & vmax & _
		"\n发生日期: " & vmaxtime
	outstr=outstr & "' target='_blank'><img border='0' src='" & theurl & _
	"http://www.digitaloilfield.org.cn/accounter/count_i.gif'></a>"

case "atext"		'带有连接的访问数
	outstr="<a href='" & mename & "?tpage=view' title='" & CountName &  _
		"\n浏览总量: " & vtop & _
		"\n访问总量: " & vips & _
		"\n今日访问量: " & vtoday & "\n昨日访问量: " & vyesterday & _
		"\n最高每日: " & vmax & _
		"\n发生日期: " & vmaxtime
	outstr=outstr & "' target='_blank'>" & vips & "</a>"

case "textview"		'不带连接的浏览数
	outstr=vtop
	
case "textip"		'不带连接的访问数
	outstr=vips
	
end select

'输出
Response.Write "document.write(" & chr(34) & outstr & chr(34) & ")"

end select	'选择要浏览的页面


if tpage<> "noado" then

	' 关闭数据对象
	set conn=nothing

end if

'****************** 自定义函数 ********************

'读取数据库中的数据
function ReadData()
	set rs=conn.Execute("select * from data")
	ReadData=rs(0)
	set rs=nothing
end function

'将数据写入数据库
function WriteData(strcontent)
	conn.Execute("update data set content='" & strcontent & "'")
end function

%>