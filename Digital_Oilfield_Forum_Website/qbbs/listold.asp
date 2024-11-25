<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="parameters.dat"-->
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<!-- #include file="inc/cfmexp.inc"-->
<%

   dim sql,rs,rsBoard,BoardName,boardsql
   dim selStr
   dim mailStr1
   dim mailStr2
   dim boardmaster
   'on error resume next
   selStr="()"
   boardID=1
   if not isEmpty(request("lstRefreshBoard")) then
      boardID=request("lstRefreshBoard")
   elseif not isEmpty(request("BoardID")) then
      boardID=request("BoardID")
   end if
   selStr=""

   if isempty(request("BoardID")) then boardID=1

   if not isempty(request("page")) then
      currentPage=cint(request("page"))
   else
      currentPage=1
   end if 
  set rsBoard=server.createobject("adodb.recordset")
  boardsql="select * from board where boardID="&boardID
  rsboard.open boardsql,conn,1,1
  
  if rsboard.eof or err.number<>0  then
  reponse.write "论坛地址出错，请检查地址！"
  reponse.end
  end if
    dim sysspace,syssayface,sysnoonline,syspostseq
    boardname=rsboard("boardname")
    session("boardtype")=rsboard("boardtype")
    session("boardname")=rsboard("boardname")
    session("boardID")=rsboard("boardID")
	session("fontsize")=rsboard("fontsize")
	session("fontcolor")=rsboard("fontcolor")
    boardmaster=rsboard("boardmaster")
	sysspace=rsboard("space")
	syssayface=rsboard("sayface")
	sysnoonline=rsboard("noonline")
	syspostseq=rsboard("postseq")
	maxannounce=rsboard("postsinpage")
 %>
<html>

<html><head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META NAME="GENERATOR" CONTENT="Mozilla/4.05 [en] (Win95; I) [Netscape]">
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>数字油田论坛 Digital Oilfield Forum</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body bgcolor='<%=rsboard("bgcolor")%>' background='<%=rsboard("background")%>' alink='<%=rsboard("link")%>' link='<%=rsboard("link")%>' vlink='<%=rsboard("vlink")%>'>
<center>
<%
if isexp=1 then 
  response.write "<img src='images/light.gif' border='0'><font size=2 color=#666666>[专家/嘉宾深入讨论区] 当前身份："&expertnm&"("&realnm&")。有标记<img src='images/expert.gif' border=0>的部分为深入讨论内容。&nbsp;</font>"
  response.write "&nbsp;&nbsp;<a href=exitexpert.asp?to=list.asp?boardid=1><img src='images/exit.gif' border=0><font size=2 color=#666666>退出</font></a><a href=exppwchg.asp target='_blank'>&nbsp;&nbsp;<img src='images/key.gif' border=0><font size=2 color=#666666>修改注册信息</font></a><a href=othexp.asp target='_blank'>&nbsp;&nbsp;<img src='images/othexp.gif' border=0><font size=2 color=#666666>联系其他专家/嘉宾</font></a>"
end if
%>
</center>
<font size='<%=rsboard("fontsize")%>' color='<%=rsboard("fontcolor")%>'>

<% if rsboard("BoardHead")="" or rsboard("BoardOwn")="" then%> 
<table width='468' border='0' cellspacing='0' cellpadding='0' align='center' bgcolor='#FFFFFF'><tr><td><div align='center'><b><font size='5' color='#660066' ><%=rsboard("boardname")%></font></b></div></td></tr></table><br><br>
<%end if%>

<center><%=rsboard("boardHead")%></center>

<center>[<a href="Announce.asp?boardID=<%=boardID%>" target=_blank>发表新帖-注册</a>] [<a href="config.asp?boardID=<%=boardID%>" target=_blank>论坛管理</a>] [<a href="search.asp?boardID=<%=boardID%>" target=_blank>检索</a>] [<a href="viewStatus.asp?type=1&boardID=<%=boardID%>" target=_blank>精华帖</a>] [<a href="javascript:location.reload();">刷新</a>] [<a href="mailto:wangq@daqing.com">联系主持人</a>] [<a href="mailto:zhangwl@daqing.com">联系论坛助理</a>] [<a href="about.asp" target=_blank>帮助</a>] <br>主持人Arthur热烈欢迎各位光临！请多指教。欢迎转载！欢迎加盟！ 建议浏览参数:1024*768全屏<br>网友个人观点不代表本论坛观点，网友帖子版权与本论坛无关。相关事宜请与作者联系。</center>
                        
