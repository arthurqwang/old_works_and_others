<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/cfmexp.inc"-->
<%
dim specialstr
specialstr=""
if isexp=0 and request.cookies("adminok")="" then specialstr=" and specialzone=0"	  
%>
<%

   dim AnnounceID,anID
   dim RootID
   dim BoardID
   dim ID,ID2
   BoardID=Request("boardID")
   ID2=cint(Request("ID"))
   ID=cint(Request("RootID"))
   Response.cookies("newindex")=BoardID
   Response.cookies("indexname")=ID
   AnnounceID=Cstr(Request("ID"))
   RootID=request("RootID")
   anID=request("ID")
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
   sql="update bbs1 set hits=hits+1 where announceID="&ID2
   rs.open sql,conn,3,3
   sql="select * from bbs1 where AnnounceID="&ID2&specialstr
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
  response.write "<img src='images/light.gif' border='0'><font size=2 color=#666666>[ר��/�α�����������] ��ǰ��ݣ�"&expertnm&"("&realnm&")���б��<img src='images/expert.gif' border=0>�Ĳ���Ϊ�����������ݡ�&nbsp;</font>"
  response.write "&nbsp;&nbsp;<a href=exitexpert.asp><img src='images/exit.gif' border=0><font size=2 color=#666666>�˳�</font></a><a href=exppwchg.asp target='_blank'>&nbsp;&nbsp;<img src='images/key.gif' border=0><font size=2 color=#666666>�޸�ע����Ϣ</font></a><a href=othexp.asp target='_blank'>&nbsp;&nbsp;<img src='images/othexp.gif' border=0><font size=2 color=#666666>��ϵ����ר��/�α�</font></a>"
end if
%>
</center>
<font size='<%=rsboard("fontsize")%>' color='<%=rsboard("fontcolor")%>'>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></p></center>
<%
if err.number<>0 then 
'      response.write "�����ݿ�ʧ�ܣ�"&err.description
   response.write "<center><p><font color=#000000 size=3 ><b>ר��/�α�����������</b><br><br>���Ľ���ר��/�α��Ķ�������δ��¼�����¼��</font>" 
   response.write "<form action='firstpg.asp' method='post' class='form1' target='_self'>"
   response.write "<input type='hidden' name='hiddenflag' value='do456wangquan'><font size='3' color='#336699'>&nbsp;�û�</font><input type='text' name='expertnm' size='5' class='input4'><font size='3' color='#336699'>&nbsp;����</font><input type='password' name='expertpw' size='5' class='input4'> <input class='button1' type='submit' value='����'></form><a href='expreg.asp' target='_blank'></font>&nbsp;<img border='0' src='images/goto.gif' height=14><font color=#336699 size=3>�������</a>"
   response.write "<br><br><table width=300 border=0><tr><td>˵���� <font size=2 color=#336699><font size=3 color=#cc6600>����[ר��/�α�����������]</font><br><br>" 
   response.write "����ĳЩ��Ϣ�͹۵�Ƚ����У������˹��������ܾ�����С��Χ�����ۣ��������[ר��/�α�����������]�����λ̳��������⡣��̳ר��/�α����Խ���(��Ҫ�û���������)��<br>"
   response.write "��ϣ�������������ۣ�����ϵ�����˻����������ۡ�<br><br>" 
   response.write "ע����������ӵ������Ȩ����<br>"
   response.write "(1)������˹������۵���Ϣ�����������ۡ�<br>"
   response.write "(2)����С��Χ�������Ҫ���ϡ�<br>"
   response.write "(3)ֱ������̳���ĳ�Ա(ר��)ȡ����ϵ��<br>"
   response.write "(4)�������Ӳ�����顣<br>"
   response.write "(5)���Ȳ�����ֻ��</font>"
   response.write "</td></tr></table></p></center>"
