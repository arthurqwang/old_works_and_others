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
<title>����ר��/�α�</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;ר��/�α�����</h3></p>

<%
    dim Cnn,rss,subject,body,bcc
    dim sql,action,expertnm,msg
    expertnm=request("expertnm")
  
    set rss=server.createobject("adodb.recordset")
    sql="select * from experts where expertnm='"&expertnm&"'"
    rss.open sql,conn,1,1
    realnm=rss("realnm")
    expertpw=rss("expertpw")
    unitnm=rss("unitnm")
    email=rss("email")
    tel=rss("tel")
    memo=rss("memo")
    rss.close
    Set Cnn = Server.CreateObject("ADODB.Connection")
    Cnn.Open "Driver={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("database/board.mdb")
    
    action=request("action")
    expertnm=request("expertnm")

    if action="delete" then
      sql="delete from experts where expertnm='"&expertnm&"'"
      Cnn.execute sql

      response.write chr(13)&"<script language='javascript'>"&chr(13)
      response.write "var to = '"&email&"';"&chr(13)
      response.write "var bcc = 'wangq@daqing.com';"&chr(13)
      response.write "var subject = '����������̳����������δ������';"&chr(13)
      response.write "var body = '�𾴵�"&realnm&"����/Ůʿ��'"&"+escape('\n\t\n\t    ')"&"+'���ã�'+escape('\n\t    ')+'�����������о������ǲ��ܽ�����������������̳ [ר��/�α�����������] �ύ�����룬�ǳ���Ǹ��'"
      response.write "+escape('\n\t    ')+'����Ȼ����ʹ����ע����û��������¼BBS����һ�������ۡ���ӭ������֧����̳����ӻԾ�μ����ۣ�'"
      response.write "+escape('\n\t    ')+'���ǲ��ܽ������������ԭ���ǣ����ǲ���ȷ��������ʵ��ݣ������ṩ�ĸ�����Ϣ��ȫ���������ʺϲ����������ۡ�'"
      response.write "+escape('\n\t\n\t    ')+'�������Ȼϣ�����룬�������µ���̳����ʵ��д������Ϣ��'"
      response.write "+escape('\n\t\n\t    ')+'���ύ����Ϣ���£�'"
      response.write "+escape('\n\t        ')+'������"&realnm&"'"
      response.write "+escape('\n\t        ')+'�û���"&expertnm&"'"
      response.write "+escape('\n\t        ')+'���룺"&expertpw&"'"
      response.write "+escape('\n\t        ')+'��λ��"&unitnm&"'"
      response.write "+escape('\n\t        ')+'Email��"&email&"'"
      if tel<>"" then response.write "+escape('\n\t        ')+'�绰��"&tel&"'"
      if memo<>"" then response.write "+escape('\n\t        ')+'����˵����"&memo&"'"
      response.write "+escape('\n\t\n\t    ')+'�ٴ�������ʾ�����Ǹ�⡣ף������˳����'"
      response.write "+escape('\n\t\n\t\n\t                             ')+'����������̳ http://www.digitaloilfield.org.cn'"
      response.write "+escape('\n\t                             ')+'���������������ι�˾'"
      response.write "+escape('\n\t                             ')+'�绰��0459-5986841'"
      response.write "+escape('\n\t\n\t')+'* ���ʼ��ɳ����Զ����ͣ�������������ϵ��̳������Arthur(wangq@daqing.com) �� ��̳����Marrist(zhangwl@daqing.com)'"
      response.write ";"&chr(13)
      response.write "var doc = 'mailto:' + to + '?bcc=' + bcc + '&subject=' + subject + '&body=' + body;"&chr(13)
      response.write "window.location = doc;"&chr(13)
      response.write "location.reload('expmng.asp')"
      response.write "</SCRIPT>"

    end if

    if action="permit" then
      sql="update experts set active=1 where expertnm='"&expertnm&"'"
      Cnn.execute sql

      response.write chr(13)&"<script language='javascript'>"&chr(13)
      response.write "var to = '"&email&"';"&chr(13)
      response.write "var bcc = 'wangq@daqing.com';"&chr(13)
      response.write "var subject = '����������̳�����������Ѿ�������';"&chr(13)
      response.write "var body = '�𾴵�"&realnm&"����/Ůʿ��'"&"+escape('\n\t\n\t    ')"&"+'���ã�'+escape('\n\t    ')+'��������������̳ [ר��/�α�����������] �ύ�������Ѿ������ܣ���ӭ���ļ��ˣ������֧�֣�ӻԾ�μ����ۣ�'"
      response.write "+escape('\n\t\n\t    ')+'��ע�����Ϣ���£�'"
      response.write "+escape('\n\t        ')+'������"&realnm&"'"
      response.write "+escape('\n\t        ')+'�û���"&expertnm&"'"
      response.write "+escape('\n\t        ')+'���룺"&expertpw&"'"
      response.write "+escape('\n\t        ')+'��λ��"&unitnm&"'"
      response.write "+escape('\n\t        ')+'Email��"&email&"'"
      if tel<>"" then
        response.write "+escape('\n\t        ')+'�绰��"&tel&"'"
      else
        response.write "+escape('\n\t        ')+'�绰��δ�����緽�㣬�������µ绰���Ա����໥��ͨ��'"
      end if
      if memo<>"" then response.write "+escape('\n\t        ')+'����˵����"&memo&"'"
      response.write "+escape('\n\t\n\t    ')+'���ṩ�ĵ绰��Email����Ϣ������̳�ڵ�ר��/�α�ʹ�á�'"
      response.write "+escape('\n\t\n\t    ')+'��������ʱͨ����̳�޸�������Ϣ��'"
      response.write "+escape('\n\t\n\t    ')+'�������û���ṩ���ļ�顢��������Ƭ���κι�񡢸�ʽ���ɣ����뾡��email�������˻���̳����'"
      response.write "+escape('\n\t\n\t    ')+'���ڣ���������������̳�ϳ��˿���ʹ��ע���ʺŵ�¼BBS����������������Ȩ��'"
      response.write "+escape('\n\t        ')+'(1)������˹������۵���Ϣ�����������ۡ�'"
      response.write "+escape('\n\t        ')+'(2)����С��Χ�������Ҫ���ϡ�'"
      response.write "+escape('\n\t        ')+'(3)ֱ������̳���ĳ�Ա(ר��)ȡ����ϵ��'"
      response.write "+escape('\n\t        ')+'(4)�������Ӳ�����顣'"
      response.write "+escape('\n\t        ')+'(5)���Խ����Լ���ר����'"
      response.write "+escape('\n\t        ')+'(6)���Ȳ�����ֻ��'"
      response.write "+escape('\n\t\n\t    ')+'ף������˳����'"
      response.write "+escape('\n\t\n\t\n\t                             ')+'����������̳ http://www.digitaloilfield.org.cn'"
      response.write "+escape('\n\t                             ')+'���������������ι�˾'"
      response.write "+escape('\n\t                             ')+'�绰��0459-5986841'"
      response.write "+escape('\n\t\n\t')+'* ���ʼ��ɳ����Զ����ͣ�������������ϵ��̳������Arthur(wangq@daqing.com) �� ��̳����Marrist(zhangwl@daqing.com)'"
      response.write ";"&chr(13)
      response.write "var doc = 'mailto:' + to + '?bcc=' + bcc + '&subject=' + subject + '&body=' + body;"&chr(13)
      response.write "window.location = doc;"&chr(13)
      response.write "location.reload('expmng.asp')"
      response.write "</SCRIPT>"
    end if

    if action="modify" then
      response.redirect "editexp.asp?expertnm="&expertnm
    end if

%>

</body>
</html>