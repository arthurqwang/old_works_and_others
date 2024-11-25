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
<title>管理专家/嘉宾</title>
</head>

<BODY marginheight=0 marginwidth=0 topmargin="30" leftmargin="10" bgcolor="#FFFFFF">
<center><a href="http://www.internetism.org" target="_blank"><img border="0" src="../internetism-logo.jpg" width="72" height="69"><img border="0" src="../internetism.jpg" width="504" height="69"></a><h3><img border="0" src="images/download.jpg" height="20" width="30">&nbsp;&nbsp;专家/嘉宾管理</h3></p>

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
      response.write "var subject = '数字油田论坛：感谢您的支持！';"&chr(13)
      response.write "var body = '尊敬的"&realnm&"先生/女士：'"&"+escape('\n\t\n\t    ')"&"+'您好！大庆油田有限责任公司主办的 [数字油田论坛] 欢迎您！'"
      response.write "+escape('\n\t\n\t    ')+'数字油田论坛近期又增加了部分资料，并做了一定调整。请您继续支持，踊跃参加讨论！'"
      response.write "+escape('\n\t\n\t    ')+'您已经被邀请为论坛的专家/嘉宾。作为专家/嘉宾，您不仅可以登录论坛的BBS，而且具有一定的特权，请您在论坛上的 [专家/嘉宾深入讨论区] 登录。'"
      response.write "+escape('\n\t\n\t    ')+'您的注册信息如下：'"
      response.write "+escape('\n\t        ')+'姓名："&realnm&"'"
      response.write "+escape('\n\t        ')+'用户："&expertnm&"'"
      response.write "+escape('\n\t        ')+'密码："&expertpw&"'"
      response.write "+escape('\n\t        ')+'单位："&unitnm&"'"
      response.write "+escape('\n\t        ')+'Email："&email&"'"
      if tel<>"" then
        response.write "+escape('\n\t        ')+'电话："&tel&"'"
      else
        response.write "+escape('\n\t        ')+'电话：无。如方便，请您留下电话，以便大家相互沟通。'"
      end if
      if memo<>"" then response.write "+escape('\n\t        ')+'补充说明："&memo&"'"
      response.write "+escape('\n\t\n\t    ')+'您提供的电话、Email等信息仅供论坛内的专家/嘉宾使用。您可以随时通过论坛修改您的信息。'"
      if folder<>0 then
        response.write "+escape('\n\t\n\t    ')+'您的如下信息将在论坛上公开发布：'"
        response.write "+escape('\n\t        ')+'您的简介：http://www.digitaloilfield.org.cn/experts/"&folder&"/brief.txt'"
        response.write "+escape('\n\t        ')+'您的简历：http://www.digitaloilfield.org.cn/experts/"&folder&"/intro.htm'"
        response.write "+escape('\n\t    ')+'您的简介和简历如需修改，请email给主持人或论坛助理。'"
      else
        response.write "+escape('\n\t\n\t    ')+'您还没有提供您的简介、简历和照片（任何规格、格式均可），请尽快email给主持人或论坛助理。'"
      end if
      response.write "+escape('\n\t\n\t    ')+'您在数字油田论坛上除了可以登录BBS外，还享有如下特权：'"
      response.write "+escape('\n\t        ')+'(1)浏览不宜公开讨论的信息，并参与讨论。'"
      response.write "+escape('\n\t        ')+'(2)下载小范围共享的重要资料。'"
      response.write "+escape('\n\t        ')+'(3)直接与论坛核心成员(专家)取得联系。'"
      response.write "+escape('\n\t        ')+'(4)发布帖子不必审查。'"
      response.write "+escape('\n\t        ')+'(5)可以建立自己的专栏。'"
      response.write "+escape('\n\t        ')+'(6)优先参与各种活动。'"
      response.write "+escape('\n\t\n\t    ')+'祝您工作顺利！'"
      response.write "+escape('\n\t\n\t\n\t                             ')+'数字油田论坛 http://www.digitaloilfield.org.cn'"
      response.write "+escape('\n\t                             ')+'大庆油田有限责任公司'"
      response.write "+escape('\n\t                             ')+'电话：0459-5986841'"
      response.write "+escape('\n\t\n\t')+'* 此邮件由程序自动发送，如有疑问请联系论坛主持人Arthur(wangq@daqing.com) 或 论坛助理Marrist(zhangwl@daqing.com)'"
      response.write ";"&chr(13)
      response.write "var doc = 'mailto:' + to + '?bcc=' + bcc + '&subject=' + subject + '&body=' + body;"&chr(13)
      response.write "window.location = doc;"&chr(13)
      response.write "location.reload('expmng.asp')"
      response.write "</SCRIPT>"

%>

</body>
</html>