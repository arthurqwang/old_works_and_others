<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/cfmexp.inc"-->

<html><head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>DO������������</title>
<link rel="stylesheet" type="text/css" href="style.css"></head>
<body bgcolor='#FFFFFF' alink='#330099' link='#330099' vlink='#666699'>
<center>
<%
if isexp=1 then 
  response.write "<img src='images/light.gif' border='0'><font size=2 color=#666666>[ר��/�α�����������] ��ǰ��ݣ�"&expertnm&"("&realnm&")���б��<img src='images/expert.gif' border=0>�Ĳ���Ϊ�����������ݡ�&nbsp;</font>"
  response.write "&nbsp;&nbsp;<a href=exitexpert.asp?to=showdownload.asp><img src='images/exit.gif' border=0><font size=2 color=#666666>�˳�</font></a><a href=exppwchg.asp target='_blank'>&nbsp;&nbsp;<img src='images/key.gif' border=0><font size=2 color=#666666>�޸�ע����Ϣ</font></a><a href=othexp.asp target='_blank'>&nbsp;&nbsp;<img src='images/othexp.gif' border=0><font size=2 color=#666666>��ϵ����ר��/�α�</font></a>"
end if
%>
</center>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p>
<table border="0" width="800"><tr><td valign="top" align="right" width="200"><img border="0" src="images/download.jpg"></td><td valign="bottom" align="left"><font face="����" size="6">����������̳ - ������������</font></td></tr>
<tr><td colspan="2" align="center"><font size="2" color="#666666"><br>��λ̳�ѣ�����̳�ṩ������ֻΪС��Χ����֮�ã���ע���Ȩ�����ܵ����⡣<br>��Ҫ��������������Arthur����̳����Marrist��ϵ��</font></td></tr>
</table>
<br>

<table border="0">
  <tr>
    <td><form method="POST" action="searchdl.asp">
          <div class="smallFont" align="center"><table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd"><tr><td><font color="#336699">����������������</font>&nbsp;&nbsp;�ؼ��ʣ�<input class="smallInput" type="text" name="keywords" size="17">
		  <input class="buttonface" type="submit" value="����" name="cmdTopic"></td></tr></table></div>
        </form>
    </td>		
  </tr>
  <tr><td><font size="2" color="#666666">�����������Ը��ʹ�ҹ������� <a href="dlurlmng.asp" target="_blank"><font size=2 color=#336699>[�������]<font></a> </font><font size=2 color=#666666>���롣</font></td></tr>
</table>
<br>
<table border="0" width="800">
<tr><td width='20' valign='top'><font size=2 color=#666666>*</font></td><td><font size=2 color=#996633>Arthurר��</font><a href="http://www.internetism.org/experts/7/works/tzwj.htm" target="_blank"><font size=2 color=#336699>[����]</font></a></td></tr>
<tr><td width='20' valign='top'><font size=2 color=#666666>*</font></td><td><font size=2 color=#996633>BBS������</font><a href="http://www.internetism.org/qbbs/viewStatus.asp?type=1&boardID=1" target="_blank"><font size=2 color=#336699>[����]</font></a></td></tr>

<%
 '       on error resume next
 '       dim cmdTemp
'		dim InsertCursor
'		dim dataconn
'        Set DataConn = Server.CreateObject("ADODB.Connection")
'		dataconn.open connstr
'        Set cmdTemp = Server.CreateObject("ADODB.Command")
'		Set InsertCursor = Server.CreateObject("ADODB.Recordset")
'		cmdTemp.CommandText = "SELECT * FROM dllist where display=1"
'		cmdTemp.CommandType = 1
'		Set cmdTemp.ActiveConnection = dataConn
'		InsertCursor.Open cmdTemp, , 1, 3
'        InsertCursor.AddNew
'		InsertCursor("topic") = "����1"
'		InsertCursor("shorttopic") = "duanbiaoti1"
'		InsertCursor("author") = "wangquan"
'		InsertCursor("intro")="rar��ʽ"
'		InsertCursor("size") = "125K"
'        InsertCursor("url") = "http://www.internetism.org"
'		InsertCursor.Update
'        if err.number = 0 then 
'		   err.clear
'		   FoundError=true
'		   ErrMsg="���ݿ����ʧ�ܣ����Ժ�����"&err.Description 
'		end if
'        InsertCursor.close
'		dataconn.close

    dim rs,sql,i
    i=1
    set rs=server.createobject("adodb.recordset")
    sql="select * from dllist order by priority desc,seq desc"
    if isexp=0 then  sql="select * from dllist where specialzone=0 and display=1 order by priority desc,seq desc"
       rs.open sql,conn,1,1
 	 do while not rs.EOF 
       response.write "<tr><td width='20' valign='top'><font size=2 color=#666666>"&i&"</font></td><td>"
       if rs("specialzone")=1 then response.write "<img border='0' src='images/expert.gif'>"
       response.write "<font size=2 color=#666666>"
       if rs("folderornot")=1 then response.write "<img border='0' src='images/folder.gif' title='�ļ���'>"
       response.write rs("topic")
       if rs("important")=1 then response.write "<img border='0' src='images/important.gif' title='��Ҫ�ĵ�'>"
       if trim(rs("needpass"))<>"" then response.write "<img border='0' src='images/lock.gif' title='��Ҫ���룬����ϵ�����˻���̳����'>"
       if rs("newornot")=1 then response.write "<img border='0' src='images/new.gif' title='�����ĵ�'>"
       if rs("author")<>"" then response.write "��"&rs("author")
       if rs("format")<>"" then response.write "��"&rs("format")
       if rs("size")<>"" then response.write "��"&rs("size")
       response.write "<a href='"
       response.write rs("url")&"' target='_blank'><font color='#336699'>"
       if rs("folderornot")>0 then
         response.write "[����Ŀ¼]</a>"
       else
         response.write "[����/���]</a>"
       end if
       if rs("explain")<>"" then response.write "<br>&nbsp;&nbsp;&nbsp;˵����<font color='#666666'>"&rs("explain") 
       response.write "</font></font></td></tr>"
       rs.MoveNext
       i=i+1 
     loop
     rs.Close
%>
</table>
</center>
</body>
</html>
