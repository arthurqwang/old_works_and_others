<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="parameters.dat"-->
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<!-- #include file="inc/cfmexp.inc"-->
<style type="text/css">
<!--
.form1 {margin-top: -10px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px}
.input1 {width: 110px;  border-style: solid; border-width: 1px; background-color: #A5BEE7}
.input2 {width: 60px;  height: 16px; font:12px;  border-style: solid; border-width: 1px; border-color: #A5BEE7}
.input3 {width: 15px;  height: 15px; font:12px;  border-style: plane; border-width: 0px; background-color:}
.input4 {width: 30px;  height: 16px; font:12px;  border-style: solid; border-width: 1px; border-color: #A5BEE7}
.button1 {width: 28px;  height: 17px; font:12px; border-style: plane; background-color: #A5BEE7}
-->
</style>
<%

   dim sql,rs,rsBoard,BoardName,boardsql
   dim selStr
   dim mailStr1
   dim mailStr2
   dim boardmaster
   'on error resume next
   selStr="()"

  'boardID = 1

   if not isEmpty(request("lstRefreshBoard")) then
       boardID=request("lstRefreshBoard")
    elseif not isEmpty(request("boardID")) then
       boardID=request("boardID")
    end if
   selStr=""
 

 ' response.write boardid

   if isempty(request("boardID")) then boardID=1

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

<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META NAME="GENERATOR" CONTENT="Microsoft FrontPage 4.0">
<meta http-equiv="Content-Type" content="text/html" charset="gb2312">
<title>
<%
'=rsboard("boardname")
%>
数字油田论坛 [Digital Oilfield Forum]</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body bgcolor='<%=rsboard("bgcolor")%>' background='<%=rsboard("background")%>' alink='<%=rsboard("link")%>' link='<%=rsboard("link")%>' vlink='<%=rsboard("vlink")%>'>

<center>
<%
if isexp=1 then 
  response.write "<img src='images/light.gif' border='0'><font size=2 color=#666666>[专家/嘉宾深入讨论区] 当前身份："&expertnm&"("&realnm&")。有标记<img src='images/expert.gif' border=0>的部分为深入讨论内容。&nbsp;</font>"
  response.write "&nbsp;&nbsp;<a href=exitexpert.asp?to=firstpg.asp><img src='images/exit.gif' border=0><font size=2 color=#666666>退出</font></a><a href=exppwchg.asp target='_blank'>&nbsp;&nbsp;<img src='images/key.gif' border=0><font size=2 color=#666666>修改注册信息</font></a><a href=othexp.asp target='_blank'>&nbsp;&nbsp;<img src='images/othexp.gif' border=0><font size=2 color=#666666>联系其他专家/嘉宾</font></a>"
end if
%>
<table border="0" width="900" cellspacing="6">
  <tr>
    <td width="50%" valign="top" align="left">
    <font size='<%=rsboard("fontsize")%>' color='<%=rsboard("fontcolor")%>'>

<center><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></center>

<center>[<a href="Announce.asp?boardID=<%=boardID%>" target=_blank>发表新帖-注册</a>] [<a href="config.asp?boardID=<%=boardID%>" target=_blank>论坛管理</a>] [<a href="search.asp?boardID=<%=boardID%>" target=_blank>检索</a>] [<a href="viewStatus.asp?type=1&boardID=<%=boardID%>" target=_blank>精华帖</a>] [<a href="javascript:location.reload();">刷新</a>] [<a href="mailto:wangq@daqing.com">联系主持人</a>] [<a href="mailto:zhangwl@daqing.com">联系论坛助理</a>] [<a href="about.asp" target=_blank>帮助</a>] <br>主持人Arthur热烈欢迎各位光临！请多指教。欢迎转载！欢迎加盟！ 建议浏览参数:1024*768全屏<br>网友个人观点不代表本论坛观点，网友帖子版权与本论坛无关。相关事宜请与作者联系。</center>
<table border="0"><tr><td valign="top"><img border="0" src="../ylts.gif"></td><td valign="bottom"><font color="#336699" size="2">&nbsp;&nbsp;
<%
        dim fs2, notestr 
        set fs2=server.createobject("MSWC.Nextlink")
        notestr=fs2.getnexturl("../notes.txt")
        response.write notestr
%><a href="../allnotes.asp" target=_blank><font size="2" color="#CC6600">&nbsp;[全部]</font></a></font></td></tr></table>
                        
<center><%=rsboard("boardOwn")%></center>                      
<font color="#ffffff" size=1></font>         

<!--forum begin-->         
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd" width="200" align=center>
<tr><td>
<table border="0" width="100%">
<form action="searchall.asp" method="post" class="form1" target="_blank">
        <tr>
          <td width="100%" colspan="2" bgcolor="#FFFFFF" background="../cellbg2.gif" height="16" valign="bottom"><b><font color="#336699"><font size="2">&nbsp;</font></font></b><font color="#336699"><font size="2"><font color=#ffffff size="2"><b>最新文章</b></font>
<%
'如果有人发新帖，则显示new图标，但批准后才能显示帖子
 set rs=server.createobject("adodb.recordset")
 sql="select * from bbs1 where display=0"
 rs.open sql,conn,1,1
 if not rs.eof then
   response.write "<a href=config.asp?boardID="
   response.write boardID 
   response.write " target=_blank><img border='0' src='images/NEW.GIF' title='存在新增帖子'></a>"
 end if
 rs.close

%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;关键字<input type="text" name="keyword" size="5" class="input2">
<input class="button1" type="submit" value="检索" name="cmdTopic">
<input type="checkbox" name="bbs" size="5" class="input3" checked>论坛BBS
<input type="checkbox" name="text" size="5" class="input3" checked>站内全文
<input type="checkbox" name="doc" size="5" class="input3" checked>资料中心
</font></font></td></tr>
</table>
</form> 

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
'    if isexp=1 then
'      sql="select AnnounceID,boardID from bbs1 where display=1 and boardID="+cstr(boardID)+" and parentID=0 and status<>4 ORDER BY LastReplyID desc "
'    else
'      sql="select AnnounceID,boardID from bbs1 where display=1 and specialzone=0 and boardID="+cstr(boardID)+" and parentID=0 and status<>4 ORDER BY LastReplyID desc "
'    end if

    sql="select AnnounceID,boardID from bbs1 where display=1 and boardID="+cstr(boardID)+" and parentID=0 and status<>4 ORDER BY LastReplyID desc "

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
	          sql="select * from bbs1 where display=1 and specialzone=0 and (rootID in "&selStr& " ) ORDER BY "+postTmp+"rootID desc,announceid desc "
              'if isexp=1 then sql="select * from bbs1 where display=1 and (rootID in "&selStr& " ) ORDER BY "+postTmp+"rootID desc,announceid desc "
              sql="select * from bbs1 where display=1 and (rootID in "&selStr& " ) ORDER BY "+postTmp+"rootID desc,announceid desc "
	     else
              sql="select * from bbs1 where display=1 and specialzone=0 ORDER BY "+postTmp+"rootID desc,dateandtime desc "
	          'if isexp=1 then sql="select * from bbs1 where display=1 ORDER BY "+postTmp+"rootID desc,dateandtime desc "
	          sql="select * from bbs1 where display=1 ORDER BY "+postTmp+"rootID desc,dateandtime desc "
		 end if
	end if
         rs.Close
         
         rs.open sql,conn,1,1
    '     showpage session("boardname"),boardmaster,totalannounce,boardid,mailstr1,mailstr2
           
      'response.write rs.recordcount


         showlist2()
         showpage session("boardname"),boardmaster,totalannounce,boardid,mailstr1,mailstr2
   else
       response.write "<p> 版面："+session("boardtype")+"<br>主持人："+mailstr1+boardmaster+mailstr2+"<br>" 
       response.write " 本论坛无内容 "
  	   response.write "<p><a href='Announce.asp?boardID="+boardID+"'>发表新帖</a> <a href='list2.asp?boardID="+boardID+"'>刷新</a> "
            
	end if
         
     
      rs.close     

  
   sub showlist2()
      ' on error resume next 
       dim outtext,newdays,maxsubtopic
       dim bytestr,addupstr
       dim ii,jjj,jjjj
       dim layer,first
       layer=1
	   first=true
       ii=1
       jjj=0
       jjjj=0
       newdays=daysfornew  '多少天之内为新的
       maxsubtopic=firstfollowlines-1 '跟从的回复标题最大数目
       addupstr=""
'ii：第一页显示几行，回复也计在内。ii要小于论坛设定的每页行数,取奇数
       do while ii<=firstpglines
       
       if ii=firstpglines then
             
             do while rs("layer")>1
               rs.movenext
             loop
       end if
	   if sysspace=1 and rs("layer")=1 then
	       if first=false then response.write "<br><br>"
	   end if
	   first=false
       if rs("layer")<=1 then jjj=0
       outtext="<br>&nbsp;&nbsp;&nbsp;"
       
       if rs("layer")> 1 then
          outtext=outtext & "&nbsp;&nbsp;&nbsp;"
       end if
          if (rs("layer")=1 and jjjj=1) or (rs("layer")>1 and rs("child")>0) then
            outtext=outtext&"<a href='Showlink.asp?boardid="&boardid&"&Rootid="&cstr(rs("Rootid"))&"&id="&cstr(rs("announceid"))&"' target='_blank'><img src='images/plus.gif' border='0' title='显示关联标题'></a>&nbsp;"
          else
            outtext=outtext&"<img src='images/noplus.gif' border='0'>&nbsp;"
          end if
           
          if rs("specialzone")=1 then outtext=outtext&"<img src='images/expert.gif' title='专家/嘉宾深入讨论区内容'border=0>"
          		  
		  if syssayface=1 and rs("Expression")<>".gif" and rs("Expression")<>"" then
          outtext=outtext & "<img src=images/"&rs("Expression")&">"
		  end if

          outtext=outtext &  "<a href='ShowAnnounce.asp?boardid="&boardid&"&Rootid="&cstr(rs("Rootid"))&"&id="&cstr(rs("announceid"))&"' target='_blank'"


          dim t
          dim strt,tpc
          dim initlen
          dim topiclen
          dim display_username,isexpert,expertemail
          isexpert=0         
	      initlen=lengthperline
          if rs("layer")>1 then initlen=lengthperline-4
          topiclen=0 
          strt=rs("Topic")
          tpc=strt
          i=0         
          do while i<initlen
             i=i+1
             topiclen=topiclen+1
             if mid(strt,topiclen,1)>chr(127) then
               i=i+1
             end if
             
          loop
          if len(strt)>topiclen then
            strt=left(strt,topiclen)&"~"
            outtext=outtext & "title='" & tpc &"'"
          end if
          outtext=outtext & ">" 
           'response.write topiclen             
          if pwsonchsys then
             outtext=outtext & htmlencode(strt) & "</a>"
          else
             outtext=outtext & Server.HTMLEncode(strt) & "</a>"
          end if

		  if instr(rs("append"),"<img src=")>0 then
            outtext=outtext & "[图]"
			elseif instr(rs("append"),"<a href=")>0 then
                 outtext=outtext & "[网址]"
		  end if

          if trim(rs("DateAndTime"))<>"" and isdate(rs("DateAndTime")) then
             if cbool(cdate(rs("DateAndTime"))>(date()-newdays))=true then
                outtext=outtext &  "<img border='0' src='images/NEW.GIF' title='新增文档'>"+chr(13)+chr(10)
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
	     bytestr="(无内容)"
        end if	

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
          
        outtext="<font color=#666666>"+outtext & ")</font><font color='#666666'>"&rs("DateAndTime")&"</font><font color='#aaaaaa'>[</font>"+"<font color=#666666>"&rs("Hits")&"</font><font color='#aaaaaa'>]</font><font color='#666666'>"+bytestr+"</font>"

        if jjj <= maxsubtopic then
          if rs("layer")>1 then
             addupstr=addupstr&"<font size=2>"&outtext&"</font>"
             jjj=jjj+1
          else
             addupstr="<font size=2>"&outtext&"</font>"&addupstr
          end if

          ii=ii+1
          outtext=""
          
          

          if rs("layer")=1 then
            response.write addupstr
            addupstr=""
            jjj=0
            jjjj=0
          end if

          rs.movenext
        else
            outtext=""
            rs.movenext
            jjjj=1
        end if
       loop


'下面这行控制论坛首页宽度
       response.write "<table width=570 cellpadding='0' cellspacing='0'><tr><td><font size=1>&nbsp;</font></td></tr><tr align='right'><form action='firstpg.asp' method='post' class='form1' target='_self'><td bgcolor=#eeeeff><img border='0' src='images/zhuanti.gif'></td><td bgcolor=#eeeeff>&nbsp;</td><td  bgcolor=#eeeeff align='left'>"

       response.write "<a href=List.asp?boardID=1&catalog=0 target='_blank'><font size=2 color=#cc6600>全部</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=1 target='_blank'><font size=2 color=#336699>软件工程与系统集成</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=2 target='_blank'><font size=2 color=#336699>数据与数据库</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=3 target='_blank'><font size=2 color=#336699>网络与基础设施</font></a>&nbsp;<br>"
       response.write "<a href=List.asp?boardID=1&catalog=4 target='_blank'><font size=2 color=#336699>GIS</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=5 target='_blank'><font size=2 color=#336699>办公自动化</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=6 target='_blank'><font size=2 color=#336699>多媒体</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=7 target='_blank'><font size=2 color=#336699>系统维护</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=8 target='_blank'><font size=2 color=#336699>虚拟现实</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=9 target='_blank'><font size=2 color=#336699>数据中心</font></a>&nbsp;<br>"
       response.write "<a href=List.asp?boardID=1&catalog=a target='_blank'><font size=2 color=#336699>ERP</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=b target='_blank'><font size=2 color=#336699>勘探</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=c target='_blank'><font size=2 color=#336699>开发</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=d target='_blank'><font size=2 color=#336699>勘探开发一体化</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=e target='_blank'><font size=2 color=#336699>地面工程</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=f target='_blank'><font size=2 color=#336699>经营管理</font></a>&nbsp;<br>"
       response.write "<a href=List.asp?boardID=1&catalog=g target='_blank'><font size=2 color=#336699>信息化建设策略与管理</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=z target='_blank'><font size=2 color=#336699>站务管理及其它</font></a>"

       response.write "</td><td width=162 bgcolor=#f9f9dd align=center><font size=2 color=#cc6600><b>深入讨论区</b><BR></font><font color=#336699 size=2>仅限专家/嘉宾使用</font>"


'如果有人提出加入申请，则显示new图标，但批准后才能生效
 dim rse
 set rse=server.createobject("adodb.recordset")
 sql="select * from experts where active=0"
 rse.open sql,conn,1,1
 if not rse.eof then
   response.write "<a href=config.asp?boardID="
   response.write boardID 
   response.write " target=_blank><img border='0' src='images/NEW.GIF' title='存在新申请'></a>"
 end if
 rse.close
 response.write "<br><input type='hidden' name='hiddenflag' value='do456wangquan'><font size='2' color='#336699'>&nbsp;用户</font><input type='text' name='expertnm' size='5' class='input4'><font size='2' color='#336699'>&nbsp;密码</font><input type='password' name='expertpw' size='5' class='input4'> <input class='button1' type='submit' value='进入'></form><a href='expreg.asp' target='_blank'></font>&nbsp;<img border='0' src='images/goto.gif' height=14><font color=#336699 size=2>加入深入讨论</a>&nbsp;&nbsp;&nbsp;<a href='srtlq.asp' target='_blank'><img src='images/que1.gif' border=0>说明</a></td></tr></table>"
 end sub
   
function showpage(boardtype,boardmaster,totalannounce,boardid,mailstr1,mailstr2)
      dim n
	    if totalAnnounce mod maxannounce=0 then
	      n= totalAnnounce \ maxannounce
	    else
	      n= totalAnnounce \ maxannounce+1
	    end if
       response.write "</td></tr></table>"


end function
else
  Response.Write "该论坛不存在！"
  
end if
rsBoard.Close
set rsBoard=nothing
   %>
 
      </font>
 
    </td>
    <td width="100%" valign="top">
<table border="0">
  <tr>
    <td align="center">
     <img border="0" src="../ktjy.jpg">
    </td>
  </tr>
  <tr>
    <td width="91%" bgcolor="#f5f5f5"><font size="2" color="#666666">为方便研究和交流，我们专门开设了这个论坛。大庆油田有限责任公司作为首先提出数字油田构想并积极推动数字油田建设的石油企业，愿意与国内外各石油企业、各兄弟油田及各研究机构共同探讨数字油田的相关技术和建设策略。我们怀着最真诚的愿望，让我们共同的理想早日实现，让数字油田引领时代，开创未来。诚邀热爱这项事业的各方面人士加入讨论！</font></td>
  </tr>
<%
'如果有人加入新资料，则显示new图标，但批准后才能显示
dim newdl
newdl=0
 set rs=server.createobject("adodb.recordset")
 sql="select * from dllist where display=0"
 rs.open sql,conn,1,1
 if not rs.eof then
   newdl=1
 end if
 rs.close
%>
  <tr>
    <td width="100%" colspan="2" valign="top"><font color="#336699">
    <table border="1" cellpadding="0" cellspacing="5" style="border-collapse: collapse" bordercolor="#dddddd">
    <tr><td><img border="0" src="../docenter.gif"><% if newdl=1 then response.write "<a href=config.asp?boardID=1 target=_blank><img border='0' src='images/new.gif' title='存在新增资料'></a>" %>&nbsp;<a href="showdownload.asp" target="_blank"><img border="0" src="images/arrow.gif"></a></td></tr>
    
    <%
    dim displaylines
    displaylines=downloadlines
    i=1
    set rs=server.createobject("adodb.recordset")
    sql="select * from dllist where firstdisplay=1 and display=1 order by seq desc"
    if isexp=0 then sql="select * from dllist where firstdisplay=1 and specialzone=0 and display=1 order by seq desc"
       rs.open sql,conn,1,1
response.write "<tr><td><table border=0 cellspacing='0' cellpadding='0'>"
 	 do while not rs.EOF and i<=displaylines
response.write "<tr ><td align='left' valign='middle'>"
       response.write "<font size=3 color=#336699>*</font>&nbsp;"
       if rs("specialzone")=1 then response.write "<img border=0 src='images/expert.gif' title='专家/嘉宾深入讨论区内容'>"
response.write "<a title='"
response.write "标题："&rs("topic")&chr(13)
response.write "作者："&rs("author")&chr(13)
response.write "说明："&rs("explain")
response.write "'>"
       response.write "<font size=2 color=#666666>"
       if rs("shorttopic")="" then
         response.write rs("topic")
       else
         response.write rs("shorttopic")
       end if
response.write "</a>"
       if rs("newornot")=1 then response.write "<img border='0' src='images/new.gif' title='新增文档'>"
       if rs("important")=1 then response.write "<img border='0' src='images/important.gif' title='重要文档'>"
       if trim(rs("needpass"))<>"" then response.write "<img border='0' src='images/lock.gif' title='需要密码，请联系主持人或论坛助理。'>"
       if rs("format")<>"" then response.write "，"&rs("format")
       if rs("size")<>"" then response.write "，"&rs("size")
       response.write "</font></td><td align='right' valign='middle'><a href='"&rs("url")&"' target='_blank'><font size='2' color='#336699'>下载</font></a><br>"
       rs.MoveNext
       i=i+1 
response.write "</td></tr>"
     loop
     rs.Close
response.write "<tr><td valign='bottom' colspan='2'><a href='showdownload.asp' target='_blank'><font size=2 color=#336699>>>全部资料列表</font></a>&nbsp;&nbsp;&nbsp;<a href='dlurlmng.asp' target='_blank'><font size=2 color=#336699>>>如有资料共享，由此添加链接</font></a></td><tr>"  
response.write "</table></td></tr>"

    %>
    </table>
    </td>
  </tr>
</table>
<table border="0" width="100%">
  <tr>
    <td background="../cellbg.gif" bgcolor="#f5f5f5" height="16" colspan="3"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><a href="../smsszyt.htm" target="_blank"><font size="2" color="#336699">什么是数字油田？
      </font></a></td>
  </tr>
  <tr>
    <td colspan="3" bgcolor="#f5f5f5"><font size="2" color="#666666">数字油田(Digital Oilfield,                                         
      DO)，简单地说就是数字化的油田，是某个油田实体在IT平台上的虚拟表示。其概念源于数字地球，首先由大庆油田于1999年提出。在概念上，数字油田可分为狭义数字油田和广义数字油田。兼顾技术含义和管理含义的数字油田可称为广义数字油田。</font><a href="../smsszyt.htm" target="_blank"><font size="2" color="#336699">[详细...]</font></a></td>
  </tr>
  <tr>
    <td background="../cellbg.gif" bgcolor="#f5f5f5" height="16" colspan="3"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><a href="../smsytntzy.htm" target="_blank"><font size="2" color="#336699">什么是因特奈特主义？</font></a></td>
  </tr>
  <tr>
    <td colspan="3" bgcolor="#f5f5f5"><font size="2"><font color="#666666">因特奈特主义（Internetism）即借鉴因特网原理形成的一套思想体系。可用于指导管理、经济、社会、政治、军事等各方面的工作。因特网成功的4个关键因素是：彻底的开放性、高度的统一管理、清晰的自治边界和简约的协议规则，这也是因特奈特主义思想的基本观点。</font><a href="../smsytntzy.htm" target="_blank"><font color="#336699">[详细...]</font></a></font></td>
  </tr>
</table>
</td>
  </tr>
  <tr>
    <td width="50%" valign="top" align="left">
      <table border="0" width="100%">
        <tr>
          <td width="100%" colspan="2" bgcolor="#FFFFFF" background="../cellbg.gif" height="16"><b><font color="#336699"><font size="2">&nbsp;</font></font></b><font color="#336699"><font size="2">每日专家/嘉宾介绍</font></font><font size="2" color="#666666">&nbsp;&nbsp;&nbsp;我们需要相互了解，我们需要共同进步！恭请有志者立即加盟！</font><font size="2" color="#336699">联系</font><a href="mailto:wangq@daqing.com" target="_blank"><font size="2" color="#336699">主持人</font></a></td>
        </tr>
        <tr>
      <%
        dim experts_num,fs, brief, days,brief_ch,objFSO,Dir,strFileName,begindate     
        experts_num=0
        begindate="14-Sep-2003"
        Set objFSO = Server.CreateObject("Scripting.FileSystemObject6")
        do
          brief_ch="../experts/"&(experts_num+1)
          strFileName= Server.MapPath(brief_ch)
          Dir = objFSO.FolderExists(strFileName)
          if not dir then
            exit do
          else
            experts_num=experts_num+1
          end if
        loop

        days=(DateDiff("d",begindate,Date) + experttoday) mod (experts_num) +1
        response.write  "<td width='12%' valign='middle' align='left'><img border='0' src='../experts/"
        response.write days
        response.write "/photo.jpg' width='50' height='60'></td><td width='88%'><font color='#666666' size='2'>"
        set fs=server.createobject("MSWC.Nextlink")
        brief_ch="../experts/"&days&"/brief.txt"
        brief=fs.getnexturl(brief_ch)
        'response.write days
        response.write brief
        response.write "&nbsp;&nbsp;<a href='../experts/"
        response.write days
        response.write "/intro.htm' target=_blank><font color='#336699' size='2'>详细介绍</font></a>"
        response.write "</font></td>"
      %>
        </tr>
      </table>
      <table border="0" width="100%">
        <tr>
          <td width="100%" bgcolor="#FFFFFF" background="../cellbg.gif" height="8"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">专家/嘉宾</font>&nbsp;<font color=#666666 size=2>(随机显示，排名不分先后)</font><font size="2" color="#FFFFFF"></font><font size="2" color="#FFFFFF"><a href='../qbbs/introall.asp' target='_blank'><font size=2 color=#336699>[全部]</font></a>
            </font><font size="2" color="#666666">诚邀各位登坛落座，让我们一起努力！</font><font size="2" color="#336699">联系</font><a href="mailto:wangq@daqing.com" target="_blank"><font size="2" color="#336699">主持人</font></a></td>
        </tr>
</center>
        <tr>
          <td width="50%" bgcolor="#FFFFFF" height="8">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd" width="100%" align=center>
              <tr>
                <td width="100%">
      <div align="left">
      <table border="0" width="100%" align="left">
        <tr>
     <%
         dim a(51),iii,jjj,RV,show_num,is_unique,Comma_pos
         show_num=experts_num-2
         if show_num>8 then show_num=8
         iii=1
         do while iii<=50
          a(iii)=0
          iii=iii+1
         loop
         Randomize(Cbyte(Right(Time(),2)))
         iii=1
         do while iii<=show_num
            is_unique=0
            do while is_unique=0
               is_unique=1
               do 
                 RV =(Int(experts_num * Rnd + 1))
               loop while RV=7 or RV=days
               jjj=1
               do while jjj<=iii 
                if a(jjj)=RV then
                  is_unique=0
                  exit do
                end if
               jjj=jjj+1
               loop
            loop
            a(iii)=RV
            iii=iii+1
        loop
        if days <>7 then 
         RV =(Int(show_num * Rnd + 1))
         a(RV)=7
        end if

        ' set fs=server.createobject("MSWC.Nextlink")
         iii=1
         do while iii<=show_num
          response.write "<td  align=center bgcolor=#FFFFFF valign=bottom><font size=2 color=#666666><a href='../experts/"&a(iii)&"/intro.htm' target='_blank'><img border='0' src='../experts/"&a(iii)&"/photo.jpg' width='40' height='48'><br>"
         
          brief_ch="../experts/"&a(iii)&"/brief.txt"
          brief=fs.getnexturl(brief_ch)
          Comma_pos=Instr(brief,"，")
          if Comma_pos = 0 then Comma_pos=Instr(brief,",")
          response.write Left(brief,Comma_pos-1) 
          response.write "</a></font></td>"
          iii=iii+1
         loop
      %>



        </tr>
      </table>
      </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
<center>
      <table border="0" width="100%" height="52">
        <tr>
          <td width="100%" colspan="2" bgcolor="#FFFFFF" background="../cellbg.gif" height="17"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">专家论著</font><font size="2" color="#FFFFFF">&nbsp;</font><font size="2" color="#666666"><img border="0" src="images/NEW.GIF" title="新增文档"></font><font size="2" color="#666666">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
            欢迎各位专家把您的大作拿来共享</font></td>
        </tr>
        <tr>
          <td width="47%" valign="top"><font size="2" color="#666666">1  
            <a href="http://www.internetism.org/experts/10/works/gjzx.doc" target="_blank">构建油田公司数据中心</a>（刘学霞）</font></td>
          <td width="53%" valign="top" ><font size="2" color="#666666">2  
            <a href="http://www.internetism.org/experts/10/works/sjck.doc" target="_blank">油田开发数据仓库解决方案的技术实践</a></font><font size="2" color="#666666">（刘学霞）</font></td>
        </tr>
        <tr>
          <td  valign="top"><font size="2" color="#666666" >3  
            <a href="http://www.internetism.org/experts/1/works/sjzlymx.doc" target="_blank">可扩展的数据质量元模型</a></font><font size="2" color="#666666"><img border="0" src="images/important.gif" title="重要文档">（管尊友）</font></td>
          <td  valign="top"><font size="2" color="#666666" >4  
            <a href="http://www.internetism.org/experts/9/works/shengli.rar" target="_blank">胜利油田信息化框架构建研究</a></font><font size="2" color="#666666"><img border="0" src="images/important.gif" title="重要文档">（段鸿杰）</font></td>
         </tr>
        <tr>
          <td  valign="top"><font size="2" color="#666666" >5  
            <a href="http://www.digitaloilfield.org.cn/downloads/swzgis.doc" target="_blank">石油行业GIS应用调研</a></font><font size="2" color="#666666"><img border="0" src="images/NEW.GIF" title="新增文档"><img border="0" src="images/important.gif" title="重要文档">（孙维志）</font></td>
          <td  valign="top"><font size="2" color="#666666" >6  
            <a href="http://www.internetism.org/downloads/ktkfyth.doc" target="_blank">勘探开发信息一体化趋势及构想</a></font><font size="2" color="#666666"><img border="0" src="images/NEW.GIF" title="新增文档"><img border="0" src="images/important.gif" title="重要文档">（刘新华）</font></td>
         </tr>
      </table>
      <table border="0" width="100%">
        <tr>
          <td width="100%" colspan="3" bgcolor="#FFFFFF" background="../cellbg.gif" height="16"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><a href="../onintnt.htm" target="_blank"><font size="2" color="#336699">因特网技术原理概要</font></a><font size="2" color="#FFFFFF">&nbsp;&nbsp;</font><font size="2" color="#336699">&nbsp;</font><font size="2" color="#666666">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                     
            [因特网原理：因特奈特主义思想的种子]</font></td>
        </tr>
        <tr>
          <td width="33%"><font size="2" color="#666666"><a href="../onintnt.htm#1" target="_blank">1                             
            Internet简介</a></font></td>
          <td width="33%"><font size="2" color="#666666"><a href="../onintnt.htm#2" target="_blank">2                             
            TCP/IP协议</a></font></td>
          <td width="34%"><font size="2" color="#666666"><a href="../onintnt.htm#3" target="_blank">3                             
            Internet的地址和域名</a></font></td>
        </tr>
        <tr>
          <td width="33%"><font size="2" color="#666666"><a href="../onintnt.htm#4" target="_blank">4                             
            Internet的应用</a></font></td>
          <td width="33%"><font size="2" color="#666666"><a href="../onintnt.htm#5" target="_blank">5                             
            用户与因特网的连接方法</a></font></td>
          <td width="34%"><font size="2" color="#666666"><a href="../onintnt.htm#6" target="_blank">6                             
            CHINANET</a></font></td>
        </tr>
      </table>
      <table border="0" width="100%">
        <tr>
          <td width="100%" colspan="4" bgcolor="#FFFFFF" background="../cellbg.gif" height="16"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">相关参考资料链接</font><a href="../onintnt.htm" target="_blank"><font size="2" color="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                     
            </font></a><font color="#666666" size="2">[以下链接未经所有者许可，如有异议，请与主持人联系]</font></td>
        </tr>
        <tr><td><br></td></tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.geosociety.org.cn/" target="_blank"><img border="0" src="../zgdzxh.gif" width="109" ><br>
            <font color="#666666" size="2">中国地质学会</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.cgs.org.cn/" target="_blank"><img border="0" src="../zgdqwlxh.gif" width="108" ><br>
            <font color="#666666" size="2">中国地球物理学会</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.api.org/" target="_blank"><img border="0" src="../apisyxh.gif" width="108" ><br>
            <font color="#666666" size="2">API石油学会</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.spwla.org/" target="_blank"><img border="0" src="../cjjxh.gif" width="104" ><br>
            <font color="#666666" size="2">测井家协会</font></a></td>
        </tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.schlumberger.com" target="_blank"><img border="0" src="../slb.gif" width="109" height="38"><br>
            <font color="#666666" size="2">斯伦贝谢</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.lgc.com" target="_blank"><img border="0" src="../landmark.jpg" width="108" height="38"><br>
            <font color="#666666" size="2">兰德马克</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.spe.org/" target="_blank"><img border="0" src="../spe.gif" width="108" height="43"><br>
            <font color="#666666" size="2">SPE</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.jurassic.com.cn/" target="_blank"><img border="0" src="../jurassic.gif" width="104" height="38"><br>
            <font color="#666666" size="2">侏罗纪</font></a></td>
        </tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.saic.com" target="_blank"><img border="0" src="../saic.gif" width="109" height="38"><br>
            <font color="#666666" size="2">SAIC</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.petrooverseas.com" target="_blank"><img border="0" src="../pto-logo.jpg" width="108" height="43"><br>
            <font color="#666666" size="2">洲际石油</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.digitalearth.net.cn/" target="_blank"><img border="0" src="../szdqicon.gif" width="108" height="43"><br>
            <font color="#666666" size="2">数字地球</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.china001.com/" target="_blank"><img border="0" src="../szzglogo.gif" width="104" height="33"><br>
            <font color="#666666" size="2">数字中国</font></a></td>
        </tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="48"><a href="http://www.daqing.com" target="_blank"><img border="0" src="../dqlogo.jpg" width="116" height="28"><br>
            <font color="#666666" size="2">大庆油田</font></a></td>
          <td width="25%" valign="bottom" align="center" height="48"><a href="http://www.petrost.com" target="_blank"><img border="0" src="../petrost_logo.gif" width="88" height="33"><br>
            <font color="#666666" size="2">石油科学与技术论坛</font></a></td>
          <td width="25%" valign="bottom" align="center" height="48"><a href="http://www.ceibs.edu/forum/index_c.html#1" target="_blank"><img border="0" src="../zoglltlg.gif" width="94" height="31"><br>
            <font color="#666666" size="2">中欧管理论坛</font></a></td>
          <td width="25%" valign="bottom" align="center" height="48"><a href="http://www.topoint.com.cn/" target="_blank"><img border="0" src="../zdwlogo.gif" width="94" height="28"><br>
            <font color="#666666" size="2">支点网</font></a></td>
        </tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.petroleum.com.cn/" target="_blank"><img border="0" src="../zgsyxxw.gif" width="109" ><br>
            <font color="#666666" size="2">中华石油信息网</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://ogj.pennnet.com/home.cfm" target="_blank"><img border="0" src="../oil_gasj.gif" width="108" ><br>
            <font color="#666666" size="2">OIL&GAS JOURNAL</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.worldoil.com/" target="_blank"><img border="0" src="../worldoil.gif" width="108" ><br>
            <font color="#666666" size="2">WORLDOIL</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.petrochina.com.cn/" target="_blank"><img border="0" src="../petrochina.jpg" width="104" ><br>
            <font color="#666666" size="2">中国石油</font></a></td>
        </tr>
        <tr>
          <td width="25%"></td>
          <td width="25%"></td>
          <td width="25%"></td>
          <td width="25%"></td>
        </tr>
        <tr>
          <td width="25%"></td>
          <td width="25%"></td>
          <td width="25%"></td>
          <td width="25%"></td>
        </tr>
      </table>
    </center>
    </td>
    <td width="50%" valign="top" align="left">
      <table border="0" width="100%" bgcolor="#eeeeee" cellspacing="0" cellpadding="0">
  <tr>
    <td background="../cellbg.gif" bgcolor="#FFFFFF" height="16" colspan="3"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">管理定律与原理汇编</font><font color="#666666" size="2"><img border="0" src="images/NEW.GIF" title="新增文档">&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
  </tr>
  <tr>
    <td height="3" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl1.htm" target="_blank"><font color="#666666" size="2">1 
      领导行为艺术</font></a></font></td>
    <td height="3" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl2.htm" target="_blank"><font color="#666666" size="2">2 
      激励手段策略</font></a></font></td>
    <td height="3" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl3.htm" target="_blank"><font color="#666666" size="2">3 
      决策方法技术</font></a></font></td>
  </tr>
  <tr>
    <td height="2" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl4.htm" target="_blank"><font color="#666666" size="2">4 
      调控策略理论</font></a></font></td>
    <td height="2" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl5.htm" target="_blank"><font color="#666666" size="2">5 
      绩效考核评定</font></a></font></td>
    <td height="2" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl6.htm" target="_blank"><font color="#666666" size="2">6 
      补充材料</font></a></font></td>
  </tr>





      
        <tr><td colspan="3">
      <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd" bgcolor=#ffffff align=center>
      <tr><td><table border="0" >
        <tr>
          <td width="100%" colspan="2" background="../arthurzl.gif" height="5"><font size="2" color="#336699"><b><font size="4">&nbsp;</font></b><font size="2" color="#CC6600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
            抛砖引玉&nbsp;请多指教</font><font color="#666666" size="2">&nbsp;<a href="../experts/7/works/tzwj.htm" target="_blank"><font size="2" color="#336699">&nbsp;全部...</font></a></font>
          </td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9fff9><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9fff9><a href="../szyt.htm" target="_blank"><font size="2" color="#666666">狭义数字油田与广义数字油田</font></a></td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9f9f9 valign="top"><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f9f9><font color="#666666"><a href="../paper-do.htm" target="_blank"><font color="#666666" size="2">大庆油田有限责任公司数字油田模式与发展战略研究（<font color="#336699" size="2">摘要</font>）<img border="0" src="images/important.gif" title="重要文档"><img border="0" src="images/important.gif" title="重要文档"><br>
            The Research on the Modes and the Developing Strategies of&nbsp;&nbsp;                  
            Digital Oilfield of Daqing Oilfield Co., Ltd.(<font color="#336699" size="2">Abstract</font>)<br>                            
            </font></a></font><font size="2" color="#336699">注</font><font color="#666666" size="2">：此文为主持人的学位论文，是目前为止对数字油田论述最为全面的文献之一。<br>
            </font><a href="../downloads/DQDO.doc" target="_blank"><font color="#336699" size="2">浏览/下载全文</font></a><font color="#666666" size="2">，MS                  
            Word2000格式，2.09M；<br>
            </font><a href="../downloads/DQDOA.doc" target="_blank"><font color="#336699" size="2">论文精简版</font></a><font color="#666666" size="2"></font><font color="#666666" size="2"> 
            </font><font color="#666666" size="2">360K；</font><a href="../downloads/bydb.ppt" target="_blank"><font color="#336699" size="2">毕业答辩PPT</font></a><font color="#666666" size="2"></font><font color="#666666" size="2"> 
            </font><font color="#666666" size="2">3.76M</font></td>  
        </tr>
        <tr>
          <td width="14" bgcolor=#fff9f9><font color="#336699">*</font></td>
          <td width="724" bgcolor=#fff9f9><font color="#666666"><a href="../internetism.htm" target="_blank"><font color="#666666" size="2">因特网原理对管理思想的启示</font></a>&nbsp;</font></td>
        </tr>
        <% display_if_expert ("<tr><td width='14' bgcolor=#f9f9dd><font color='#336699'>^</font></td><td width='724' bgcolor=#f9f9dd><a href='../downloads/xxhgrxf.htm' target='_blank'><font size='2' color='#666666'>对信息化建设的个人想法</font><img border='0' src='images/NEW.GIF' title='新增文档'></a></td></tr>") %>
        <tr>
          <td width="14" bgcolor=#f9f9ff><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f9ff><a href="../xxhcjfx.htm" target="_blank"><font size="2" color="#666666">大庆油田信息化建设差距分析和总体对策</font><img border="0" src="images/NEW.GIF" title="新增文档"></a></td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9f0f9><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f0f9><a href="../downloads/szytjbjg.doc" target="_blank"><font size="2" color="#666666">数字油田基本架构的<font color="#cc6600">再次</font>修改<img border="0" src="images/NEW.GIF" title="新增文档">(2004.3.12)</font></a></td>
        </tr>
        
        <tr>
          <td width="14" bgcolor=#f9f9dd valign="top"><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f9dd><font color="#666666" size="2">大庆油田有限责任公司数字油田宣传片<img border="0" src="images/NEW.GIF" title="新增文档"><br>
            </font><a href="../downloads/dqdodemo.exe" target="_blank"><font color="#336699" size="2">下载/观看</font></a><font color="#666666" size="2">，EXE文件，92M，超大！</font></td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9ffff valign="top"><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9ffff><font color="#666666" size="2">广义数字油田(PPT片子)</font><a href="../downloads/gyszyt.ppt" target="_blank"><font color="#336699" size="2">
            下载/观看</font><font color="#666666" size="2">,</font></a><font color="#666666" size="2">4.03M</font></td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9f9ff valign="top"><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f9ff><font color="#666666" size="2">怎样写好科技论文(PPT片子)</font><a href="../downloads/zyxhkjlw.ppt" target="_blank"><font color="#336699" size="2">
            下载/观看</font><font color="#666666" size="2">,</font></a><font color="#666666" size="2">200K</font></td>
        </tr>
      </table></td></tr>
      </table>
      </td></tr>
      
      </table>

<table>
<tr><td background="../cellbg.gif" bgcolor="#f5f5f5" height="16" colspan="3"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">学术期刊
      </font><font size=2 color=#666666>&nbsp;&nbsp;链接由 <a href="http://www.petrost.com" tartget="_blank"><font color="#336699">石油科学与技术论坛</font></a> 提供</font></td></tr>
<tr><td width=55%>
<a href="http://www.petrost.com/dispbbs.asp?boardid=19&id=831&star=1#831" target="_blank"><font color="#666666" size=2>《石油学报》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=80&page=11" target="_blank"><font color="#666666" size=2>《天然气工业》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?BoardID=19&ID=801&replyID=3212&skin=1" target="_blank"><font color="#666666" size=2>《石油物探》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardid=19&ID=830&replyID=830" target="_blank"><font color="#666666" size=2>《石油和化工设备》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardid=19&id=837" target="_blank"><font color="#666666" size=2>《天然气地球科学》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardid=19&id=904" target="_blank"><font color="#666666" size=2>《管道技术与设备》</font></a>
</td>
<td>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=33&page=1" target="_blank"><font color="#666666" size=2>《西南石油学院学报》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=96&page=1" target="_blank"><font color="#666666" size=2>《石油钻探技术》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=154&page=1" target="_blank"><font color="#666666" size=2>《石油钻采工艺》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=791&page=1" target="_blank"><font color="#666666" size=2>《岩石矿物学杂志》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=796&page=1" target="_blank"><font color="#666666" size=2>《炼油技术与工程》<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=810&page=1" target="_blank"><font color="#666666" size=2>《油气田地面工程》</font></a>
</td>
</tr></table>
      <p>
        <font color="#336699" size="2">版权所有 Copyright &copy; 2003-2004                
      </font><font size="2" color="#CC6600"><br>大庆油田有限责任公司<br>数字油田论坛[DigitalOilfield.org.cn]</font><font color="#336699" size="2"> <br>
      All Rights Reserved&nbsp; 欢迎转载、链接，请注明出自本论坛<a href="../heroes.htm" target="_blank">。</a><br>     
        技术支持：</font><a href="mailto:zhangwl@daqing.com" target="_blank"><font color="#336699" size="2">请联系论坛助理 Marrist      
      </font></a><font color="#336699" size="2"> <br>
        <br>
      </font><font size="2" color="#CC6600">&gt;&gt;</font><a href="../emlpage.htm" target="_blank"><font size="2" color="#666666">进入论坛内部邮件系统&nbsp;(Web界面)</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp<script src="http://www.internetism.org/accounter/ajcount.asp?style=icon"></script>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top" align="left">
    </td>
    <td width="50%" valign="top" align="left"></td>
  </tr>
  <tr>
    <td width="50%" valign="top" align="left"></td>
    <td width="50%" valign="top" align="left"></td>
  </tr>
</table>
<div align="center">
  <center>
  <table border="0" width="890" height="10" cellspacing="0" cellpadding="0">
    <tr>
      <td width="900" bgcolor="#EEEEEE" height="3">
        <p align="center">　</td>
    </tr>
    <tr>
      <td width="900" height="3"></td>
    </tr>
  </table>
  </center>
</div>
</table>
</body>
