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
  reponse.write "��̳��ַ���������ַ��"
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
����������̳ [Digital Oilfield Forum]</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body bgcolor='<%=rsboard("bgcolor")%>' background='<%=rsboard("background")%>' alink='<%=rsboard("link")%>' link='<%=rsboard("link")%>' vlink='<%=rsboard("vlink")%>'>

<center>
<%
if isexp=1 then 
  response.write "<img src='images/light.gif' border='0'><font size=2 color=#666666>[ר��/�α�����������] ��ǰ��ݣ�"&expertnm&"("&realnm&")���б��<img src='images/expert.gif' border=0>�Ĳ���Ϊ�����������ݡ�&nbsp;</font>"
  response.write "&nbsp;&nbsp;<a href=exitexpert.asp?to=firstpg.asp><img src='images/exit.gif' border=0><font size=2 color=#666666>�˳�</font></a><a href=exppwchg.asp target='_blank'>&nbsp;&nbsp;<img src='images/key.gif' border=0><font size=2 color=#666666>�޸�ע����Ϣ</font></a><a href=othexp.asp target='_blank'>&nbsp;&nbsp;<img src='images/othexp.gif' border=0><font size=2 color=#666666>��ϵ����ר��/�α�</font></a>"
end if
%>
<table border="0" width="900" cellspacing="6">
  <tr>
    <td width="50%" valign="top" align="left">
    <font size='<%=rsboard("fontsize")%>' color='<%=rsboard("fontcolor")%>'>

<center><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></center>

<center>[<a href="Announce.asp?boardID=<%=boardID%>" target=_blank>��������-ע��</a>] [<a href="config.asp?boardID=<%=boardID%>" target=_blank>��̳����</a>] [<a href="search.asp?boardID=<%=boardID%>" target=_blank>����</a>] [<a href="viewStatus.asp?type=1&boardID=<%=boardID%>" target=_blank>������</a>] [<a href="javascript:location.reload();">ˢ��</a>] [<a href="mailto:wangq@daqing.com">��ϵ������</a>] [<a href="mailto:zhangwl@daqing.com">��ϵ��̳����</a>] [<a href="about.asp" target=_blank>����</a>] <br>������Arthur���һ�ӭ��λ���٣����ָ�̡���ӭת�أ���ӭ���ˣ� �����������:1024*768ȫ��<br>���Ѹ��˹۵㲻������̳�۵㣬�������Ӱ�Ȩ�뱾��̳�޹ء������������������ϵ��</center>
<table border="0"><tr><td valign="top"><img border="0" src="../ylts.gif"></td><td valign="bottom"><font color="#336699" size="2">&nbsp;&nbsp;
<%
        dim fs2, notestr 
        set fs2=server.createobject("MSWC.Nextlink")
        notestr=fs2.getnexturl("../notes.txt")
        response.write notestr
%><a href="../allnotes.asp" target=_blank><font size="2" color="#CC6600">&nbsp;[ȫ��]</font></a></font></td></tr></table>
                        
<center><%=rsboard("boardOwn")%></center>                      
<font color="#ffffff" size=1></font>         

<!--forum begin-->         
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd" width="200" align=center>
<tr><td>
<table border="0" width="100%">
<form action="searchall.asp" method="post" class="form1" target="_blank">
        <tr>
          <td width="100%" colspan="2" bgcolor="#FFFFFF" background="../cellbg2.gif" height="16" valign="bottom"><b><font color="#336699"><font size="2">&nbsp;</font></font></b><font color="#336699"><font size="2"><font color=#ffffff size="2"><b>��������</b></font>
<%
'������˷�����������ʾnewͼ�꣬����׼�������ʾ����
 set rs=server.createobject("adodb.recordset")
 sql="select * from bbs1 where display=0"
 rs.open sql,conn,1,1
 if not rs.eof then
   response.write "<a href=config.asp?boardID="
   response.write boardID 
   response.write " target=_blank><img border='0' src='images/NEW.GIF' title='������������'></a>"
 end if
 rs.close