else
 if rs.eof and rs.bof  then
   response.write "<center><P>�����ӵ������Ҳ���</P></center>"
 else
   dim UserName
   dim useremail
   dim Topic
   dim body
   dim dateTimeStr
   'dim layer
   dim orders
   dim parentid
   dim ip
   dim append
   
   dim FoundError
   dim ErrMsg
   dim hits
   relayer=rs("layer")
   username=rs("username")
   useremail=rs("useremail")
   topic=rs("topic")
   body=rs("body")
   dateTimeStr=rs("dateAndTime")
   'layer=rs("layer")
   orders=rs("orders")
   parentid=rs("parentid")
   ip=rs("ip")
   append=rs("append")
   hits=rs("hits")

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



   response.write "<p align='center'><font color=darkblue><strong>"
   if rs("specialzone")=1 then response.write "<img src='images/expert.gif' border='0'>"
   if pwsonchsys then
      showBody Topic
   else
      response.write Server.HTMLEncode(Topic)
   end if
   response.write "</strong></font></p> "+chr(13)+chr(10)
   response.write "<hr size='1'>"+chr(13)+chr(10)

   showbody(body)
   
   if  not Isnull(append)and append<>"" then
   response.write append
   end if
   
   rs.close
   set rs=nothing

 set rsUserSign=server.createobject("adodb.recordset")
 signsql="select sign from user where username='"&username &"'"
 rsUserSign.open signsql,conn,1,1
if err.number<>0 then 
      response.write "���ݿ����ʧ�ܣ�"&err.description&err.number
else
    if not rsUserSign.eof  then
      sign=rsUserSign("sign")
      response.write "<p>" & sign
    end if
  rsUserSign.close
  set rsUserSign=nothing
end if

   if Trim(UserEmail)<>"" then 
      response.write "<p align=center>������<a href='mailto:"+Server.HTMLEncode(UserEmail)+"'>"
      if pwsonchsys then
        if isexpert=1 then
	     showBody display_username&"("&UserName&")"
        else
         showbody Username
        end if
	  else
	   	 response.write Server.HTMLEncode(UserName)
	  end if
	  response.write "</a><img src=images/mailto.gif>"
          response.write "��"+DateTimeStr+"����.</font></p><p>"+chr(13)+chr(10)
   else
	  response.write "<p align=center>������" 
	  if pwsonchsys then
        if isexpert=1 then
	     showBody display_username&"("&UserName&")"
        else
         showbody Username
        end if
	  else
	  	response.write Server.HTMLEncode(UserName)
	  end if
	  response.write "��"+DateTimeStr+"����.</font></p><p>"+chr(13)+chr(10)
   end if
%>

<hr size="1">
<% 
   dim rsfollow
   dim selstr
   selstr=""

   set rsfollow=server.createobject("adodb.recordset")
   sql="select AnnounceID,boardID from bbs1 where boardID="+boardID+" and rootID="+rootID+" and status<>4 ORDER BY announceID desc "
   rsfollow.open sql,conn,1,1

   if not  rsfollow.eof then  '�л���
   response.write "<p><font size='4'>��������</font><br>"
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

	      if trim(rsfollow("announceID"))=trim(anID) then outtext=outtext&"<img src='images/here.gif' border=0 title='��ǰ����'>"        
          if pwsonchsys then
             outtext=outtext & htmlencode(rsfollow("Topic"))
          else
             outtext=outtext & Server.HTMLEncode(rsfollow("Topic"))
          end if
          outtext=outtext&"</a>"
		  if instr(rsfollow("append"),"<img src=")>0 then
            outtext=outtext & "[ͼ]"
			elseif instr(rsfollow("append"),"<a href=")>0 then
                 outtext=outtext & "[��ַ]"
		  end if

          '�Ƿ�������
		  'dim t
		  't=rsfollow("announceID")
		  't="<SCRIPT language='JavaScript'>IsNew("& t & ")</SCRIPT>"
		  'outtext=outtext & t
          'if trim(rsfollow("DateAndTime"))<>"" and 'isdate(rsfollow("DateAndTime")) then
           '  if cbool(cdate(rsfollow("DateAndTime"))>(date()-1))=true then
            '    outtext=outtext &  "<img 'src='images/new.gif'>"+chr(13)+chr(10)
             'end if
          'end if
          
'�������³���
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
	             bytestr="("+ cstr(rsfollow("length"))+"��)"
      	     end if
           end if
 
 if rsfollow("Length")=0 then
	     bytestr=" (������)"
 end if	