<center><%=rsboard("boardOwn")%></center>

<!--forum begin-->
<hr></hr>
<%

 if not rsboard.eof then
    
    if trim(rsboard("masteremail"))<>"" then
      mailStr1="<a href='mailto:"+trim(rsboard("masteremail"))+"'>"
      mailStr2="</a>"
    else
      mailStr1=""
      mailStr2=""
    end if
   if boardID>0 then
    set rs=server.createobject("adodb.recordset")
   if isexp=1 then
    sql="select AnnounceID,boardID from bbs1 where display=1 and boardID="+cstr(boardID)+" and parentID=0 and status<>4 ORDER BY LastReplyID desc "
   else
    sql="select AnnounceID,boardID from bbs1 where display=1 and specialzone=0 and boardID="+cstr(boardID)+" and parentID=0 and status<>4 ORDER BY LastReplyID desc "
   end if
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
  
     dim postTmp
	 postTmp=""
	 if syspostseq=1 then postTmp="LastReplyID desc," 
	  
	 if selStr<>"()" then
          sql="select * from bbs1 where display=1 and specialzone=0 and (rootID in "&selStr& " ) ORDER BY "+postTmp+"rootID desc,orders"
          if isexp=1 then sql="select * from bbs1 where display=1 and (rootID in "&selStr& " ) ORDER BY "+postTmp+"rootID desc,orders"
     else
          sql="select * from bbs1 where display=1 and specialzone=0 ORDER BY "+postTmp+"rootID desc,orders"
          if isexp=1 then sql="select * from bbs1 where display=1 ORDER BY "+postTmp+"rootID desc,orders"
	 end if
	end if
         rs.Close
         
         rs.open sql,conn,1,1
         showlist()
         showpage session("boardname"),boardmaster,totalannounce,request("boardid"),mailstr1,mailstr2
   else
       response.write "<p> 版面："+session("boardtype")+"<br>主持人："+mailstr1+boardmaster+mailstr2+"<br>" 
       response.write " 本论坛无内容 "
  	   response.write "<p><a href='Announce.asp?boardID="+boardID+"'>发表新帖</a> <a href='List.asp?boardID="+request("boardid")+"'>刷新</a> "
            
	end if
         
     
      rs.close     

  
   sub showlist()
       on error resume next 
       dim outtext
       dim bytestr
       response.write  "<ul>"
       dim layer,first
       layer=1
	   first=true
       do while not (rs.eof or err.number<>0)

	   if sysspace=1 and rs("layer")=1 then
	       if first=false then response.write "<br><br>"
	   end if
	   first=false
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
		  if rs("specialzone")=1 then outtext=outtext&"<img src='images/expert.gif' border=0>"
		  if syssayface=1 and rs("Expression")<>".gif" and rs("Expression")<>"" then
          outtext=outtext & "<img src=images/"&rs("Expression")&">"
		  end if

          outtext=outtext &  "<a href='ShowAnnounce.asp?boardID="+boardID+"&RootID="&cstr(rs("RootID"))&"&ID="&Cstr(rs("announceID"))&"' target='_blank'>"
          dim t       		         
	              
          if pwsonchsys then
             outtext=outtext & htmlencode(rs("Topic")) & "</a>"
          else
             outtext=outtext & Server.HTMLEncode(rs("Topic")) & "</a>"
          end if

		  if instr(rs("append"),"<img src=")>0 then
            outtext=outtext & "[图]"
			elseif instr(rs("append"),"<a href=")>0 then
                 outtext=outtext & "[网址]"
		  end if

          if trim(rs("DateAndTime"))<>"" and isdate(rs("DateAndTime")) then
             if cbool(cdate(rs("DateAndTime"))>(date()-daysfornew))=true then
                outtext=outtext &  "<img src='images/new.gif'>"+chr(13)+chr(10)
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

		if pwsonchsys then
           if Trim((rs("UserEmail")))="" then
             outtext=outtext & "(" & htmlencode(rs("UserName"))
           else
             outtext=outtext & "(" & "<a href=mailto:" & rs("UserEmail") & ">" & htmlencode(rs("UserName")) & "</a>" & "<img src=images/mailto.gif>"
           end if
        else
           if Trim((rs("UserEmail")))="" then
             outtext=outtext & "(" & Server.HTMLEncode(rs("UserName")) 
           else
             outtext=outtext & "(" & "<a href=mailto:" & rs("UserEmail") & ">" & Server.HTMLEncode(rs("UserName")) & "</a>" & "<img src=images/mailto.gif>"
           end if
        end if
            
		  'outtext=outtext & ")<font color=#666666><i>"&rs("DateAndTime")&"</i></font>["+"<font color=#ff6666>点击:"&rs("Hits")&"</font>] "+" <font color='#3366ee'>(回复：" + Cstr(rs("child"))+")</font>"+bytestr+chr(13)+chr(10)
		  
		  outtext=outtext & ")<font color='#666666'>"&rs("DateAndTime")&"</font>["+"<font color=#ff6666>"&rs("Hits")&"</font>] "+bytestr
         
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
      dim n
	    if totalAnnounce mod maxannounce=0 then
	      n= totalAnnounce \ maxannounce
	    else
	      n= totalAnnounce \ maxannounce+1
	    end if
       response.write "<table border='0' width='98%' cellspacing='0' bordercolorlight='#000000' bordercolordark=''  cellpadding='0'><tr>"
       
       response.write "<tr><td nowrap bgcolor=''><p align='left'>"
       response.write "<a href=list.asp?boardID="&boardid&"&amp;page="&(CurrentPage+1)&"><font size=2>[下一页]</font></a></td>"
	   'response.write "<td nowrap bgcolor=''><p align='left'><font size=2></font></td>"
       response.write "<td nowrap bgcolor=''><p align='left'><a href=Announce.asp?boardID="&boardid&" target=_blank><font size=2>[发表新帖]</font></a></td>"
       response.write "<td nowrap bgcolor=''><p align='left'><a href=list.asp?boardID="&boardid&"&amp;page=1><font size=2>[刷新]</font></a></td>"
       
        response.write "<form method=Post action=list.asp?boardID="&boardid&">"
        
       response.write "<td nowrap align='center' bgcolor=''>"
       if CurrentPage<2 then
        response.write "<font color='#dddddd' size=2>首页 前页</font>&nbsp;"
        else
          response.write "<a href=list.asp?boardID="&boardid&"&amp;page=1><font size=2>首页</font></a>&nbsp;"
          response.write "<a href=list.asp?boardID="&boardid&"&amp;page="&CurrentPage-1&"><font size=2>前页</font></a>&nbsp;"
        end if
        if n-currentpage<1 then
          response.write "<font color='#dddddd' size=2>后页 尾页</font>"
        else
          response.write "<a href=list.asp?boardID="&boardid&"&amp;page="&(CurrentPage+1)
          response.write "><font size=2>后页</font></a> <a href=list.asp?boardID="&boardid&"&amp;page="&n&"><font size=2>尾页</font></a>"
        end if
        response.write "<font size=2>&nbsp;页次：<strong><font color=black size=2>"&CurrentPage&"/"&n&"</strong>页</font></td>"
        response.write "<td valign=top align=center nowrap bgcolor=''>"
        response.write "<p><font size=2>转到：</font><input type='text' name='page' size=2 maxlength=10 class=smallInput value="&currentpage&">"
        response.write "<input class=buttonface type='submit'  value=' Go '  name='B1'></span></p></td></form>"
        response.write "<tr><td><font size=2><a href=http://www.internetism.org target=_blank>论坛首页</a></font></td></tr>"
        response.write "</table>" 


end function
else
  Response.Write "该论坛不存在！"
  
end if
rsBoard.Close
set rsBoard=nothing
   %>
</body>
</html>
