<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<%
if request.cookies("adminok")="" then
  response.redirect "index.html"
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>管理论坛内容</title>
<link rel="stylesheet" type="text/css" href="lun.css">
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3>论坛内容管理</h3></p></center>
<center><h5>请点击相应操作链接。</h5></center>
<%

   dim sql,rs,rsBoard,BoardName,boardsql
   dim selStr
   dim mailStr1
   dim mailStr2
   dim boardmaster
   'on error resume next
   selStr="()"
    if session("masterlogin")="true" then
   boardID=session("manageboard")
   session("boardID")=boardID
   selStr="" 
   if not isempty(request("page")) then
      currentPage=cint(request("page"))
   else
      currentPage=1
   end if

 set rsBoard=server.createobject("adodb.recordset")
  boardsql="select * from board where boardID="+cstr(boardID)+""
 rsboard.open boardsql,conn,1,1
 if not rsboard.eof then
    boardname=rsboard("boardname")
	maxannounce=rsboard("postsinpage")
    session("boardtype")=rsboard("boardtype")
	session("boardname")=boardname
    

    boardmaster=rsboard("boardmaster")
    if trim(rsboard("masteremail"))<>"" then
      mailStr1="<a href='mailto:"+trim(rsboard("masteremail"))+"'>"
      mailStr2="</a>"
    else
      mailStr1=""
      mailStr2=""
    end if
   if boardID>0 then
    set rs=server.createobject("adodb.recordset")
    sql="select AnnounceID,boardID from bbs1 where boardID="+cstr(boardID)+" and parentID=0 ORDER BY LastReplyID desc "
       rs.open sql,conn,1,1
 if not  rs.eof then
     totalAnnounce=rs.recordcount
	 dim i
	 i=0
	 if currentPage=1 then

	 do while not rs.EOF 
	   if selstr="" then
		   selStr=selStr+cstr(rs("announceid"))
	   else
		   selStr=selStr+","+cstr(rs("announceid"))
	   end if

	   i=i+1
	   if i>=maxannounce then exit do
	   rs.MoveNext 
	 loop

	 else
	    if (currentPage-1)*maxannounce<totalAnnounce then
	       rs.move  (currentPage-1)*maxannounce
	       dim bookmark
	       bookmark=rs.bookmark
	       do while not rs.EOF 
	       	   if selstr="" then
		          selStr=selStr+cstr(rs("announceid"))
		       else
		         selStr=selStr+","+cstr(rs("announceid"))
		       end if
         	   i=i+1
	           if i>=maxannounce then exit do
	           rs.MoveNext 
	      loop

	    else
	        currentPage=1
	        do while not rs.EOF 
	        	   if selstr="" then
		             selStr=selStr+cstr(rs("announceid"))
		           else
		             selStr=selStr+","+cstr(rs("announceid"))
		           end if


         	   i=i+1
	           if i>=maxannounce then exit do
	           rs.MoveNext 
	      loop

	    end if
	 end if
	 dim n
     selstr="("+selstr+")"
  
   
	  
	 if selStr<>"()" then
          sql="select * from bbs1 where (rootID in "&selStr& " ) ORDER BY LastReplyID desc, rootID desc,orders"
     else
          sql="select * from bbs1 ORDER BY  LastReplyID desc, rootID desc,orders "

	 end if
	end if
         rs.Close
         
         rs.open sql,conn,1,1
         'showpage session("boardname"),boardmaster,totalannounce,boardid,mailstr1,mailstr2
         showlist()
         showpage session("boardname"),boardmaster,totalannounce,boardid,mailstr1,mailstr2
   else
       response.write "<p> 论坛："+session("boardtype")+"<br>主持人："+mailstr1+boardmaster+mailstr2+"<br>" 
       response.write " 本论坛无内容 "
  	   response.write "<p><a href='Announce.asp?boardID="+cstr(boardID)+"' target="+chr(34)+"BoardAnnounce"+chr(34)+">我要发言</a> <a href='emanage.asp?boardID="+cstr(boardID)+"'>刷新浏览</a> "
            
	end if
      rs.close 
	  

   sub showlist()
       on error resume next 
       dim outtext
       dim bytestr
       response.write  "<ul>"
       dim layer
	   dim strtmp
       layer=1
       do while not (rs.eof or err.number<>0)
          do while layer<> rs("layer")
             if rs("layer")> layer then
                outtext=outtext & "<ul>"
                layer=layer+1
             else 
                outtext=outtext &  "</ul>" & chr(13) & chr(10)
                layer=layer-1  
             end if
          loop
          outtext=outtext &  "<li>"
		  if Need_Expresstion then
          outtext=outtext & "<img src=images/"&rs("Expression")&">"
		  end if
          
		  

          outtext=outtext &  "<a href='ShowAnnounce.asp?boardID="+cstr(boardID)+"&RootID="&cstr(rs("RootID"))&"&ID="&Cstr(rs("announceID"))&"' target='BoardAnnounce'>"
          dim t       		         
	  if rs("Length")=0 then
	     t=" <无内容>"
          else 
             t=" "
	  end if		   
                   
          if pwsonchsys then
             outtext=outtext & htmlencode(rs("Topic")+t)
          else
             outtext=outtext & Server.HTMLEncode(rs("Topic")+t)
          end if
          outtext=outtext & "</a> - <strong>" 
                    bytestr="("+cstr(rs("length"))
          if not WINNT_CHINESE then
             if rs("Length")-1=1 then
                bytestr=bytestr+" Byte)"
	     else
	        bytestr=bytestr+" Bytes)"
      	     end if
          else 
             bytestr=bytestr+"字)"
          end if


       dim display_username,isexpert,expertemail,rsexpt,sqlexpt
        isexpert=0

        display_username=rs("username")

        set rsexpt=server.createobject("adodb.recordset")
        sqlexpt="select * from experts where expertnm='"&display_username&"'"
        rsexpt.open sqlexpt,conn,1,1
        if not rsexpt.EOF then
          display_username=rsexpt("realnm")
          expertemail=rsexpt("email")
          isexpert=1
        end if
        rsexpt.Close


		if pwsonchsys then
           if Trim((rs("UserEmail")))="" then
             outtext=outtext & "(" & htmlencode(display_username)
           else
             outtext=outtext & "(" & "<a href=mailto:" & rs("UserEmail") & ">" & htmlencode(display_username) & "</a>" & "<img src=images/mailto.gif>"
           end if
        else
           if Trim((rs("UserEmail")))="" then
             outtext=outtext & "(" & Server.HTMLEncode(display_username) 
           else
             outtext=outtext & "(" & "<a href=mailto:" & rs("UserEmail") & ">" & Server.HTMLEncode(display_username) & "</a>" & "<img src=images/mailto.gif>"
           end if
        end if
  
        if isexpert=1 then
           outtext=outtext & "<a href=mailto:" & expertemail & ">" & "<img src=images/explogo.gif border=0 title='专家/嘉宾，点击发邮件'></a>" 
        end if
   

          outtext=outtext & ") </strong><font color=red><em>"&rs("DateAndTime")&"</em></font> [ID:"+cstr(rs("announceID"))+" 点击:"&rs("Hits")&"] "+bytestr+" <font color='red'>(" + Cstr(rs("child"))+")</font>"+chr(13)+chr(10)
          if trim(rs("DateAndTime"))<>"" and isdate(rs("DateAndTime")) then
             if cbool(cdate(rs("DateAndTime"))>(date()-5))=true then
                outtext=outtext &  "<img src='images/new.gif'>"
             end if
          end if

	  if rs("status")<>1 and rs("status")<>4 then 
		  outtext=outtext & "<a href='setStatus.asp?action=best&announceID="&Cstr(rs("announceID"))&"'><font color=green>精华</font></a>"+chr(13)+chr(10)
          end if
          
		  if rs("status")=1 then 
		  outtext=outtext & "<a href='setStatus.asp?action=nomal&announceID="&Cstr(rs("announceID"))&"'><font color=green>非精华</font></a>"+chr(13)+chr(10)
          end if
   
      if rs("status")<>4 then
	  outtext=outtext & "<a href='setStatus.asp?action=delete&announceID="&Cstr(rs("announceID"))&"'><font color='#cc0000'>删除</font></a>"+chr(13)+chr(10)
	  end if
	  if rs("status")=4 then
	  outtext=outtext & "<a href='setStatus.asp?action=delete&announceID="&Cstr(rs("announceID"))&"'><font color='#cc0000'>恢复</font></a>"+chr(13)+chr(10)
	  end if
      
      if rs("display")<>1 then
	  outtext=outtext & "<a href='setStatus.asp?action=display&announceID="&Cstr(rs("announceID"))&"'><font color='#cc0000'><b><i><u>发布</u></i></b></font></a>"+chr(13)+chr(10)
	  end if

      if rs("specialzone")<>1 then
        outtext=outtext & "<a href='setStatus.asp?action=deep&announceID="&Cstr(rs("announceID"))&"'><font color='#cc0000'>深入讨论</font></a>"+chr(13)+chr(10)
      else
        outtext=outtext & "<img src='images/expert.gif' border='0'><a href='setStatus.asp?action=open&announceID="&Cstr(rs("announceID"))&"'><font color='#cc0000'><b>公开讨论</b></font></a>"+chr(13)+chr(10)
	  end if

      if rs("layer")>1 then
	  outtext=outtext & "<a href='setStatus.asp?action=upgrade&announceID="&Cstr(rs("announceID"))&"'><font color='#cc0000'>标题独立</font></a>"+chr(13)+chr(10)
	  end if
 
	  if rs("layer")=1 then 
         outtext=outtext & "<a href='catalog.asp?announceID="&Cstr(rs("announceID"))&"'><font color='#cc0000'><b>分类</b></font>"
         if rs("catalog")="" or rs("catalog")="0" then outtext=outtext & "<img src='images/catalog.gif' border='0'>"
         outtext=outtext & "</a>"+chr(13)+chr(10)
      end if

      rs.movenext
          response.write outtext
          outtext=""
       loop
       if layer<>0 then 
          dim i 
          for i=1 to layer
              outtext=outtext & "</ul>"
          next 
       end if
       outtext=outtext & "</ul>"        
       response.write outtext
   end sub