'		if pwsonchsys then
'             outtext=outtext & "��<b>" & htmlencode(rsfollow("UserName"))
'          else
'             outtext=outtext & "��<b>" & Server.HTMLEncode(rsfollow("UserName") ) 
'          end if
'  
'		  outtext=outtext & "</b>��<font color=green><i>"&rsfollow("DateAndTime")&"</i></font>["+"<font color=red>"&rsfollow("Hits")&"</font>] "+bytestr
'
'         
'          rsfollow.movenext
'          response.write outtext
'          outtext=""
'       loop


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
           outtext=outtext & "<a href=mailto:" & expertemail & ">" & "<img src=images/explogo.gif border=0 title='ר��/�α���������ʼ�'></a>" 
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

<center>[ <a href="#re">�ظ�����</a> ]
[ <a href="list.asp?BoardID=<%=boardid%>">�������</a> ]
[ <a href="Javascript:window.close();">�رձ�����</a> ] 
[<a href="edit.asp?action=manage&AnnounceID=<%=AnnounceID%>&boardID=<%=rsboard("boardid")%>" target='_blank'>�����˱༭����</a>] [<a href="edit.asp?action=author&AnnounceID=<%=AnnounceID%>&boardID=<%=rsboard("boardid")%>&Author=<%=Username%>" target='_blank'>���߱༭����</a>] [���<%=hits%>��]</center>
<hr size=1 width=95%>

<br><font color="darkblue"><strong><a name="re">�ظ���</a></strong>
<% if not(instr(topic,"�ظ�:")>0) then%>
<%=htmlencode2(topic)%>
<%else%>
<%display topic%>
<%end if%>
</font></p>

<form action="SaveReAnnounce.asp" method="POST" name="frmAnnounce">
  <input type="hidden" name="followup" value="<%=AnnounceID%>">
  <input type="hidden" name="rootID" value="<%=RootID%>">
  <input type="hidden" name="boardID" value="<%=rsboard("boardid")%>">
  <div align="center"><center>
<table cellspacing='0' cellpadding='0' border="0"><tr>
<td valign="top">
<table border="0" cellpadding="1" cellspacing="1">
<tr><td valign="top" align="center" colspan="2"></td></tr>
<tr><td><font size=-1 color='#663399'></font></td>
<td><font size=-1 color='#663399'></font></td></tr>
<tr><td><font size=-1 color='#663399'></font></td>
<td><font size=3 color='#663399'></font></td></tr></table></td>

<td valign="top" width="58%">

<table cellspacing='0' cellpadding='0' border="0" width='800'>
<%
dim verifycode, tu(15)
if isexp<1 then
  response.write "<tr><td><font size='' color='#663399'>�û�:</font></td><td>"
  response.write "<input type=text name='username' size=10 maxlength='20' value='"
  response.write request.cookies("userinfo")("UserName")
  response.write "' tabindex='1'>"
  response.write "<font size='2' color='#663399'>��һ�η����Զ�ע��Ϊ<font size='2' color='#cc6600'>һ���û�</font>����ϣ��ע��Ϊ<font size='2' color='#cc6600'>[ר��/�α�]</font>���뵽<a href='expreg.asp' target='_blank'><u>����������</u></a>���롣</font></td></tr>"
  response.write "<tr><td><font size='' color='#663399'>����:</font></td><td>"
  response.write "<input type=password name='passwd' size=10 maxlength='20' value='"
  response.write request.cookies("userinfo")("Password")
  response.write "' tabindex='2'>"
else
  response.write "<br><font size='' color='#663399'>��ǰ���: </font><font color=#cc6600>"&realnm&"</font><font size=2>("&expertnm&":ר��/�α�)</font><font color=#336699 size=2>  �粻ϣ����ר��/�α���ע��̳����ݷ��ԣ����˳� [ר��/�α�����������]��������������Ҫ��顣</font><br>"
  response.write "<input type=hidden name='username' value='"
  response.write expertnm&"'>"
  response.write "<input type=hidden name='passwd' value='"
  response.write expertpw&"'>"
end if

