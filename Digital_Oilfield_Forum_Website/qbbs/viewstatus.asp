<%@ LANGUAGE="VBSCRIPT" %>
<%option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/chkstr.inc"-->
<!-- #include file="inc/cfmexp.inc"-->

<%
dim specialstr
specialstr=""
'if isexp=0 then specialstr=" and specialzone=0"	  
%>

<HTML>
<HEAD><TITLE>��Ĳ�ѯ���</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="lun.css">
</HEAD>
<BODY leftmargin="10" topmargin="10" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p><h3><strong>������</strong></h3></center>
<%   
   dim sql,rs
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
   itype=request("type")
   if request("boardID")<>"" then boardID=request("boardID")
   if request("type")<>"" then itype=request("type")
   sql="select Boardtype,Boardname from board where boardID="&cstr(boardID)
   set rs=server.createobject("adodb.recordset")
   rs.open sql,conn,1,1
   if not (rs.bof and rs.eof) then
      boardtype=rs("Boardtype")
      boardname=rs("Boardname")
   end if
   rs.close
   
'   response.write "<font size='-1'><strong>����������̳���Ӽ���</strong></font> "
'   response.write "<a href='Announce.asp?boardID="&boardid&"'>��������</a> <a href='List.asp?boardID="&boardid&"'>�������</a> <br>"+chr(13)+chr(10)
   if  itype="" OR BoardID=0 then 
	     response.write "<center><big>û�������ѯ������:o(</big></center>"+chr(13)+chr(10)
   else
select case itype
          case 1 '����
            sql="select * from bbs1 where status=1 and display=1"&specialstr&" and boardID="&cstr(boardID)&" ORDER BY announceID desc "
          case 2 'top
		    sql="select * from bbs1 where status=2 and boardID="&cstr(boardID)&" ORDER BY announceID desc "
		  case 3 'ͶƱ
            sql="select * from bbs1 where status=3 and boardID="&cstr(boardID)&" ORDER BY announceID desc "
		  case 4 '׼��ɾ��
		      sql="select * from bbs1 where status=4 and boardID="&cstr(boardID)&" ORDER BY announceID desc "
end select 
       rs.open sql,conn,1,1
       if rs.eof and rs.bof then
         response.write "<center><big>û����Ӧ������:o(</big></center>"+chr(13)+chr(10)	
        else
         '------------------------------------------------------------------------
         response.write " <center><FONT SIZE='-1'>��ѯ������ҵ� "&cstr(rs.recordcount)&"�������������</font></center>"+chr(13)+chr(10)
	     response.write "<ul>"+chr(13)+chr(10)
	     rs.movefirst
	     do while not rs.eof
         response.write "<li>"
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
	     t=" (������)"
          else 
             t=" "
	  end if
	  if instr(rs("append"),"<img src=")>0 then
             t=t & "[ͼ]"
			elseif instr(rs("append"),"<a href=")>0 then
             t=t & "[��ַ]"
		  end if
         
                  if pwsonchsys then
	                 showBody rs("Topic")
                  else
                     response.write Server.HTMLEncode(rs("Topic"))
                  end if
	 response.write "</a>"
	    if trim(rs("DateAndTime"))<>"" and isdate(rs("DateAndTime")) then
               if cbool(cdate(rs("DateAndTime"))>(date()-1))=true then
                response.write  "<img src='images/new.gif' border=0>"+chr(13)+chr(10)
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
	     bytestr=" (������)"
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
                    response.write "<a href=mailto:" & expertemail & ">" & "<img src=images/explogo.gif border=0 title='ר��/�α���������ʼ�'></a>" 
                  end if

                  response.write ") <i><font color='green'>"+ rs("dateAndTime")+"</font></i> " +"<font color='darkblue'>[ID:"+cstr(rs("announceID"))+" ���:"+cstr(rs("hits"))+"]</font> " + bytestr + " <font color='red'>(" + Cstr(rs("child"))+")</font>"+chr(13)+chr(10)
		        end if
		        response.write "</li>"+chr(13)+chr(10)
	            rs.movenext
	        loop
	      response.write "</ul>"+chr(13)+chr(10)
         
      end if
      rs.close
  end if
   
%>
<br>
<p></p>
</body>
</html>