%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ؼ���<input type="text" name="keyword" size="5" class="input2">
<input class="button1" type="submit" value="����" name="cmdTopic">
<input type="checkbox" name="bbs" size="5" class="input3" checked>��̳BBS
<input type="checkbox" name="text" size="5" class="input3" checked>վ��ȫ��
<input type="checkbox" name="doc" size="5" class="input3" checked>��������
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
       response.write "<p> ���棺"+session("boardtype")+"<br>�����ˣ�"+mailstr1+boardmaster+mailstr2+"<br>" 
       response.write " ����̳������ "
  	   response.write "<p><a href='Announce.asp?boardID="+boardID+"'>��������</a> <a href='list2.asp?boardID="+boardID+"'>ˢ��</a> "
            
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
       newdays=daysfornew  '������֮��Ϊ�µ�
       maxsubtopic=firstfollowlines-1 '���ӵĻظ����������Ŀ
       addupstr=""
'ii����һҳ��ʾ���У��ظ�Ҳ�����ڡ�iiҪС����̳�趨��ÿҳ����,ȡ����
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
            outtext=outtext&"<a href='Showlink.asp?boardid="&boardid&"&Rootid="&cstr(rs("Rootid"))&"&id="&cstr(rs("announceid"))&"' target='_blank'><img src='images/plus.gif' border='0' title='��ʾ��������'></a>&nbsp;"
          else
            outtext=outtext&"<img src='images/noplus.gif' border='0'>&nbsp;"
          end if
           
          if rs("specialzone")=1 then outtext=outtext&"<img src='images/expert.gif' title='ר��/�α���������������'border=0>"
          		  
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
            outtext=outtext & "[ͼ]"
			elseif instr(rs("append"),"<a href=")>0 then
                 outtext=outtext & "[��ַ]"
		  end if

          if trim(rs("DateAndTime"))<>"" and isdate(rs("DateAndTime")) then
             if cbool(cdate(rs("DateAndTime"))>(date()-newdays))=true then
                outtext=outtext &  "<img border='0' src='images/NEW.GIF' title='�����ĵ�'>"+chr(13)+chr(10)
             end if
          end if
          
'�������³���
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
	             bytestr="("+ cstr(rs("length"))+"��)"
      	     end if
           end if
 
        if rs("Length")=0 then
	     bytestr="(������)"
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
           outtext=outtext & "<a href=mailto:" & expertemail & ">" & "<img src=images/explogo.gif border=0 title='ר��/�α���������ʼ�'></a>" 
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


'�������п�����̳��ҳ���
       response.write "<table width=570 cellpadding='0' cellspacing='0'><tr><td><font size=1>&nbsp;</font></td></tr><tr align='right'><form action='firstpg.asp' method='post' class='form1' target='_self'><td bgcolor=#eeeeff><img border='0' src='images/zhuanti.gif'></td><td bgcolor=#eeeeff>&nbsp;</td><td  bgcolor=#eeeeff align='left'>"

       response.write "<a href=List.asp?boardID=1&catalog=0 target='_blank'><font size=2 color=#cc6600>ȫ��</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=1 target='_blank'><font size=2 color=#336699>���������ϵͳ����</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=2 target='_blank'><font size=2 color=#336699>���������ݿ�</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=3 target='_blank'><font size=2 color=#336699>�����������ʩ</font></a>&nbsp;<br>"
       response.write "<a href=List.asp?boardID=1&catalog=4 target='_blank'><font size=2 color=#336699>GIS</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=5 target='_blank'><font size=2 color=#336699>�칫�Զ���</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=6 target='_blank'><font size=2 color=#336699>��ý��</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=7 target='_blank'><font size=2 color=#336699>ϵͳά��</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=8 target='_blank'><font size=2 color=#336699>������ʵ</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=9 target='_blank'><font size=2 color=#336699>��������</font></a>&nbsp;<br>"
       response.write "<a href=List.asp?boardID=1&catalog=a target='_blank'><font size=2 color=#336699>ERP</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=b target='_blank'><font size=2 color=#336699>��̽</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=c target='_blank'><font size=2 color=#336699>����</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=d target='_blank'><font size=2 color=#336699>��̽����һ�廯</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=e target='_blank'><font size=2 color=#336699>���湤��</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=f target='_blank'><font size=2 color=#336699>��Ӫ����</font></a>&nbsp;<br>"
       response.write "<a href=List.asp?boardID=1&catalog=g target='_blank'><font size=2 color=#336699>��Ϣ��������������</font></a>&nbsp;"
       response.write "<a href=List.asp?boardID=1&catalog=z target='_blank'><font size=2 color=#336699>վ���������</font></a>"

       response.write "</td><td width=162 bgcolor=#f9f9dd align=center><font size=2 color=#cc6600><b>����������</b><BR></font><font color=#336699 size=2>����ר��/�α�ʹ��</font>"


