<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<%
   dim sql,rs
   dim mastername
   dim masterpass
   dim ok
   ok=false
   dim action
   'on error resume next
   action=request("action")
   if action="" then action="changeset"
'   if not isEmpty(request("lstBoard")) then
'      boardID=clng(request("lstBoard"))
'   end if
   boardID=1
   if iis3onchsys then
      masterName=trim(HTMLCharacter(trim(request("username"))))
      masterpass=HTMLCharacter(cstr(request("password")))
   else
      masterName=trim(request("username"))
      masterpass=cstr(request("password"))
   end if
set rs=server.createobject("adodb.recordset")
sql="select * from board where boardid="+cstr(boardid)+""
sql=sql&" and boardmaster='"&masterName&"'"
rs.open sql,conn,1,1
  if not(rs.bof and rs.eof) then
     if masterpass=rs("masterpwd") and masterName=rs("boardmaster") then 
	    response.cookies("adminok")=true
	  session("masterlogin")="true"
      session("manageboard")=boardID
    if action="content" then response.redirect "eManage.asp" '管理论坛内容
	if action="boardset" then response.redirect "boardset.asp" '管理论坛设置
	if action="userdata" then response.redirect "userdata.asp" '管理论坛用户
    if action="download" then response.redirect "dlmng.asp" '管理资料下载中心
    if action="expert" then response.redirect "expmng.asp" '管理专家/嘉宾
	if action="chgmanage" then response.redirect "chgmanager.asp?method=modify&boardid="+cstr(BoardID) '更改管理帐号
    if action="sendmsg" then response.redirect "sendmsgp.asp" '通过email给用户和专家/嘉宾发消息
	
    
     

   else
      response.write "<link rel='stylesheet' type='text/css' href='lun.css'>"
      response.write "<body bgcolor='#ffffef'>" 
      response.write "Sorry,请输入正确的主持人名字和密码"
   end if
end if
   rs.close
%>
