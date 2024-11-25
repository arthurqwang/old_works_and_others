<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="newconn.asp"-->
<%
dim expertnm,catalog
catalog=request("catalog")
expertnm=trim(request.cookies("expertnm"))
response.cookies("expertnm")=""
response.cookies("expertpw")=""
response.write "<script language='javascript'>window.open ('alert2.htm','警告', 'height=100, width=450, top=100, left=100,location=no')"
if request("to")<>"" then 
  response.write chr(13)&"location.reload('"&request("to")
  if catalog<>"" then response.write  "&amp;catalog="&catalog
  response.write "')"
else
  response.write chr(13)&"self.close()"
end if
response.write "</script>"
'response.redirect request("to")&" target='_blank'"

'记载下线时间
    dim rs
    set rs=server.createobject("adodb.recordset")
    sql="select * from experts where expertnm='"&expertnm&"'"
    rs.open sql,conn,3,3
    if (not rs.eof) then
       rs("loginrec")=rs("loginrec")&"[OUT:"&Date()&" "&Time()&"]"
	   rs.update
    end if
    rs.close

%>