'�����������������룬����ʾnewͼ�꣬����׼�������Ч
 dim rse
 set rse=server.createobject("adodb.recordset")
 sql="select * from experts where active=0"
 rse.open sql,conn,1,1
 if not rse.eof then
   response.write "<a href=config.asp?boardID="
   response.write boardID 
   response.write " target=_blank><img border='0' src='images/NEW.GIF' title='����������'></a>"
 end if
 rse.close
 response.write "<br><input type='hidden' name='hiddenflag' value='do456wangquan'><font size='2' color='#336699'>&nbsp;�û�</font><input type='text' name='expertnm' size='5' class='input4'><font size='2' color='#336699'>&nbsp;����</font><input type='password' name='expertpw' size='5' class='input4'> <input class='button1' type='submit' value='����'></form><a href='expreg.asp' target='_blank'></font>&nbsp;<img border='0' src='images/goto.gif' height=14><font color=#336699 size=2>������������</a>&nbsp;&nbsp;&nbsp;<a href='srtlq.asp' target='_blank'><img src='images/que1.gif' border=0>˵��</a></td></tr></table>"
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
  Response.Write "����̳�����ڣ�"
  
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
    <td width="91%" bgcolor="#f5f5f5"><font size="2" color="#666666">Ϊ�����о��ͽ���������ר�ſ����������̳�����������������ι�˾��Ϊ��������������ﹹ�벢�����ƶ��������ｨ���ʯ����ҵ��Ը����������ʯ����ҵ�����ֵ����Ｐ���о�������ͬ̽�������������ؼ����ͽ�����ԡ����ǻ�������ϵ�Ը���������ǹ�ͬ����������ʵ�֣���������������ʱ��������δ���������Ȱ�������ҵ�ĸ�������ʿ�������ۣ�</font></td>
  </tr>
<%
'������˼��������ϣ�����ʾnewͼ�꣬����׼�������ʾ
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
    <tr><td><img border="0" src="../docenter.gif"><% if newdl=1 then response.write "<a href=config.asp?boardID=1 target=_blank><img border='0' src='images/new.gif' title='������������'></a>" %>&nbsp;<a href="showdownload.asp" target="_blank"><img border="0" src="images/arrow.gif"></a></td></tr>
    
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
       if rs("specialzone")=1 then response.write "<img border=0 src='images/expert.gif' title='ר��/�α���������������'>"
response.write "<a title='"
response.write "���⣺"&rs("topic")&chr(13)
response.write "���ߣ�"&rs("author")&chr(13)
response.write "˵����"&rs("explain")
response.write "'>"
       response.write "<font size=2 color=#666666>"
       if rs("shorttopic")="" then
         response.write rs("topic")
       else
         response.write rs("shorttopic")
       end if
response.write "</a>"
       if rs("newornot")=1 then response.write "<img border='0' src='images/new.gif' title='�����ĵ�'>"
       if rs("important")=1 then response.write "<img border='0' src='images/important.gif' title='��Ҫ�ĵ�'>"
       if trim(rs("needpass"))<>"" then response.write "<img border='0' src='images/lock.gif' title='��Ҫ���룬����ϵ�����˻���̳����'>"
       if rs("format")<>"" then response.write "��"&rs("format")
       if rs("size")<>"" then response.write "��"&rs("size")
       response.write "</font></td><td align='right' valign='middle'><a href='"&rs("url")&"' target='_blank'><font size='2' color='#336699'>����</font></a><br>"
       rs.MoveNext
       i=i+1 
response.write "</td></tr>"
     loop
     rs.Close
response.write "<tr><td valign='bottom' colspan='2'><a href='showdownload.asp' target='_blank'><font size=2 color=#336699>>>ȫ�������б�</font></a>&nbsp;&nbsp;&nbsp;<a href='dlurlmng.asp' target='_blank'><font size=2 color=#336699>>>�������Ϲ����ɴ��������</font></a></td><tr>"  
response.write "</table></td></tr>"

    %>
    </table>
    </td>
  </tr>
