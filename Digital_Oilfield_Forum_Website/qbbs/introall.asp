<!--#include file="newconn.asp"-->
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>数字油田论坛暨因特奈特主义学术论坛 Digital Oilfield Forum & Internetism Forum</title>
</head>

<body>

<p align="center"><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg"><img border="0" src="../internetism.jpg"></a></p>
<p align="center"><font size="6" face="黑体">论坛全部专家/嘉宾</font></p>
<center>
<font color=#666666>竭诚欢迎各方面专家、学者和数字油田的研究者、建设者加入！<br><br><b>专家/嘉宾名单</b><br><font size=2>按姓名排序</font></font><br><br>
<table><tr>
<%
dim rs,sql,ik,js,numperline,ii
    ik=1
    js=1
    numperline=6
    set rs=server.createobject("adodb.recordset")
    sql="select realnm,folder from experts where active=1 order by active,realnm"
       rs.open sql,conn,1,1
 	do while not rs.EOF
       response.write "<td>"
       if rs("folder")<>0 then
        response.write "<a href='../experts/"
        response.write rs("folder")
        response.write "/intro.htm' target='_blank'>"
       end if
       response.write "<font color=#666666 size=2>"
       response.write rs("realnm")
       if rs("folder")<>0 then response.write "</a>"
       response.write "&nbsp;&nbsp;&nbsp;&nbsp;</font></td>"
       rs.MoveNext
       if (ik mod numperline) = 0 then
        ik=0
        response.write "</tr>"
       end if
       ik=ik+1
       js=js+1
    loop
    rs.Close
    if (js mod numperline) <>0 then
     for ii=1 to (numperline - (js mod numperline))
      response.write "<td></td>"
     next
     response.write "</tr>"
    end if
%>
</table>
<table width="600"><tr><td><hr></td></tr></table>
<font size=3 color=#666666><br><b>专家/嘉宾简介</b></font>
<font size=2 color=#666666><br><br>按个人资料加载顺序排序<br>请尚未提交个人资料的专家/嘉宾尽快向主持人提交简历和照片。</font>
<table border="0" width="600" cellspacing="0">
<%
        dim experts_num,fs, brief, brief_ch,objFSO,Dir,strFileName,i,j,each_line_num, line_num,n
        each_line_num=4    
        experts_num=0
        Set objFSO = Server.CreateObject("Scripting.FileSystemObject6")
        set fs=server.createobject("MSWC.Nextlink")
        do
          brief_ch="../experts/"&(experts_num+1)
          strFileName= Server.MapPath(brief_ch)
          Dir = objFSO.FolderExists(strFileName)
          if not dir then
            exit do
          else
            experts_num=experts_num+1
            response.write "<tr><td valign='bottom'><br><img border='0' src='../experts/"&experts_num&"/photo.jpg'></td>"
            brief_ch="../experts/"&experts_num&"/brief.txt"
            brief=fs.getnexturl(brief_ch)
            response.write "<td valign='bottom'>"&brief
            response.write "&nbsp;&nbsp;<a href='../experts/"&experts_num&"/intro.htm' target=_blank><font color='#336699' size='2'>详细介绍</font></a>"&"<hr>"&"</td></tr>"
          end if
        loop
%>

</table>
</center>
</body>

</html>