function showpage(boardtype,boardmaster,totalannounce,boardid,mailstr1,mailstr2)
       response.write "<table border='0' width='98%' cellspacing='0' bordercolorlight='#000000' bordercolordark='#FFFFFF'  cellpadding='0'><tr>"
       response.write "<tr><td nowrap bgcolor='#ffffff'><p align=left>论坛："&boardtype&"</td>"
       response.write "<td nowrap bgcolor='#ffffff'><p align='left'>"
       response.write "主持人："+mailstr1+boardmaster+mailstr2+"</td>"
       response.write "<td nowrap bgcolor='#ffffff'><p align='center'><a href=Announce.asp?boardID="&boardid&" target=BoardAnnounce>发表新帖</a></td>"
       response.write "<td nowrap bgcolor='#ffffff'><p align='center'><a href=emanage.asp?boardID="&boardid&"&amp;page=1>刷新</a></td>"
       dim n
	    if totalAnnounce mod maxannounce=0 then
	      n= totalAnnounce \ maxannounce
	    else
	      n= totalAnnounce \ maxannounce+1
	    end if
        response.write "<form method=Post action=emanage.asp?boardID="&boardid&">"
        
       response.write "<td nowrap align='center' bgcolor='#ffffff'>"
       if CurrentPage<2 then
        response.write "<font color='navy'>首页 前页</font>&nbsp;"
        else
          response.write "<a href=emanage.asp?boardID="&boardid&"&amp;page=1>首页</a>&nbsp;"
          response.write "<a href=emanage.asp?boardID="&boardid&"&amp;page="&CurrentPage-1&">前页</a>&nbsp;"
        end if
        if n-currentpage<1 then
          response.write "<font color='navy'>后页 尾页</font>"
        else
          response.write "<a href=emanage.asp?boardID="&boardid&"&amp;page="&(CurrentPage+1)
          response.write ">后页</a> <a href=emanage.asp?boardID="&boardid&"&amp;page="&n&">尾页</a>"
        end if
        response.write "&nbsp;页次：<strong><font color=red>"&CurrentPage&"</font>/"&n&"</strong>页</td>"
        response.write "<td valign=top align=center nowrap bgcolor='#ffffff'>"
        response.write "<p>转到：<input type='text' name='page' size=3 maxlength=10 class=smallInput value="&currentpage&">"
        response.write "<input class=buttonface type='submit'  value=' Go '  name='B1'></span></p></td></form>"
       response.write "</table>" 


end function
else
  Response.Write "该论坛不存在！"
  end if
 end if
rsBoard.Close
set rsboard=nothing
   %>
<hr><!--#include file="FooterLogo.asp"-->
</body>
</html>
