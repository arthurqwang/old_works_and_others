<%
if request.cookies("adminok")="" then
  response.redirect "login.asp"
end if
%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<% 
    dim action,id,parentid
	action=Request("action")
    id=Request("AnnounceID")
    parentid=request("parentid")
'response.write action&id&"/"&parentid
    
    '置顶
    'if action="settop" then
    
    'set rs=server.createobject("adodb.recordset")
    'sql="select max(topseq) from bbs1"
    'rs.open sql,conn,1,1
    'num=cstr(rs("topseq"))
	  
    'sql="UPDATE bbs1 SET topseq=25 WHERE RootID="&id&"" 
	'conn.execute sql
	'end if
    



    '1-显示 其它-不显示

    if action="display" then
    sql="UPDATE bbs1 SET display=1,specialzone=0 WHERE ANnounceID="&id&"" 
	conn.execute sql
	end if

    if action="open" then
    sql="UPDATE bbs1 SET display=1, specialzone=0 WHERE ANnounceID="&id&"" 
	conn.execute sql
	end if

    if action="deep" then
    sql="UPDATE bbs1 SET display=1,specialzone=1 WHERE ANnounceID="&id&"" 
	conn.execute sql
	end if

    if action="upgrade" then
    sql="UPDATE bbs1 SET ParentID=0,layer=1,RootID=AnnounceID WHERE ANnounceID="&id&"" 
	conn.execute sql
    end if

'    if action="merge" then
'    sql="update bbs1 set ParentID="&parentid&", RootID="&parentid&",layer=2 where AnnounceID="&id
'	conn.execute sql
'    sql="update bbs1 set LastReplyID="&id&",child=child+1 where AnnounceID="&parentid
'	conn.execute sql
'    end if

	


	 '0-正常 1-精华 2-置顶 3-投票 4-准备删除
	
	if action="best" then
    sql="UPDATE bbs1 SET status=1 WHERE ANnounceID="&id&"" 
	conn.execute sql
	end if

	'if action="settop" then
    'sql="UPDATE bbs1 SET status=2 WHERE ANnounceID="&id&"" 
	'conn.execute sql
	'end if
	
	if action="vote" then
	sql="UPDATE bbs1 SET status=3 WHERE ANnounceID="&id&"" 
	conn.execute sql
	end if

    if action="nomal" then
	sql="UPDATE bbs1 SET status=0 WHERE ANnounceID="&id&""  
	conn.execute sql
	end if
	
	if action="delete" then
	sql="DELETE FROM bbs1 WHERE AnnounceID="&Request.QueryString("AnnounceID")&""
	'sql="UPDATE bbs1 SET status=4 WHERE ANnounceID="&id&""
     conn.execute sql
    end if

	if action="" or isnull(action) or action="finaldel" then
	sql="DELETE FROM bbs1 WHERE AnnounceID="&Request.QueryString("AnnounceID")&""
	conn.execute sql
	end if

	'set rs=server.createobject("adodb.recordset")
	'sql="DELETE FROM bbs1 WHERE AnnounceID="&Request.QueryString("AnnounceID")&""
	'Set rs = conn.Execute( sql )
     if err.number<>0 then 
         response.write "数据库操作失败，请以后再试"&err.Description
		 err.clear
     else
	     response.write "操作成功，2秒钟后返回管理页面"
     end if
%>

<% 
Sub delaySecond(DelaySeconds) 
SecCount = 0 
Sec2 = 0
While SecCount<DelaySeconds + 1 
Sec1 = Second(Time())
If Sec1 <> Sec2 Then 
Sec2 = Second(Time()) 
SecCount = SecCount + 1 
End If
Wend 
End Sub
%> 
<% delaySecond(2) %>

<% Response.Redirect ("emanage.asp?boardID="&session("boardID") ) %> 