</table>
<table border="0" width="100%">
  <tr>
    <td background="../cellbg.gif" bgcolor="#f5f5f5" height="16" colspan="3"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><a href="../smsszyt.htm" target="_blank"><font size="2" color="#336699">ʲô���������
      </font></a></td>
  </tr>
  <tr>
    <td colspan="3" bgcolor="#f5f5f5"><font size="2" color="#666666">��������(Digital Oilfield,                                         
      DO)���򵥵�˵�������ֻ��������ĳ������ʵ����ITƽ̨�ϵ������ʾ�������Դ�����ֵ��������ɴ���������1999��������ڸ����ϣ���������ɷ�Ϊ������������͹������������˼�������͹��������������ɳ�Ϊ�����������</font><a href="../smsszyt.htm" target="_blank"><font size="2" color="#336699">[��ϸ...]</font></a></td>
  </tr>
  <tr>
    <td background="../cellbg.gif" bgcolor="#f5f5f5" height="16" colspan="3"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><a href="../smsytntzy.htm" target="_blank"><font size="2" color="#336699">ʲô�������������壿</font></a></td>
  </tr>
  <tr>
    <td colspan="3" bgcolor="#f5f5f5"><font size="2"><font color="#666666">�����������壨Internetism�������������ԭ���γɵ�һ��˼����ϵ��������ָ���������á���ᡢ���Ρ����µȸ�����Ĺ������������ɹ���4���ؼ������ǣ����׵Ŀ����ԡ��߶ȵ�ͳһ�������������α߽�ͼ�Լ��Э�������Ҳ��������������˼��Ļ����۵㡣</font><a href="../smsytntzy.htm" target="_blank"><font color="#336699">[��ϸ...]</font></a></font></td>
  </tr>
