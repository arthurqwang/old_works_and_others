<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/cfmexp.inc"-->
<%
dim specialstr
specialstr=""
'if isexp=0 and request.cookies("adminok")="" then specialstr=" and specialzone=0"	  
%>
<%

   dim AnnounceID,anID
   dim RootID
   dim BoardID
   dim ID
   BoardID=Request("boardID")
   ID=cint(Request("rootID"))
   Response.cookies("newindex")=BoardID
   Response.cookies("indexname")=ID
   AnnounceID=Cstr(Request("ID"))
   anID=request("ID")
   RootID=request("RootID")
   dim rs
   dim sql
   set rs=server.createobject("adodb.recordset")
   dim rsBoard
   dim boardname
   dim boardsql
   dim sign
   dim rsUserSign
   dim signsql
   dim boardfoot
   dim relayer
   dim syssayface
   dim sysspace
   on error resume next
   set rsBoard=server.createobject("adodb.recordset")
   boardsql="select * from board where boardID="&BoardID
   rsboard.open boardsql,conn,1,1
   boardname=rsboard("boardname")
   boardfoot=rsboard("boardad")
   syssayface=rsboard("sayface")
   sysspace=rsboard("space")
   session("boardtype")=rsboard("boardtype")
   session("boardID")=boardid  
   sql="update bbs1 set hits=hits+1 where announceID="&ID
   rs.open sql,conn,3,3
   sql="select * from bbs1 where AnnounceID="&ID&specialstr
   rs.open sql,conn,1,1   
%>
<html>

<head>
<meta NAME="GENERATOR" Content="lousi soft 1.0">
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title><%=rs("topic")%></title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body bgcolor='<%=rsboard("bgcolor")%>' background='<%=rsboard("background")%>' alink='<%=rsboard("link")%>' link='<%=rsboard("link")%>' vlink='<%=rsboard("vlink")%>'>
<center>
<%
if isexp=1 then 
  response.write "<img src='images/light.gif' border='0'><font size=2 color=#666666>您现在处于[专家/嘉宾深入讨论区]，请注意保密。您当前的身份是："&expertnm&"("&realnm&")。有标记<img src='images/expert.gif' border=0>的部分为深入讨论内容。&nbsp;</font>"
  response.write "&nbsp;&nbsp;<a href=exitexpert.asp><img src='images/exit.gif' border=0><font size=2 color=#666666>退出</font></a><a href=exppwchg.asp target='_blank'>&nbsp;&nbsp;<img src='images/key.gif' border=0><font size=2 color=#666666>修改密码</font></a>"
