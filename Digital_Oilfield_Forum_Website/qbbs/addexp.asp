<%@ LANGUAGE="VBSCRIPT" %>

<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<%
if request.cookies("adminok")="" then
  response.redirect "firstpg.asp"
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>增加专家/嘉宾记录</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;增加专家/嘉宾记录</h3></p>

<% 
        on error resume next
        dim sql,cmdTemp,msg,userexist,dbnm
		dim InsertCursor
		dim rs,dataconn
        realnm=request("realnm")
        unitnm=request("unitnm")
        expertnm=request("expertnm")
        expertpw=request("expertpw")
        email=request("email")
    	folder=request("folder")
		active=request("active")
        tel=request("tel")
        memo=request("memo")
        userexist=0
        dbnm=""
        set rs=server.createobject("adodb.recordset")
        sql="select * from experts where ucase(expertnm)='"&ucase(expertnm)&"'"
        rs.open sql,conn,1,1
        if not rs.eof then dbnm=rs("expertnm")
 	    if UCase(expertnm)=UCase(dbnm) and dbnm<>"" then userexist=1
        rs.Close

        dbnm=""
        set rs=server.createobject("adodb.recordset")
        sql="select * from user where ucase(UserName)='"&ucase(expertnm)&"'"
        rs.open sql,conn,1,1
        if not rs.eof then dbnm=rs("UserName")
 	    if UCase(expertnm)=UCase(dbnm) and dbnm<>"" then userexist=1
        rs.Close      
        
     if userexist=0 then
      if realnm<>"" and expertnm<>"" and expertpw<>"" and unitnm<>"" and email<>"" and active>=0 then  
        msg="增加记录成功!"
'加入到专家/嘉宾表中
        Set DataConn = Server.CreateObject("ADODB.Connection")
		dataconn.open connstr
        Set cmdTemp = Server.CreateObject("ADODB.Command")
		Set InsertCursor = Server.CreateObject("ADODB.Recordset")
		cmdTemp.CommandText = "SELECT * FROM experts"
		cmdTemp.CommandType = 1
		Set cmdTemp.ActiveConnection = dataConn
		InsertCursor.Open cmdTemp, , 1, 3
        InsertCursor.AddNew
		InsertCursor("realnm") = realnm
		InsertCursor("unitnm") = unitnm
		InsertCursor("expertnm") = expertnm
		InsertCursor("expertpw") = expertpw
		InsertCursor("email") = email
    	InsertCursor("folder")=folder
		InsertCursor("active") = active
		InsertCursor("tel") = tel
		InsertCursor("memo") = memo        
		InsertCursor.Update
        if err.number > 0 then 
		   err.clear
		   FoundError=true
		   ErrMsg="数据库操作失败，请以后再试"&err.Description
           msg="操作失败。"
		end if
        InsertCursor.close
		dataconn.close

'加入普通用户表中
        Set DataConn = Server.CreateObject("ADODB.Connection")
		dataconn.open connstr
        Set cmdTemp = Server.CreateObject("ADODB.Command")
		Set InsertCursor = Server.CreateObject("ADODB.Recordset")
		cmdTemp.CommandText = "SELECT * FROM user"
		cmdTemp.CommandType = 1
		Set cmdTemp.ActiveConnection = dataConn
		InsertCursor.Open cmdTemp, , 1, 3
        InsertCursor.AddNew
		InsertCursor("UserName") = expertnm
		InsertCursor("UserPassword") = expertpw
		InsertCursor("UserEmail") = email
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
        response.redirect "expmng.asp"
       else
        response.write "<script language='javascript'>window.open ('alert6.htm','警告', 'height=100, width=450, top=100, left=100,location=no')"
        response.write chr(13)&"location.reload('expmng.asp')"
        response.write chr(13)&"</script>"
       end if
      else
        response.write "<script language='javascript'>window.open ('alert7.htm','警告', 'height=100, width=450, top=100, left=100,location=no')"
        response.write chr(13)&"location.reload('expmng.asp')"
        response.write chr(13)&"</script>"
      end if
%>
<br><br>
</body>
</html>