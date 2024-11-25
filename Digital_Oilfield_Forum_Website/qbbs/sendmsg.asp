<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="newconn.asp"-->
<%
if request.cookies("adminok")="" then
  response.redirect "firstpg.asp"
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>内部消息发送</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><table width="800"><tr><td align="center">
<a href="http://www.digitaloilfield.org.cn" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p>
</td></tr><tr><td align="left">
<%
    dim Cnn,rss,subject,body,bcc,k
    k=1
    dim sql,action,expertnm,msg,msgtpc,msgtpc_r,preface,toexpert,tousualuser,attach_articles,month_num,attach_downloads,dlnum

   dim rs
   dim boardname
   dim itype 
   dim topic
   dim UserName
   dim boardID
   dim boardtype
   dim iroot
   dim t
   dim bytestr
   
   boardID=1

 
    msgtpc_r=request("msgtpc")
    preface=request("preface")
    toexpert=request("toexpert")
    tousualuser=request("tousualuser")
    attach_articles=request("attach_articles")
    month_num=request("month_num")
    attach_downloads=request("attach_downloads")
    dlnum=request("dlnum")

    response.write "<font size=3>尊敬的"
    if toexpert="on" then response.write "各位专家/嘉宾"
    if toexpert="on" and tousualuser="on" then response.write "、"
    if tousualuser="on" then response.write "各位坛友"
    response.write "：<br><br>&nbsp;&nbsp;&nbsp;&nbsp;您好！大庆油田有限责任公司主办的 [数字油田论坛] 欢迎您！感谢您的支持！<br><br>&nbsp;&nbsp;&nbsp;&nbsp;"
    do while k<=len(preface)
         if mid(preface,k,1)=chr(13) then 
           response.write "&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;"
           k=k+1
         else
           response.write mid(preface,k,1) 
         end if
         k=k+1
    loop
    response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;祝您工作顺利！<br><br>"
    response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;数字油田论坛 <a href=http://www.digitaloilfield.org.cn>http://www.digitaloilfield.org.cn</a>"
    response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;大庆油田有限责任公司 <a href=http://www.daqing.com>http://www.daqing.com</a>"
    response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;电话：0459-5986841"
    response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;"&date()
    response.write "<br><br><font color=#336699>* 此邮件由本论坛系统程序批量自动发送，由于网络问题您可能不止一次收到此邮件，请谅解。如有疑问请联系论坛主持人Arthur(<a href=mailto:wangq@daqing.com>wangq@daqing.com</a>) 或 论坛助理Marrist(<a href=mailto:zhangwl@daqing.com>zhangwl@daqing.com</a>)</font>"

'*********************** 处理重点文章 ******************************************
    if attach_articles="on" then

        response.write "<br><br><table width=800 border=0><tr><td bgcolor=#ffeedd><font size=3>附件1：论坛近期重要文章 (近"&month_num&"月内)</font></td><td bgcolor=#ffeedd align=right><font size=3>发布日期："&Date()&"</font></td></tr></table>"
        response.write "<table border=1 width=800><tr><td><br><table>"
        set rs=server.createobject("adodb.recordset")
        sql="select * from bbs1 where status=1 and display=1 and boardID=1 ORDER BY announceID desc "
       rs.open sql,conn,1,1
       if rs.eof and rs.bof then
         response.write "<center><big>没有相应的帖子:o(</big></center>"+chr(13)+chr(10)	
        else
         '------------------------------------------------------------------------
	     rs.movefirst

	     do while not rs.eof
        if int((datediff("m",rs("dateandtime"),Date())))<= int(month_num)  then
         response.write "<tr><td width=20 align=center valign=top><img src=images/noplus.gif border=0></td><td><font size=2>"
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
                  response.write " <a href='ShowAnnounce.asp?boardID="&cstr(rs("BoardID"))&"&RootID="&cstr(iroot)&"&ID="&Cstr(rs("AnnounceID"))&"' target='_blank'>"
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
     response.write "<font color=#336699>"    
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



       dim display_username,isexpert,expertemail
        isexpert=0

        display_username=rs("username")

        set rsexp=server.createobject("adodb.recordset")
        sqlexp="select * from experts where expertnm='"&display_username&"'"
        rsexp.open sqlexp,conn,1,1
        if not rsexp.EOF then
          display_username=rsexp("realnm")
          expertemail=rsexp("email")
          isexpert=1
        end if
        rsexp.Close

         
			      response.write t&"(" 

                  if trim(rs("useremail"))<>"" then response.write "<a href=mailto:" & rs("UserEmail") & ">"
                  if pwsonchsys then
                     showBody display_username
                  else
                     response.write Server.HTMLEncode(display_username) 
                  end if
                  if trim(rs("useremail"))<>"" then response.write "</a>" & "<img src=images/mailto.gif>"

                  if isexpert=1 then
                    response.write "<a href=mailto:" & expertemail & ">" & "<img src=images/explogo.gif border=0 title='专家/嘉宾，点击发邮件'></a>" 
                  end if

                  response.write ") <i><font color='green'>"+ left(rs("dateAndTime"),instr(rs("dateandtime")," ")-1)+"</font></i> " + chr(13)+chr(10)
		        end if
                response.write "</font></td></tr><tr><td></td><td><font size=2><font color=#cc6600>[内容]</font>  "&left(rs("body"),300)&"...</font><br><br></td></tr>"
              end if
	          rs.movenext
	        loop
        
      end if
      rs.close
      response.write "</table></td></tr></table>"
    end if




