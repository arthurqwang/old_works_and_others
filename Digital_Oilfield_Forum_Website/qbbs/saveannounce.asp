<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit
Response.Cookies("userinfo")("UserName")=trim(Request.Form("username"))
Response.Cookies("userinfo")("Password")=trim(Request.Form("passwd"))
Response.Cookies("userinfo")("Useremail")=trim(Request.Form("email"))
Response.Cookies("userinfo").Expires = now() + 7
%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/cfmexp.inc"-->
<% 
dim announceid
dim UserName
dim userPassword
dim useremail
dim Topic
dim body
dim FoundError
dim ErrMsg
dim dateTimeStr
dim addAll
dim newUser
dim UserID
dim ip
dim Expression
dim boardID
dim urltitle
dim urllink
dim midi
dim img
dim point
dim verifycode1
dim verifycode2
verifycode1=0
verifycode2=0
%>



<%	  
'addall=request("chkAddAll")
   IP=Request.ServerVariables("REMOTE_ADDR") 
   Expression=Request.Form("Expression")&".gif"
   if Expression=".gif" then Expression=""
   UserName=trim(request("username"))
   UserPassWord=request("passwd")
   verifycode1=request("verifycode1")+0.0
   verifycode2=request("verifycode2")+0.0
   UserEmail=request("email")
   Topic=trim(request("subject"))
   Body=request("body")
   boardID=request("boardID")
   urltitle=request("url_title")
   urllink=request("url")
   midi=request("midi")
   img=request("img")
   if Expression=".gif" then Expression=""

dim result
SetAppend urltitle,urllink,midi,img,result
FoundError=false
if UserName="" or strLength(UserName)>50 then
   ErrMsg="����������(���Ȳ��ܴ���50)"
   foundError=True
elseif Trim(UserPassWord)="" or strLength(UserPassWord)>10 then
   ErrMsg=ErrMsg+"<Br>"+"����������(���Ȳ��ܴ���10)"
   foundError=True
end if
if Topic="" then
   FoundError=True
   if Len(ErrMsg)=0 then
      ErrMsg="���ⲻӦΪ��"
   else
      ErrMsg=ErrMsg+"<Br>"+"���ⲻӦΪ��"
   end if
elseif strLength(Topic)>255 then
   FoundError=True
   if strLength(ErrMsg)=0 then
      ErrMsg="���ⳤ�Ȳ��ܳ���255"
   else
      ErrMsg=ErrMsg+"<Br>"+"���ⳤ�Ȳ��ܳ���255"
   end if
end if
if strLength(body)>ANNOUNCE_MAXBYTE then
   ErrMsg=ErrMsg+"<Br>"+"�������ݲ��ô���" & CSTR(ANNOUNCE_MAXBYTE/1024) & "KB"
   foundError=true
end if

if verifycode2 <> verifycode1 /17 - 437 then
   ErrMsg="��֤�����"
   foundError=true
end if

if FoundError=true then
   showAnnounce(ErrMsg)
else
   dim sql
   dim rs
   dim FoundUser
   set rs=server.createobject("adodb.recordset")
   sql="select * from User where ucase(username)='"&ucase(username)&"'"
   rs.open sql,conn,1,3
   if not rs.EOF then
        FoundUser=True
	    UserID=rs("UserID")
   end if
	
	  if not FoundUser then
         SaveNewUser username,userpassword,useremail
	     NewUser=true
         if founderror=true then showAnnounce(ErrMsg)
         elseif UserPassword<>rs("UserPassword") then
           ErrMsg="�������벻��ȷ(���ܸ����ֱ�����ռ���ˣ��볢���ñ������)"
	       foundError=true
            showAnnounce(ErrMsg)
      else
         rs("article")=rs("article")+1
		 rs("point")=rs("point")+3    '������3
         rs.update
      end if
    rs.close
      if foundError=false then
        ' if Need_password=false then 
           session("UserName")=Trim(UserName)
           session("password")=UserPassword
        ' end if
         DateTimeStr=CSTR(NOW()+TIME_ADJUST/24)
	 'if addAll=false then
         dim rsBoard
         dim boardname
         dim boardsql
         set rsBoard=server.createobject("adodb.recordset")
         boardsql="select board.boardname,board.boardtype from board where boardID="&request("boardid")
         rsboard.open boardsql,conn,1,1
         boardname=rsboard("boardname")
         session("boardtype")=rsboard("boardtype")
		 session("boardname")=rsboard("boardname")
         rsboard.close
         
         dim cmdTemp
	     dim InsertCursor
         dim dataconn
         Set DataConn = Server.CreateObject("ADODB.Connection")
         dataconn.open connstr
         Set cmdTemp = Server.CreateObject("ADODB.Command")
	     Set InsertCursor = Server.CreateObject("ADODB.Recordset")
         cmdTemp.CommandText="SELECT *, UserName FROM bbs1 WHERE (UserName IS NULL)"
         cmdTemp.CommandType = 1
         Set cmdTemp.ActiveConnection = dataconn
  	     InsertCursor.Open cmdTemp, , 1, 3
	     InsertCursor.AddNew
		 InsertCursor("BoardID") = boardID
	     InsertCursor("ParentID") = 0
         InsertCursor("Child") = 0
	     InsertCursor("UserName") = UserName
	     InsertCursor("UserEmail") =UserEmail
	     InsertCursor("Topic") =Topic
	     InsertCursor("Body") =Body
	     InsertCursor("DateAndTime") =DateTimeStr
	     InsertCursor("hits") =0
	     InsertCursor("length")=strLength(body)
	     InsertCursor("rootID")=0
	     InsertCursor("layer")=1
	     InsertCursor("orders")=0
         InsertCursor("ip")=ip
         InsertCursor("Expression")=Expression
		 InsertCursor("append")=result
         InsertCursor("display")=0
         if isexp=1 or Username="Arthur" or Username="������" or Username="̳��" or Username="������Arthur" or Username="̳��Arthur" or Username="Art" or Username="��Ȩ" or Username="Wangquan" or Username="Arthur Wang" or Username="Marrist" then
           InsertCursor("display")=1
         end if
         if isexp=1 then
           InsertCursor("specialzone")=1
         end if
		 InsertCursor("LastReplyID")=0
         'InsertCursor("topseq")=0
	     InsertCursor.Update
         announceid=InsertCursor("AnnounceID")
         InsertCursor("RootID")= announceid
		 InsertCursor("LastReplyID")=announceid
	     InsertCursor.Update
  if err.number<>0 then
	       err.clear
		   ErrMsg="���ݿ����ʧ�ܣ����Ժ�����"&err.Description 
  	       showAnnounce(ErrMsg)
  else
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<meta http-equiv=refresh content="10;URL=showannounce.asp?boardid=<%=boardid%>&RootID=<%=announceid%>&ID=<%=announceid%>">
<title>�����ύ�ɹ���</title>
<link rel="stylesheet" type="text/css" href="style.css"></head>
<body bgcolor='#FFFFFF' alink='#330099' link='#330099' vlink='#666699'>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<table cellpadding=3 cellspacing=1 align=center class=tableborder1>
<tr align=center><th width="100%">�����ύ�ɹ�����ȴ����󹫿�������</td>
</tr><tr><td width="100%" class=tablebody1>
��ҳ�潫��10����Զ�Ԥ��������������ӣ�<b>������ѡ�����²�����</b><br><ul>
<li><a href="index.html">������̳��ҳ</a></li>
<li><a href="announce.asp?boardid=<%=boardid%>">����������</a></li>
</ul></td></tr></table>
</body></html>

