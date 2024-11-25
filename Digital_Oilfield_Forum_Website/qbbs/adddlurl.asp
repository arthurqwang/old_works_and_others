<%@ LANGUAGE="VBSCRIPT" %>

<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>管理资料下载中心</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;资料下载中心管理</h3></p>

<% 
        on error resume next
        dim cmdTemp,msg
		dim InsertCursor
		dim dataconn
        topic=request("topic")
        shorttopic=request("shorttopic")
        author=request("author")
    	explain=request("explain")
		size=request("size")
        url= request("url")
		priority=request("priority")
		format=request("format")
		needpass=request("needpass")
		important=request("important")
		folderornot=request("folderornot")
        firstdisplay=request("firstdisplay")
        newornot=request("newornot")
        specialzone=request("specialzone")
        
'response.write topic&url&needpass&important&shorttopic
      if topic<>"" and url<>"" then  
        msg="增加记录成功!<br>审查通过后将列出，请耐心等待。<br>多谢您的支持与合作！"
        Set DataConn = Server.CreateObject("ADODB.Connection")
		dataconn.open connstr
        Set cmdTemp = Server.CreateObject("ADODB.Command")
		Set InsertCursor = Server.CreateObject("ADODB.Recordset")
		cmdTemp.CommandText = "SELECT * FROM dllist"
		cmdTemp.CommandType = 1
		Set cmdTemp.ActiveConnection = dataConn
		InsertCursor.Open cmdTemp, , 1, 3
        InsertCursor.AddNew
		InsertCursor("topic") = topic
		InsertCursor("shorttopic") = shorttopic
		InsertCursor("author") = author
    	InsertCursor("explain")=explain
		InsertCursor("size") = size
        InsertCursor("url") = url
		InsertCursor("priority") = priority
		InsertCursor("format") = format
		InsertCursor("needpass") = needpass
		InsertCursor("important") = important
		InsertCursor("folderornot") = folderornot
        InsertCursor("newornot") = newornot
        InsertCursor("firstdisplay") = firstdisplay
        InsertCursor("specialzone") = specialzone
        InsertCursor("display") = 0
		InsertCursor.Update
        if err.number > 0 then 
		   err.clear
		   FoundError=true
		   ErrMsg="数据库操作失败，请以后再试"&err.Description
           msg="操作失败。"
		end if
        InsertCursor.close
		dataconn.close
        response.write msg
       else
        response.write "操作失败。文档标题和文档地址不能为空。"
       end if
%>
<br><br>
</body>
</html>