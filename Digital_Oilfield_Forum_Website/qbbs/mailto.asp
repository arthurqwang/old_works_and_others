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
    folder=rss("folder")
    tel=rss("tel")
    memo=rss("memo")
    rss.close

      response.write chr(13)&"<script language='javascript'>"&chr(13)
      response.write "var to = '"&email&"';"&chr(13)
      response.write "var bcc = 'wangq@daqing.com;zhangwl@daqing.com';"&chr(13)
      response.write "var subject = '����������̳����л����֧�֣�';"&chr(13)
      response.write "var body = '�𾴵�"&realnm&"����/Ůʿ��'"&"+escape('\n\t\n\t    ')"&"+'���ã����������������ι�˾����� [����������̳] ��ӭ����'"
      response.write "+escape('\n\t\n\t    ')+'����������̳�����������˲������ϣ�������һ����������������֧�֣�ӻԾ�μ����ۣ�'"
      response.write "+escape('\n\t\n\t    ')+'���Ѿ�������Ϊ��̳��ר��/�α�����Ϊר��/�α������������Ե�¼��̳��BBS�����Ҿ���һ������Ȩ����������̳�ϵ� [ר��/�α�����������] ��¼��'"
      response.write "+escape('\n\t\n\t    ')+'����ע����Ϣ���£�'"
      response.write "+escape('\n\t        ')+'������"&realnm&"'"
      response.write "+escape('\n\t        ')+'�û���"&expertnm&"'"
      response.write "+escape('\n\t        ')+'���룺"&expertpw&"'"
      response.write "+escape('\n\t        ')+'��λ��"&unitnm&"'"
      response.write "+escape('\n\t        ')+'Email��"&email&"'"
      if tel<>"" then
        response.write "+escape('\n\t        ')+'�绰��"&tel&"'"
      else
        response.write "+escape('\n\t        ')+'�绰���ޡ��緽�㣬�������µ绰���Ա����໥��ͨ��'"
      end if
      if memo<>"" then response.write "+escape('\n\t        ')+'����˵����"&memo&"'"
      response.write "+escape('\n\t\n\t    ')+'���ṩ�ĵ绰��Email����Ϣ������̳�ڵ�ר��/�α�ʹ�á���������ʱͨ����̳�޸�������Ϣ��'"
      if folder<>0 then
        response.write "+escape('\n\t\n\t    ')+'����������Ϣ������̳�Ϲ���������'"
        response.write "+escape('\n\t        ')+'���ļ�飺http://www.digitaloilfield.org.cn/experts/"&folder&"/brief.txt'"
        response.write "+escape('\n\t        ')+'���ļ�����http://www.digitaloilfield.org.cn/experts/"&folder&"/intro.htm'"
        response.write "+escape('\n\t    ')+'���ļ��ͼ��������޸ģ���email�������˻���̳����'"
      else
        response.write "+escape('\n\t\n\t    ')+'����û���ṩ���ļ�顢��������Ƭ���κι�񡢸�ʽ���ɣ����뾡��email�������˻���̳����'"
      end if
      response.write "+escape('\n\t\n\t    ')+'��������������̳�ϳ��˿��Ե�¼BBS�⣬������������Ȩ��'"
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

%>

</body>
</html>