'*********************** 下载资料处理 ******************************************
    if attach_downloads="on" then

      response.write "<br><br><table width=800 border=0><tr><td bgcolor=#eeffdd><font size=3>附件2：论坛近期加载资料</font></td><td bgcolor=#eeffdd align=right><font size=3>发布日期："&Date()&"</font></td></tr></table>"
      response.write "<table border=1 width=800><tr><td><br><table>"

'    dim rs,sql,i
    i=1
    set rs=server.createobject("adodb.recordset")
    sql="select * from dllist order by priority desc,seq desc"
    if isexp=0 then  sql="select * from dllist where specialzone=0 and display=1 order by priority desc,seq desc"
       rs.open sql,conn,1,1
 	 do while not rs.EOF and i<=int(dlnum)
       response.write "<tr><td width=20 align=center valign=top><img src=images/noplus.gif border=0></td><td>"
       if rs("specialzone")=1 then response.write "<img border='0' src='images/expert.gif'>"
       response.write "<font size=2>"
       if rs("folderornot")=1 then response.write "<img border='0' src='images/folder.gif' title='文件夹'>"
       response.write "<font color=#336699>"&rs("topic")&"</font>"
       if trim(rs("needpass"))<>"" then response.write "<img border='0' src='images/lock.gif' title='需要密码，请联系主持人或论坛助理。'>"
       if rs("author")<>"" then response.write "，"&rs("author")
       if rs("format")<>"" then response.write "，"&rs("format")
       if rs("size")<>"" then response.write "，"&rs("size")
       response.write "&nbsp;<a href='"
       response.write rs("url")&"' target='_blank'><font color='#336699'>"
       if rs("folderornot")>0 then
         response.write "[进入目录]</a>"
       else
         response.write "[下载/浏览]</a>"
       end if
       if rs("explain")<>"" then response.write "<br><font color=#cc6600>[说明]</font>  <font color='#666666'>"&rs("explain") 
       response.write "</font></font><br><br></td></tr>"
       rs.MoveNext
       i=i+1 
     loop
     rs.Close

      response.write "</table></td></tr></table>"

    end if



    response.write "</font></td></tr>"

    send_email   




function send_email()
      msgtpc=msgtpc_r
      response.write chr(13)&"<script language='javascript'>"&chr(13)
      response.write "var bcc = 'wangq@daqing.com;zhangwl@daqing.com';"&chr(13)
      response.write "var subject = '"&msgtpc&"';"&chr(13)
      response.write "var doc = 'mailto:wangq@daqing.com?bcc=' + bcc + '&subject=' + subject;"&chr(13)
      response.write "window.location = doc;"&chr(13)
      response.write "</SCRIPT>"
end function

%>
<tr><td align="center"><br><br>
<a href="http://www.digitaloilfield.org.cn" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p>
</td></tr>
</table></center>
</body>
</html>