<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��̳����</title>
</head>
<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<%
   dim sql,rs
   dim username
   dim password
   dim action
   dim mode
   dim announceID
   on error resume next
   action=request("action")
   boardID=request("boardID")
   announceID=request("announceID")
   mode=request("mode")
   username=trim(request("username"))
   password=trim(request("password"))
if action="manage" then  
'-----------------------------------------------------------

set rs=server.createobject("adodb.recordset")
sql="select * from board where boardid="+cstr(boardid)+""
sql=sql&" and boardmaster='"&username&"'"
rs.open sql,conn,1,1
  if not(rs.bof and rs.eof) then
     if password=rs("masterpwd") and username=rs("boardmaster") then 
	   '�����˹��������������Ѿ���¼��ȥ
	    response.cookies("CanEdit")=true
		 
           if mode=1 then 'showEdit action,AnnounceID '�������޸Ĵ���
		   '*******************************************************
dim tmp
tmp=""
if action="manage" then tmp="������"
if action="author" then tmp="����"
dim rss
set rss=server.createobject("adodb.recordset")
 sql="select Topic,Body from bbs1 where announceID="+cstr(AnnounceID)+""
 rss.open sql,conn,1,1
 if not(rss.eof) then
%>
<center>
<table border="0" align="center" bgcolor="#FFFFFF" cellspacing="0" cellpadding="5">
<tr bgcolor="#808040"><td><span class="heading"><%=tmp%>�༭����</span></td></tr>
<tr><form action="editEnd.asp" method="POST"><td>
����:<br><input type="text" name="title" size=100 value="<%=rss("Topic")%>"></td></tr>
<tr><td><input type="hidden" name="AnnounceID" value="<%=AnnounceID%>">
<input type="hidden" name="action" value="<%=action%>">
<input type="hidden" name="boardID" value="<%=boardID%>">
����:<br><textarea COLS=100 ROWS=30 name="body"><%=rss("body")%></textarea></td></tr>
<tr><td><input type="submit" value="ȷ��"></form></td></tr></table>
</center>

<%else
    response.write "�����޷��༭��"
  end if
                     rss.close
		   '*******************************************************
		   end if
		   err.clear
           if mode=2 then
		   sql="DELETE FROM bbs1 WHERE AnnounceID="&announceID&""
           conn.execute sql
		   response.write "�Ѿ�ɾ������"
		   end if

           if mode=0 then 
		   sql="UPDATE bbs1 SET status=1 WHERE AnnounceID="&announceID&"" 
	       conn.execute sql
		   response.write "�Ѿ���Ϊ����"
		   end if

		   if mode=3 then 
		   sql="select Topic,ip,username from bbs1 where AnnounceID="&announceID&""
           set rss=server.createobject("adodb.recordset")
		   set rss=conn.execute(sql)
		      if not rss.eof then
		       response.write rss("username") &"��IP��ַ:" & rss("ip") & "��������:" &rss("Topic")
               response.write "<br><a href='http://dheart.51.net/ip/index.php?searchip="+rss("ip")+"&search=%B2%E9%D1%AF'>"+"���IP��ַ����"+"</a>(<a href='http://www.dheart.net/' target='_blank'>Ƽ����</a>�ṩ)"
		      end if
            rss.close 
		   end if
     else
       response.write "Sorry,��������ȷ�����������ֺ�����"
     end if
  end if
rs.close
'-----------------------------------------------------------------

end if

if action="author" then  
set rs=server.createobject("adodb.recordset")
sql="select username,userpassword from user where username='" & username &"'"
rs.open sql,conn,1,1
  if not(rs.bof and rs.eof) then
     if password=rs("userpassword") then 
	   'ԭ�����޸ģ�����ԭ�����Ѿ���¼��ȥ
	    response.cookies("CanEdit")=true
		dim title,body,rsedit
         set rsedit=server.createobject("adodb.recordset")
sql="select announceID,Topic,Body from bbs1 where announceID=" +announceID + " and username='" &username &"'"
         rsedit.open sql,conn,1,1
          if not(rsedit.eof) then
		  body=rsedit("Body")
		  title=rsedit("Topic")
		  else
		  response.write "sorry,����Ȩ�޸ı�����"
		  response.end
          end if
		  rsedit.close
%>
<center>
<table border="0" align="center" bgcolor="#FFFFFF" cellspacing="0" cellpadding="5">
<tr bgcolor="#808040"><form action="editEnd.asp" method="POST">
<td><span class="heading">ԭ���߱༭����</span></td></tr>
<tr><td>����:<br><input type="text" name="title" size=100 value="<%=title%>"></td></tr>
<input type="hidden" name="AnnounceID" value="<%=AnnounceID%>">
<input type="hidden" name="action" value="<%=action%>">
<input type="hidden" name="boardID" value="<%=boardID%>">
<tr><td>����:<br><textarea COLS=100 ROWS=30 name="body"><%=body%></textarea><br>
<input type="submit" value="ȷ��"></form></td></tr></table>
</center>
<%
	  else 
       response.write "Sorry,��������ȷ�����ֺ�����!ֻ��ԭ���߲ſ��Ա༭����"
     end if
  end if
   rs.close
end if
%>
</body>
</html>