<%
	    InsertCursor.close
		dataconn.close
    end if	  
  end if
end if


function showAnnounce(ErrMsg)
      on error resume next
	  %>
<html><head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<meta http-equiv=refresh content="3;URL=announce.asp?boardid=<%=boardid%>">
<title>��������ˣ�</title>
<link rel="stylesheet" type="text/css" href="style.css"></head>
<body bgcolor='#FFFFFF'  alink='#330099' link='#330099' vlink='#666699'>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<%
      response.write "<font color='red'><strong><Big>�������:</big></strong></font><BR><font color='#0000FF'>"+ErrMsg+"</font><BR>"+chr(13)+chr(10)
%>

</body></html>
<%
end function

function SaveNewUser(username,userpassword,email)
        on error resume next
        dim cmdTemp
		dim InsertCursor
		dim dataconn
        Set DataConn = Server.CreateObject("ADODB.Connection")
		dataconn.open connstr
        Set cmdTemp = Server.CreateObject("ADODB.Command")
		Set InsertCursor = Server.CreateObject("ADODB.Recordset")
		cmdTemp.CommandText = "SELECT *, UserName FROM User WHERE (UserName IS NULL)"
		cmdTemp.CommandType = 1
		Set cmdTemp.ActiveConnection = dataConn
		InsertCursor.Open cmdTemp, , 1, 3
        InsertCursor.AddNew
		InsertCursor("UserName") = UserName
		InsertCursor("UserPassword") = UserPassword
		InsertCursor("UserEmail") = UserEmail
		InsertCursor("WillOpen")="Yes"
		InsertCursor("article") = 1
        InsertCursor("disable") = 0
		InsertCursor.Update
        if not err.number<>0 then 
		   
		   UserID=insertcursor("UserID")
		else 
           err.clear
		   FoundError=true
		   ErrMsg="���ݿ����ʧ�ܣ����Ժ�����"&err.Description 
		end if
        InsertCursor.close
		dataconn.close
end function

function SetAppend(urltitle,urllink,midi,img,result)
'dim result
result=""
if urltitle<>"" and urllink<>"" and ucase(urllink)<>"HTTP://" then 
result=result & chr(13) &chr(10) & "<p><a href='" & urllink &"' target=_blank>" & urltitle &"</a></p>"
end if

if midi<>"" and instr(2,lcase(midi),".mid")>0 then
result=result & chr(13) & chr(10)& "<EMBED name=media align=baseline height=31 width=71 autostart=true loop=true border=0 src='" + midi + "'></embed><br>"
end if

if (img<>"" and instr(ucase(img),"HTTP://")>0 and (instr(ucase(img),".GIF")>0 or instr(ucase(img),".JPG")>0 or instr(ucase(img),".JPEG")>0)) then

     if instr(img,chr(32))>0 or instr(img,chr(13))>0 then
     '��������ÿո���з������Ķ��ͼ��
     'replace(img,chr(13)&chr(10),chr(32))
     dim imgArray
	 dim i
	 imgArray=split(img,chr(32))
           for i=0 to ubound(imgArray)
	       result=result&chr(13) &chr(10)&"<img src='" &imgArray(i)& "'>"
           next
	 else
        result=result&chr(13) &chr(10)&"<img src='" &img& "'>"
     end if
	 
end if

SetAppend=result
end function
%>

