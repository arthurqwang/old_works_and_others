<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������������ݵ��޸�</title>
</head>
<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<%

if request.cookies("CanEdit")="" then
  'response.redirect "config.asp"
   response.write "�Ƿ�����ҳ�棡"
end if

   dim sql,rs
   dim action
   dim Topic
   dim body
   dim announceID
   on error resume next
   action=request("action")
   announceID=request("announceID")
   Topic=trim(request("title"))
   body=rtrim(request("body"))
   boardID=request("boardID")
   dim Msg
   Msg=""
   if Topic="" then Msg=Msg+"���ⲻ��Ϊ�գ�"
   if strLength(body)>ANNOUNCE_MAXBYTE then
   Msg=Msg+"<Br>"+"�������ݲ��ô���" & CSTR(ANNOUNCE_MAXBYTE/1024) & "KB"
   end if
if Msg="" then
   dim tmp
   tmp=""
if action="manage" then tmp="������"
if action="author" then tmp="����"
 body=body & chr(13) & chr(10) & "������" & tmp & "��" & now &"�޸Ĺ�" 
 set rs=server.createobject("adodb.recordset")
sql="select * from bbs1 where AnnounceID="+Announceid+""
rs.open sql,conn,3,3
    if (not rs.eof) then
       if Topic<>"" then rs("Topic")=Topic
	   rs("Body")=body
	   rs("length")=strLength(body)
	   rs.update
       response.write "�޸ĳɹ���"
	   'response.redirect "list.asp?BoardID="& boardID
     else 
	   reponse.write "����������!"
    end if
rs.close
else
response.write Msg
end if
%>
</body>
</html>