</table>
</td>
  </tr>
  <tr>
    <td width="50%" valign="top" align="left">
      <table border="0" width="100%">
        <tr>
          <td width="100%" colspan="2" bgcolor="#FFFFFF" background="../cellbg.gif" height="16"><b><font color="#336699"><font size="2">&nbsp;</font></font></b><font color="#336699"><font size="2">ÿ��ר��/�α�����</font></font><font size="2" color="#666666">&nbsp;&nbsp;&nbsp;������Ҫ�໥�˽⣬������Ҫ��ͬ������������־���������ˣ�</font><font size="2" color="#336699">��ϵ</font><a href="mailto:wangq@daqing.com" target="_blank"><font size="2" color="#336699">������</font></a></td>
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
        response.write "/intro.htm' target=_blank><font color='#336699' size='2'>��ϸ����</font></a>"
        response.write "</font></td>"
      %>
        </tr>
      </table>
      <table border="0" width="100%">
        <tr>
          <td width="100%" bgcolor="#FFFFFF" background="../cellbg.gif" height="8"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">ר��/�α�</font>&nbsp;<font color=#666666 size=2>(�����ʾ�����������Ⱥ�)</font><font size="2" color="#FFFFFF"></font><font size="2" color="#FFFFFF"><a href='../qbbs/introall.asp' target='_blank'><font size=2 color=#336699>[ȫ��]</font></a>
            </font><font size="2" color="#666666">������λ��̳������������һ��Ŭ����</font><font size="2" color="#336699">��ϵ</font><a href="mailto:wangq@daqing.com" target="_blank"><font size="2" color="#336699">������</font></a></td>
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
          Comma_pos=Instr(brief,"��")
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
          <td width="100%" colspan="2" bgcolor="#FFFFFF" background="../cellbg.gif" height="17"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">ר������</font><font size="2" color="#FFFFFF">&nbsp;</font><font size="2" color="#666666"><img border="0" src="images/NEW.GIF" title="�����ĵ�"></font><font size="2" color="#666666">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
            ��ӭ��λר�Ұ����Ĵ�����������</font></td>
        </tr>
        <tr>
          <td width="47%" valign="top"><font size="2" color="#666666">1  
            <a href="http://www.internetism.org/experts/10/works/gjzx.doc" target="_blank">�������﹫˾��������</a>����ѧϼ��</font></td>
          <td width="53%" valign="top" ><font size="2" color="#666666">2  
            <a href="http://www.internetism.org/experts/10/works/sjck.doc" target="_blank">���￪�����ݲֿ��������ļ���ʵ��</a></font><font size="2" color="#666666">����ѧϼ��</font></td>
        </tr>
        <tr>
          <td  valign="top"><font size="2" color="#666666" >3  
            <a href="http://www.internetism.org/experts/1/works/sjzlymx.doc" target="_blank">����չ����������Ԫģ��</a></font><font size="2" color="#666666"><img border="0" src="images/important.gif" title="��Ҫ�ĵ�">�������ѣ�</font></td>
          <td  valign="top"><font size="2" color="#666666" >4  
            <a href="http://www.internetism.org/experts/9/works/shengli.rar" target="_blank">ʤ��������Ϣ����ܹ����о�</a></font><font size="2" color="#666666"><img border="0" src="images/important.gif" title="��Ҫ�ĵ�">���κ�ܣ�</font></td>
         </tr>
        <tr>
          <td  valign="top"><font size="2" color="#666666" >5  
            <a href="http://www.digitaloilfield.org.cn/downloads/swzgis.doc" target="_blank">ʯ����ҵGISӦ�õ���</a></font><font size="2" color="#666666"><img border="0" src="images/NEW.GIF" title="�����ĵ�"><img border="0" src="images/important.gif" title="��Ҫ�ĵ�">����ά־��</font></td>
          <td  valign="top"><font size="2" color="#666666" >6  
            <a href="http://www.internetism.org/downloads/ktkfyth.doc" target="_blank">��̽������Ϣһ�廯���Ƽ�����</a></font><font size="2" color="#666666"><img border="0" src="images/NEW.GIF" title="�����ĵ�"><img border="0" src="images/important.gif" title="��Ҫ�ĵ�">�����»���</font></td>
         </tr>
      </table>
      <table border="0" width="100%">
        <tr>
          <td width="100%" colspan="3" bgcolor="#FFFFFF" background="../cellbg.gif" height="16"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><a href="../onintnt.htm" target="_blank"><font size="2" color="#336699">����������ԭ���Ҫ</font></a><font size="2" color="#FFFFFF">&nbsp;&nbsp;</font><font size="2" color="#336699">&nbsp;</font><font size="2" color="#666666">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                     
            [������ԭ��������������˼�������]</font></td>
        </tr>
        <tr>
          <td width="33%"><font size="2" color="#666666"><a href="../onintnt.htm#1" target="_blank">1                             
            Internet���</a></font></td>
          <td width="33%"><font size="2" color="#666666"><a href="../onintnt.htm#2" target="_blank">2                             
            TCP/IPЭ��</a></font></td>
          <td width="34%"><font size="2" color="#666666"><a href="../onintnt.htm#3" target="_blank">3                             
            Internet�ĵ�ַ������</a></font></td>
        </tr>
        <tr>
          <td width="33%"><font size="2" color="#666666"><a href="../onintnt.htm#4" target="_blank">4                             
            Internet��Ӧ��</a></font></td>
          <td width="33%"><font size="2" color="#666666"><a href="../onintnt.htm#5" target="_blank">5                             
            �û��������������ӷ���</a></font></td>
          <td width="34%"><font size="2" color="#666666"><a href="../onintnt.htm#6" target="_blank">6                             
            CHINANET</a></font></td>
        </tr>
      </table>
      <table border="0" width="100%">
        <tr>
          <td width="100%" colspan="4" bgcolor="#FFFFFF" background="../cellbg.gif" height="16"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">��زο���������</font><a href="../onintnt.htm" target="_blank"><font size="2" color="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                     
            </font></a><font color="#666666" size="2">[��������δ����������ɣ��������飬������������ϵ]</font></td>
        </tr>
        <tr><td><br></td></tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.geosociety.org.cn/" target="_blank"><img border="0" src="../zgdzxh.gif" width="109" ><br>
            <font color="#666666" size="2">�й�����ѧ��</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.cgs.org.cn/" target="_blank"><img border="0" src="../zgdqwlxh.gif" width="108" ><br>
            <font color="#666666" size="2">�й���������ѧ��</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.api.org/" target="_blank"><img border="0" src="../apisyxh.gif" width="108" ><br>
            <font color="#666666" size="2">APIʯ��ѧ��</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.spwla.org/" target="_blank"><img border="0" src="../cjjxh.gif" width="104" ><br>
            <font color="#666666" size="2">�⾮��Э��</font></a></td>
        </tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.schlumberger.com" target="_blank"><img border="0" src="../slb.gif" width="109" height="38"><br>
            <font color="#666666" size="2">˹�ױ�л</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.lgc.com" target="_blank"><img border="0" src="../landmark.jpg" width="108" height="38"><br>
            <font color="#666666" size="2">�������</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.spe.org/" target="_blank"><img border="0" src="../spe.gif" width="108" height="43"><br>
            <font color="#666666" size="2">SPE</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.jurassic.com.cn/" target="_blank"><img border="0" src="../jurassic.gif" width="104" height="38"><br>
            <font color="#666666" size="2">٪�޼�</font></a></td>
        </tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.saic.com" target="_blank"><img border="0" src="../saic.gif" width="109" height="38"><br>
            <font color="#666666" size="2">SAIC</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.petrooverseas.com" target="_blank"><img border="0" src="../pto-logo.jpg" width="108" height="43"><br>
            <font color="#666666" size="2">�޼�ʯ��</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.digitalearth.net.cn/" target="_blank"><img border="0" src="../szdqicon.gif" width="108" height="43"><br>
            <font color="#666666" size="2">���ֵ���</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.china001.com/" target="_blank"><img border="0" src="../szzglogo.gif" width="104" height="33"><br>
            <font color="#666666" size="2">�����й�</font></a></td>
        </tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="48"><a href="http://www.daqing.com" target="_blank"><img border="0" src="../dqlogo.jpg" width="116" height="28"><br>
            <font color="#666666" size="2">��������</font></a></td>
          <td width="25%" valign="bottom" align="center" height="48"><a href="http://www.petrost.com" target="_blank"><img border="0" src="../petrost_logo.gif" width="88" height="33"><br>
            <font color="#666666" size="2">ʯ�Ϳ�ѧ�뼼����̳</font></a></td>
          <td width="25%" valign="bottom" align="center" height="48"><a href="http://www.ceibs.edu/forum/index_c.html#1" target="_blank"><img border="0" src="../zoglltlg.gif" width="94" height="31"><br>
            <font color="#666666" size="2">��ŷ������̳</font></a></td>
          <td width="25%" valign="bottom" align="center" height="48"><a href="http://www.topoint.com.cn/" target="_blank"><img border="0" src="../zdwlogo.gif" width="94" height="28"><br>
            <font color="#666666" size="2">֧����</font></a></td>
        </tr>
        <tr>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.petroleum.com.cn/" target="_blank"><img border="0" src="../zgsyxxw.gif" width="109" ><br>
            <font color="#666666" size="2">�л�ʯ����Ϣ��</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://ogj.pennnet.com/home.cfm" target="_blank"><img border="0" src="../oil_gasj.gif" width="108" ><br>
            <font color="#666666" size="2">OIL&GAS JOURNAL</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.worldoil.com/" target="_blank"><img border="0" src="../worldoil.gif" width="108" ><br>
            <font color="#666666" size="2">WORLDOIL</font></a></td>
          <td width="25%" valign="bottom" align="center" height="58"><a href="http://www.petrochina.com.cn/" target="_blank"><img border="0" src="../petrochina.jpg" width="104" ><br>
            <font color="#666666" size="2">�й�ʯ��</font></a></td>
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
    <td background="../cellbg.gif" bgcolor="#FFFFFF" height="16" colspan="3"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">��������ԭ����</font><font color="#666666" size="2"><img border="0" src="images/NEW.GIF" title="�����ĵ�">&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
  </tr>
  <tr>
    <td height="3" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl1.htm" target="_blank"><font color="#666666" size="2">1 
      �쵼��Ϊ����</font></a></font></td>
    <td height="3" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl2.htm" target="_blank"><font color="#666666" size="2">2 
      �����ֶβ���</font></a></font></td>
    <td height="3" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl3.htm" target="_blank"><font color="#666666" size="2">3 
      ���߷�������</font></a></font></td>
  </tr>
  <tr>
    <td height="2" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl4.htm" target="_blank"><font color="#666666" size="2">4 
      ���ز�������</font></a></font></td>
    <td height="2" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl5.htm" target="_blank"><font color="#666666" size="2">5 
      ��Ч��������</font></a></font></td>
    <td height="2" bgcolor="#f5f5f5"><font color="#666666"><a href="../gldl/gldl6.htm" target="_blank"><font color="#666666" size="2">6 
      �������</font></a></font></td>
  </tr>





      
        <tr><td colspan="3">
      <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#dddddd" bgcolor=#ffffff align=center>
      <tr><td><table border="0" >
        <tr>
          <td width="100%" colspan="2" background="../arthurzl.gif" height="5"><font size="2" color="#336699"><b><font size="4">&nbsp;</font></b><font size="2" color="#CC6600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
            ��ש����&nbsp;���ָ��</font><font color="#666666" size="2">&nbsp;<a href="../experts/7/works/tzwj.htm" target="_blank"><font size="2" color="#336699">&nbsp;ȫ��...</font></a></font>
          </td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9fff9><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9fff9><a href="../szyt.htm" target="_blank"><font size="2" color="#666666">�������������������������</font></a></td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9f9f9 valign="top"><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f9f9><font color="#666666"><a href="../paper-do.htm" target="_blank"><font color="#666666" size="2">���������������ι�˾��������ģʽ�뷢չս���о���<font color="#336699" size="2">ժҪ</font>��<img border="0" src="images/important.gif" title="��Ҫ�ĵ�"><img border="0" src="images/important.gif" title="��Ҫ�ĵ�"><br>
            The Research on the Modes and the Developing Strategies of&nbsp;&nbsp;                  
            Digital Oilfield of Daqing Oilfield Co., Ltd.(<font color="#336699" size="2">Abstract</font>)<br>                            
            </font></a></font><font size="2" color="#336699">ע</font><font color="#666666" size="2">������Ϊ�����˵�ѧλ���ģ���ĿǰΪֹ����������������Ϊȫ�������֮һ��<br>
            </font><a href="../downloads/DQDO.doc" target="_blank"><font color="#336699" size="2">���/����ȫ��</font></a><font color="#666666" size="2">��MS                  
            Word2000��ʽ��2.09M��<br>
            </font><a href="../downloads/DQDOA.doc" target="_blank"><font color="#336699" size="2">���ľ����</font></a><font color="#666666" size="2"></font><font color="#666666" size="2"> 
            </font><font color="#666666" size="2">360K��</font><a href="../downloads/bydb.ppt" target="_blank"><font color="#336699" size="2">��ҵ���PPT</font></a><font color="#666666" size="2"></font><font color="#666666" size="2"> 
            </font><font color="#666666" size="2">3.76M</font></td>  
        </tr>
        <tr>
          <td width="14" bgcolor=#fff9f9><font color="#336699">*</font></td>
          <td width="724" bgcolor=#fff9f9><font color="#666666"><a href="../internetism.htm" target="_blank"><font color="#666666" size="2">������ԭ��Թ���˼�����ʾ</font></a>&nbsp;</font></td>
        </tr>
        <% display_if_expert ("<tr><td width='14' bgcolor=#f9f9dd><font color='#336699'>^</font></td><td width='724' bgcolor=#f9f9dd><a href='../downloads/xxhgrxf.htm' target='_blank'><font size='2' color='#666666'>����Ϣ������ĸ����뷨</font><img border='0' src='images/NEW.GIF' title='�����ĵ�'></a></td></tr>") %>
        <tr>
          <td width="14" bgcolor=#f9f9ff><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f9ff><a href="../xxhcjfx.htm" target="_blank"><font size="2" color="#666666">����������Ϣ�����������������Բ�</font><img border="0" src="images/NEW.GIF" title="�����ĵ�"></a></td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9f0f9><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f0f9><a href="../downloads/szytjbjg.doc" target="_blank"><font size="2" color="#666666">������������ܹ���<font color="#cc6600">�ٴ�</font>�޸�<img border="0" src="images/NEW.GIF" title="�����ĵ�">(2004.3.12)</font></a></td>
        </tr>
        
        <tr>
          <td width="14" bgcolor=#f9f9dd valign="top"><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f9dd><font color="#666666" size="2">���������������ι�˾������������Ƭ<img border="0" src="images/NEW.GIF" title="�����ĵ�"><br>
            </font><a href="../downloads/dqdodemo.exe" target="_blank"><font color="#336699" size="2">����/�ۿ�</font></a><font color="#666666" size="2">��EXE�ļ���92M������</font></td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9ffff valign="top"><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9ffff><font color="#666666" size="2">������������(PPTƬ��)</font><a href="../downloads/gyszyt.ppt" target="_blank"><font color="#336699" size="2">
            ����/�ۿ�</font><font color="#666666" size="2">,</font></a><font color="#666666" size="2">4.03M</font></td>
        </tr>
        <tr>
          <td width="14" bgcolor=#f9f9ff valign="top"><font color="#336699">*</font></td>
          <td width="724" bgcolor=#f9f9ff><font color="#666666" size="2">����д�ÿƼ�����(PPTƬ��)</font><a href="../downloads/zyxhkjlw.ppt" target="_blank"><font color="#336699" size="2">
            ����/�ۿ�</font><font color="#666666" size="2">,</font></a><font color="#666666" size="2">200K</font></td>
        </tr>
      </table></td></tr>
      </table>
      </td></tr>
      
      </table>