end if
%>
</center>
<font size='<%=rsboard("fontsize")%>' color='<%=rsboard("fontcolor")%>'>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<% 
   dim rsfollow
   dim selstr
   selstr=""

   set rsfollow=server.createobject("adodb.recordset")
   sql="select AnnounceID,boardID from bbs1 where boardID="+boardID+" and parentID="+ID+" and status<>4 ORDER BY announceID desc "
   rsfollow.open sql,conn,1,1

   if not  rsfollow.eof then  '有回帖
   response.write "<p><center><font size='4'>关联标题</font></center><br>"
   do while not rsfollow.EOF 
	       	   if selstr="" then
		          selStr=selStr+cstr(rsfollow("announceid"))
		       else
		         selStr=selStr+","+cstr(rsfollow("announceid"))
		       end if
	   rsfollow.MoveNext 
   loop

	  if selStr<>"" then
          selstr="("+selstr+")"
          sql="select * from bbs1 where display=1"&specialstr&" and (rootID in "&selStr& " ) ORDER BY rootID desc,orders "
      else
          sql="select * from bbs1 where display=1"&specialstr&" ORDER BY rootID desc,orders "

      end if
     end if
	 rsfollow.Close
     rsfollow.open sql,conn,1,1
	 showlist()
	 sub showlist()
       on error resume next 
       dim outtext
       dim bytestr
       response.write  "<ul>"
       dim layer,first
       layer=relayer
	   first=true
       do while not (rsfollow.eof or err.number<>0)

          do while layer<> rsfollow("layer")
             if rsfollow("layer")> layer then
                outtext=outtext & "<ul>"
                layer=layer+1
             else 
                outtext=outtext &  "</ul>" & chr(13) & chr(10)
                layer=layer-1  
             end if
          loop

          outtext=outtext &  "<li>"
		  if rsfollow("specialzone")=1 then outtext=outtext&"<img src='images/expert.gif' border=0>"
		  if syssayface=1 and rsfollow("Expression")<>".gif" and rsfollow("Expression")<>"" then
          outtext=outtext & "<img src=images/"&rsfollow("Expression")&">"
		  end if

          outtext=outtext &  "<a href='ShowAnnounce.asp?boardID="+boardID+"&RootID="&cstr(rsfollow("RootID"))&"&ID="&Cstr(rsfollow("announceID"))&"'>"   		         

	      if trim(rsfollow("announceID"))=trim(anID) then outtext=outtext&"<img src='images/here.gif' border=0 title='当前标题'>"        
          if pwsonchsys then
             outtext=outtext & htmlencode(rsfollow("Topic"))
          else
             outtext=outtext & Server.HTMLEncode(rsfollow("Topic"))
          end if
          outtext=outtext&"</a>"
		  if instr(rsfollow("append"),"<img src=")>0 then
            outtext=outtext & "[图]"
			elseif instr(rsfollow("append"),"<a href=")>0 then
                 outtext=outtext & "[网址]"
		  end if

          '是否是新帖
		  'dim t
		  't=rsfollow("announceID")
		  't="<SCRIPT language='JavaScript'>IsNew("& t & ")</SCRIPT>"
		  'outtext=outtext & t
          'if trim(rsfollow("DateAndTime"))<>"" and 'isdate(rsfollow("DateAndTime")) then
           '  if cbool(cdate(rsfollow("DateAndTime"))>(date()-1))=true then
            '    outtext=outtext &  "<img 'src='images/new.gif'>"+chr(13)+chr(10)
             'end if
          'end if
          
'计算文章长度
		  bytestr="("+cstr(rsfollow("length"))
          if not WINNT_CHINESE then
             if rsfollow("Length")-1=1 then
                 bytestr=bytestr+" Byte)"
	          else
	             bytestr=bytestr+" Bytes)"
      	     end if
          else 
		     if rsfollow("Length")>1024 then
                 bytestr="("+ cstr(rsfollow("length")\1024)+"K)"
	          else
	             bytestr="("+ cstr(rsfollow("length"))+"字)"
      	     end if
           end if
 
 if rsfollow("Length")=0 then
	     bytestr=" (无内容)"
 end if	



       dim display_username,isexpert,expertemail
        isexpert=0

        display_username=rsfollow("username")

        set rsexp=server.createobject("adodb.recordset")
        sqlexp="select * from experts where expertnm='"&display_username&"'"
        rsexp.open sqlexp,conn,1,1
        if not rsexp.EOF then
          display_username=rsexp("realnm")
          expertemail=rsexp("email")
          isexpert=1
        end if
        rsexp.Close


		if pwsonchsys then
           if Trim((rsfollow("UserEmail")))="" then
             outtext=outtext & "(" & htmlencode(display_username)
           else
             outtext=outtext & "(" & "<a href=mailto:" & rsfollow("UserEmail") & ">" & htmlencode(display_username) & "</a>" & "<img src=images/mailto.gif>"
           end if
        else
           if Trim((rsfollow("UserEmail")))="" then
             outtext=outtext & "(" & Server.HTMLEncode(display_username) 
           else
             outtext=outtext & "(" & "<a href=mailto:" & rsfollow("UserEmail") & ">" & Server.HTMLEncode(display_username) & "</a>" & "<img src=images/mailto.gif>"
           end if
        end if
  
        if isexpert=1 then
           outtext=outtext & "<a href=mailto:" & expertemail & ">" & "<img src=images/explogo.gif border=0 title='专家/嘉宾，点击发邮件'></a>" 
        end if

          
		  outtext=outtext & ")<font color='#666666'>"&rsfollow("DateAndTime")&"</font>["+"<font color=#ff6666>"&rsfollow("Hits")&"</font>] "+bytestr
         
          rsfollow.movenext
          response.write outtext
          outtext=""

       loop


       
	   if layer<>0 then 
          dim i 
          for i=relayer to layer
              outtext=outtext & "</ul>"
          next 
       end if
       outtext=outtext & "</ul>"
       response.write outtext
	   rsfollow.close
	   
    end sub
%>
</body>
</html>