'��֤��
  response.write " <font size='' color='#663399'>��֤��:</font>"
  response.write "<input type=hidden name='verifycode1' size=6 maxlength='6' value='"
  randomize 
  tu(1)="byei89hh"  '0
  tu(2)="jk6s8gy2"
  tu(3)="98hu6723"
  tu(4)="rt265ww4"
  tu(5)="4i67tntc"
  tu(6)="op45ghes"
  tu(7)="jvcdt55u"
  tu(8)="h8763hbd"
  tu(9)="hdh97dhd"
  tu(10)="56t8bks"   '9
  verifycode=Int(RND(1)*8000)+1000
  verifycode= (verifycode+437)*17
  response.write verifycode
  response.write "'>"
  response.write "<input type=text name='verifycode2' size=6 maxlength='6'>"
  response.write "<img src='images/" & cstr(tu(1+cint(mid(cstr(verifycode/17-437),1,1)))) & ".jpg' border='0'>"
  response.write "<img src='images/" & cstr(tu(1+cint(mid(cstr(verifycode/17-437),2,1)))) & ".jpg' border='0'>"
  response.write "<img src='images/" & cstr(tu(1+cint(mid(cstr(verifycode/17-437),3,1)))) & ".jpg' border='0'>"
  response.write "<img src='images/" & cstr(tu(1+cint(mid(cstr(verifycode/17-437),4,1)))) & ".jpg' border='0'>"

%>

</td>
</tr>
<tr><td><font size='' color='#663399'>����:</font></td><td><input type=text name='subject' size=60 maxlength="70" tabindex="3"><input type=submit value='����'  tabindex="5"><input type=submit name=button value="�˳�"></td>
</tr><tr><td><font size='' color='#663399'>����:</font></td><td><textarea COLS=100 ROWS=20 name='body' tabindex="4"></textarea></td>
</tr><tr><td colspan="2"><font size='' color='#663399'>����MIDI:<input type=text name='midi' size=30 value="http://"></font>
<font size='' color='#663399'> ͼƬURL:<input type=text name='img' size=30 value="http://"></font>
<input type=submit value='����'><input type=submit name=button value="�˳�" ></td>
</tr><tr><td colspan="2"><font size='' color='#663399'>��������:<input type=text name='url_title' size=30 value=""></font>
<font size='' color='#663399'>����URL:<input type=text name='url' size=30 value="http://"></font>
<input type=reset value="����"><br>
<font size='' color='#663399'>�ʼ���ַ:<input type=text name='email' size=50 value="<%=request.cookies("userinfo")("Useremail")%>"></font><br>
<p>
</td></tr>
</table>
</td>
<td width="27%" valign="top">
<% if syssayface=1 then%>
<input type="radio" value="smiley" name="Expression" checked>
   <img src="IMAGES/smiley.gif" width="15" height="15"><br>
<input type="radio" name="Expression" value="sad">
   <img src="IMAGES/sad.gif" width="16" height="16"><br>
<input type="radio" name="Expression" value="angry">
   <img src="IMAGES/angry.gif" width="15" height="15"><br>
<input type="radio" name="Expression" value="13">
   <img src="IMAGES/13.gif" width="15" height="15"><br> 
<input type="radio" name="Expression" value="14">
   <img src="IMAGES/14.gif" width="15" height="15"><br> 
<input type="radio" name="Expression" value="15">
   <img src="IMAGES/15.gif" width="15" height="15"><br>
<input type="radio" name="Expression" value="16">
   <img src="IMAGES/16.gif" width="15" height="15"> <br>
<input type="radio" value="18" name="Expression">
   <img src="IMAGES/18.gif" width="15" height="15"> <br>
<input type="radio" name="Expression" value="17">
<img src="IMAGES/17.gif" width="15" height="15"><br>
<input type="radio" name="Expression" value="19"><img
          src="IMAGES/19.gif" width="15" height="15"> <br>
		  <input type="radio" name="Expression"
          value="20"><img src="IMAGES/20.gif" width="15" height="15"><br>
		  <input type="radio"
          name="Expression" value="21"><img src="IMAGES/21.gif" width="15" height="15"> <br>
		  <input
          type="radio" name="Expression" value="22"><img src="IMAGES/22.gif" width="15" height="15"><br> 
          <input type="radio" name="Expression" value="23"><img src="IMAGES/23.gif" width="15"
          height="15">
		  <% end if%>
		  </td>
</tr></table>
  </center></div>
</form>
<%
  end if
 end if
'rs.close
response.write boardfoot
rsboard.close   
%>
</body>
</html>
