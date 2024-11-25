<%@ LANGUAGE="VBSCRIPT" %>
<%option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/chkstr.inc"-->
<!-- #include file="inc/cfmexp.inc"-->
<%
dim specialstr
specialstr=""
if isexp=0 then specialstr=" and specialzone=0"	  
%>
<HTML>
<HEAD><TITLE>你的查询结果-BBS帖子</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<BODY leftmargin="10" topmargin="20" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">

<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3>BBS 帖子检索结果</h3></p>
<form name="queryUser" method="POST" action="queryResult.asp" target="_blank">
<font size="2">关键词：</font><input type="text" name="keyword" size="17" value="<%= trim(request("keyword")) %>"><input class="buttonface" type="submit" value="检索" name="cmdTopic">
</form>

<%   
   dim sql,rs,num
   dim boardname
   dim itype 
   dim bID
   dim boardtype
   dim iroot
   dim t
   dim bytestr
   dim keyword
'response.write request("keyword")
   bID=1 '1就是数字油田论坛
'   itype=request("type")
'   if request("selBoard")<>"" then bID=request("selBoard")

   if iis3onchsys=true then
      keyword=HTMLCharacter(trim(request("keyword")))
   else
      keyword=trim(request("keyword"))
   end if
   sql="select Boardtype,Boardname from board where boardID="&cstr(bID)
   set rs=server.createobject("adodb.recordset")
   rs.open sql,conn,1,1
   if not (rs.bof and rs.eof) then
      boardtype=rs("Boardtype")
      boardname=rs("Boardname")
   end if
   rs.close
'   response.write "<font size='-1'><strong>〖"&boardname&"〗帖子检索</strong></font> "
'   response.write "  <a href='Announce.asp?boardID="&bid&"' target="+chr(34)+"BoardAnnounce"+chr(34)+">发表新帖</a> <a href='List.asp?boardID="&bid&"'>返回浏览</a> <br>"+chr(13)+chr(10)
   if (trim(keyword)="") OR BID=0 then 
	     response.write "<center><big>没有输入查询条件。:o(</big></center>"+chr(13)+chr(10)
   else
	   sql="select * from bbs1 where (((topic like '%"&checkStr(keyword)&"%') or (username like '%"&checkStr(keyword)&"%') or (body like '%"&checkStr(keyword)&"%')) and boardID="&cstr(bID)&") and display=1"&specialstr&" ORDER BY announceID desc "
	   rs.open sql,conn,1,1
       if rs.eof and rs.bof then
         response.write "<center>没有找到。</center>"+chr(13)+chr(10)	
        else
         '------------------------------------------------------------------------
         response.write " <center><FONT SIZE='-1'>查询结果，找到 "&cstr(rs.recordcount)&"个结果符合条件</font></center>"+chr(13)+chr(10)
	     response.write chr(13)+chr(10)
	     rs.movefirst
         num=1
         response.write "<table border=0>"
	     do while not rs.eof
         response.write "<tr><td width=20 align=left><font size=2 color=#666666>"&num&"</font></td><td><font size=2 color=#666666>"
         num=num+1
         if rs("specialzone")=1 then response.write "<img src='images/expert.gif' border=0>"
		    dim newimgstr
            newimgstr=""
            if trim(rs("dateandtime"))<>"" and isdate(rs("dateandtime")) then
		       if Need_Expresstion then
                    newimgstr="<img src='images/"&rs("Expression")&"' border=0>"+chr(13)+chr(10)
               end if
	    	   response.write newimgstr
			   iroot=rs("rootID")
			   if rs("rootID")=0 then iroot=rs("announceID")
			      rem response.write iroot
                  response.write " <a href='ShowAnnounce.asp?boardID="&cstr(rs("BoardID"))&"&RootID="&cstr(iroot)&"&ID="&Cstr(rs("AnnounceID"))&"' target='_blank'><font size=2 color=#666666>"
	  if rs("Length")=0 then
	     t=" (无内容)"
          else 
             t=" "
	  end if
	  if instr(rs("append"),"<img src=")>0 then
             t=t & "[图]"
			elseif instr(rs("append"),"<a href=")>0 then
             t=t & "[网址]"
		  end if
         
                  if pwsonchsys then
	                 showBody rs("Topic")
                  else
                     response.write Server.HTMLEncode(rs("Topic"))
                  end if
	 response.write "</font></a>"
	    if trim(rs("DateAndTime"))<>"" and isdate(rs("DateAndTime")) then
               if cbool(cdate(rs("DateAndTime"))>(date()-1))=true then
                response.write  "<img src='images/new.gif' border=0>"+chr(13)+chr(10)
         end if
      end if

	  '计算文章长度
		  bytestr="("+cstr(rs("length"))
          if not WINNT_CHINESE then
             if rs("Length")-1=1 then
                 bytestr=bytestr+" Byte)"
	          else
	             bytestr=bytestr+" Bytes)"
      	     end if
          else 
		     if rs("Length")>1024 then
                 bytestr="("+ cstr(rs("length")\1024)+"K)"
	          else
	             bytestr="("+ cstr(rs("length"))+"字)"
      	     end if
           end if
 
 if rs("Length")=0 then
	     bytestr=" (无内容)"
 end if	
         
			      response.write t+"<strong>" 
                  if pwsonchsys then
                     showBody rs("UserName")
                  else
                     response.write Server.HTMLEncode(rs("UserName")) 
                  end if
                  response.write " </strong><i>"+ rs("dateAndTime")+"</i> " +"[ID:"+cstr(rs("announceID"))+" 点击:"+cstr(rs("hits"))+"] " + bytestr + "(" + Cstr(rs("child"))+")"+chr(13)+chr(10)
		        end if
		        response.write "</font></td></tr>"
	            rs.movenext
	        loop
	     response.write "</table>"+chr(13)+chr(10)
      end if
      rs.close
   end if
   
%>

<p><!--#include file="FooterLogo.asp"--></p>
</center>
</body>
</html>