<table>
<tr><td background="../cellbg.gif" bgcolor="#f5f5f5" height="16" colspan="3"><b><font size="2" color="#FFFFFF">&nbsp;</font></b><font size="2" color="#336699">ѧ���ڿ�
      </font><font size=2 color=#666666>&nbsp;&nbsp;������ <a href="http://www.petrost.com" tartget="_blank"><font color="#336699">ʯ�Ϳ�ѧ�뼼����̳</font></a> �ṩ</font></td></tr>
<tr><td width=55%>
<a href="http://www.petrost.com/dispbbs.asp?boardid=19&id=831&star=1#831" target="_blank"><font color="#666666" size=2>��ʯ��ѧ����<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=80&page=11" target="_blank"><font color="#666666" size=2>����Ȼ����ҵ��<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?BoardID=19&ID=801&replyID=3212&skin=1" target="_blank"><font color="#666666" size=2>��ʯ����̽��<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardid=19&ID=830&replyID=830" target="_blank"><font color="#666666" size=2>��ʯ�ͺͻ����豸��<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardid=19&id=837" target="_blank"><font color="#666666" size=2>����Ȼ�������ѧ��<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardid=19&id=904" target="_blank"><font color="#666666" size=2>���ܵ��������豸��</font></a>
</td>
<td>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=33&page=1" target="_blank"><font color="#666666" size=2>������ʯ��ѧԺѧ����<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=96&page=1" target="_blank"><font color="#666666" size=2>��ʯ����̽������<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=154&page=1" target="_blank"><font color="#666666" size=2>��ʯ����ɹ��ա�<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=791&page=1" target="_blank"><font color="#666666" size=2>����ʯ����ѧ��־��<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=796&page=1" target="_blank"><font color="#666666" size=2>�����ͼ����빤�̡�<br></font></a>
<a href="http://www.petrost.com/dispbbs.asp?boardID=19&ID=810&page=1" target="_blank"><font color="#666666" size=2>����������湤�̡�</font></a>
</td>
</tr></table>
      <p>
        <font color="#336699" size="2">��Ȩ���� Copyright &copy; 2003-2004                
      </font><font size="2" color="#CC6600"><br>���������������ι�˾<br>����������̳[DigitalOilfield.org.cn]</font><font color="#336699" size="2"> <br>
      All Rights Reserved&nbsp; ��ӭת�ء����ӣ���ע�����Ա���̳<a href="../heroes.htm" target="_blank">��</a><br>     
        ����֧�֣�</font><a href="mailto:zhangwl@daqing.com" target="_blank"><font color="#336699" size="2">����ϵ��̳���� Marrist      
      </font></a><font color="#336699" size="2"> <br>
        <br>
      </font><font size="2" color="#CC6600">&gt;&gt;</font><a href="../emlpage.htm" target="_blank"><font size="2" color="#666666">������̳�ڲ��ʼ�ϵͳ&nbsp;(Web����)</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp<script src="http://www.internetism.org/accounter/ajcount.asp?style=icon"></script>
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
        <p align="center">��</td>
    </tr>
    <tr>
      <td width="900" height="3"></td>
    </tr>
  </table>
  </center>
</div>
</table>
</body>
