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
      response.write "var subject = '数字油田论坛：您的申请未被接受';"&chr(13)
      response.write "var body = '尊敬的"&realnm&"先生/女士：'"&"+escape('\n\t\n\t    ')"&"+'您好！'+escape('\n\t    ')+'经我们认真研究，我们不能接受您在数字油田论坛 [专家/嘉宾深入讨论区] 提交的申请，非常抱歉！'"
      response.write "+escape('\n\t    ')+'您仍然可以使用您注册的用户和密码登录BBS参与一般性讨论。欢迎您继续支持论坛，并踊跃参加讨论！'"
      response.write "+escape('\n\t    ')+'我们不能接受您的申请的原因是：我们不能确定您的真实身份，或您提供的个人信息不全，或您不适合参与深入讨论。'"
      response.write "+escape('\n\t\n\t    ')+'如果您仍然希望加入，请您重新到论坛上如实填写各项信息。'"
      response.write "+escape('\n\t\n\t    ')+'您提交的信息如下：'"
      response.write "+escape('\n\t        ')+'姓名："&realnm&"'"
      response.write "+escape('\n\t        ')+'用户："&expertnm&"'"
      response.write "+escape('\n\t        ')+'密码："&expertpw&"'"
      response.write "+escape('\n\t        ')+'单位："&unitnm&"'"
      response.write "+escape('\n\t        ')+'Email："&email&"'"
      if tel<>"" then response.write "+escape('\n\t        ')+'电话："&tel&"'"
      if memo<>"" then response.write "+escape('\n\t        ')+'补充说明："&memo&"'"
      response.write "+escape('\n\t\n\t    ')+'再次向您表示深深的歉意。祝您工作顺利！'"
      response.write "+escape('\n\t\n\t\n\t                             ')+'数字油田论坛 http://www.digitaloilfield.org.cn'"
      response.write "+escape('\n\t                             ')+'大庆油田有限责任公司'"
      response.write "+escape('\n\t                             ')+'电话：0459-5986841'"
      response.write "+escape('\n\t\n\t')+'* 此邮件由程序自动发送，如有疑问请联系论坛主持人Arthur(wangq@daqing.com) 或 论坛助理Marrist(zhangwl@daqing.com)'"
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
      response.write "var subject = '数字油田论坛：您的申请已经被接受';"&chr(13)
      response.write "var body = '尊敬的"&realnm&"先生/女士：'"&"+escape('\n\t\n\t    ')"&"+'您好！'+escape('\n\t    ')+'您在数字油田论坛 [专家/嘉宾深入讨论区] 提交的申请已经被接受，欢迎您的加盟！请继续支持，踊跃参加讨论！'"
      response.write "+escape('\n\t\n\t    ')+'您注册的信息如下：'"
      response.write "+escape('\n\t        ')+'姓名："&realnm&"'"
      response.write "+escape('\n\t        ')+'用户："&expertnm&"'"
      response.write "+escape('\n\t        ')+'密码："&expertpw&"'"
      response.write "+escape('\n\t        ')+'单位："&unitnm&"'"
      response.write "+escape('\n\t        ')+'Email："&email&"'"
      if tel<>"" then
        response.write "+escape('\n\t        ')+'电话："&tel&"'"
      else
        response.write "+escape('\n\t        ')+'电话：未留。如方便，请您留下电话，以便大家相互沟通。'"
      end if
      if memo<>"" then response.write "+escape('\n\t        ')+'补充说明："&memo&"'"
      response.write "+escape('\n\t\n\t    ')+'您提供的电话、Email等信息仅供论坛内的专家/嘉宾使用。'"
      response.write "+escape('\n\t\n\t    ')+'您可以随时通过论坛修改您的信息。'"
      response.write "+escape('\n\t\n\t    ')+'如果您还没有提供您的简介、简历和照片（任何规格、格式均可），请尽快email给主持人或论坛助理。'"
      response.write "+escape('\n\t\n\t    ')+'现在，您在数字油田论坛上除了可以使用注册帐号登录BBS，另外享有如下特权：'"
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
    end if

    if action="modify" then
      response.redirect "editexp.asp?expertnm="&expertnm
    end if

%>

</body>
</html>