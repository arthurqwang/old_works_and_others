<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit%>
<!--#include file="newconn.asp"-->
<!-- #include file="inc/char.inc" -->
<!-- #include file="inc/tree.inc"-->
<%
if request.cookies("adminok")="" then
  response.redirect "index.html"
end if

if session("boardsetok")<>"yes" and request("BoardID")="" then
 response.redirect "index.html"
end if
 
on error resume next

 function chk(str)  '  �� checkboxû��ѡ��ʱ���ᴫ�ݿ�ֵ��������ΪĬ�ϵ�0
    if str="" or isnull(str) or (not isnumeric(str)) then str="0"
	chk=cint(str)
 end function

 function ChkColor(str) '����ǲ�����ȷ��6λ16������ɫֵ����ʽ #CFA789
   if str="" then exit function
   if left(str,1)<>"#" then str="#" & str
   if len(str)<>7 then 
   str=""  '��ʵǰ��0����ʡ��
   exit function
   end if
   str=ucase(str)
   dim n,i
   n=len(str)
   for i=2 to n
        if not (chr(mid(str,i,1))>=97 and  chr(mid(str,i,1))<=102 and chr(mid(str,i,1))>=48 and chr(mid(str,i,1))<=56 ) then
        str=""
        exit for
		end if
   next
   ChkColor=str
 end function

 function ChkURL(str)  '��鱳��ͼƬ�Ƿ�����ȷ��ͼƬ��ַ
    if instr(2,lcase(str),".gif")<=0 and  instr(2,lcase(str),".jpg")<=0 and instr(2,lcase(str),".jpeg")<=0 then str=""
 if str<>"" and lcase(left(str,7))<>"http://" then str=str & "http://"
 ChkURL=str
 end function

 
 dim sql,rs,boardsql,boardName,boardtype,chkspace,chksayface,chknoonline
 boardID=request("BoardID")
 set rs=server.createobject("adodb.recordset")
 boardsql="select * from board where boardID="+cstr(boardID)+""
 rs.open boardsql,conn,1,3
 if err.number<>0 then 
      response.write "���ݿ����ʧ�ܣ�"&err.description
 else
    if not rs.eof then '   �ҵ��˸���̳ 
    rs("BoardName")=request("BoardName")
	rs("BoardType")=request("dirnm")
	rs("BoardInfo")=request("des")
	rs("BoardHead")=request("title")
	rs("BoardOwn")=request("own")
	rs("Boardad")=request("ownad")
	rs("BoardStyle")=request("face")
	rs("space")=chk(request("space"))
	rs("sayface")=chk(request("sayface"))
	rs("noonline")=chk(request("noonline"))
	rs("postseq")=request("postseq")
	rs("fontcolor")=request("fontcolor")
	rs("link")=request("link")
	rs("vlink")=request("vlink")
	rs("bgcolor")=request("bgcolor")
	rs("fontsize")=request("fontsize")
	rs("background")=ChkURL(request("background"))
	rs("postsinpage")=request("postsinpage")
	rs.update
	rs.close
           if err.number<>0 then
              response.write "���ݿ����ʧ�ܣ����Ժ�����"&err.Description
			  err.clear
           else
%>

<HTML>
<HEAD><TITLE>��̳���� �޸ĳɹ�!</TITLE>
<link rel="stylesheet" type="text/css" href="lun.css">
</HEAD>
<body>
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a></center>
<center>
<iframe name=MyFrame align=default src="" frameborder="no" border="0" width=100% SCROLLING="no" height=11></iframe> 
 
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="633"><tr><td>
<center>��̳���óɹ�!�ı��������С����ɫ�ı�ֻ�����������в���Ч!<br><br><A HREF="list.asp?BoardID=<%=boardID%>">������</A>�ۿ�Ч��<br><br></center>
<center><a href="config.asp?BoardID=<%=boardID%>">������̳����</a></center>
<br></td></tr></table><br>

</center>
</font>
</body></html>


<%         end if
    end if
 end if   
%>
