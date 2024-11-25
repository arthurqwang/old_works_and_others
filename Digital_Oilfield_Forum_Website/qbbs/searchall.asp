<%@ LANGUAGE="VBSCRIPT" %>

<%
dim keyword,bbs,text,doc
keyword=trim(request("keyword"))
bbs=request("bbs")
text=request("text")
doc=request("doc")


if (text="on" or bbs="on" or doc="on") and keyword<>"" then

 if text="on" then
  response.write "<form method='get' name='g' action='http://www.google.com/custom' target='_blank'><INPUT type='hidden' name='cof' VALUE='hl:zh-CN;GALT:#999966;S:http://www.digitaloilfield.org.cn;VLC:#999999;AH:left;BGC:#FFFFFF;LC:#284259;GFNT:#999999;L:http://www.digitaloilfield.org.cn/internetismlg.jpg;ALC:#999966;T:#454545;GIMP:#cc3300;'>"
  response.write "<input type='hidden' name='domains' value='www.digitaloilfield.org.cn'><INPUT TYPE=hidden name=hl  value=zh-CN><input type='hidden' name='sitesearch' value='www.digitaloilfield.org.cn'><INPUT TYPE='hidden' name='q' value="&"'"&keyword&"'"&"></form>"
  response.write chr(13)&"<script language='javascript'>document.g.submit();</script>"
 end if

 if bbs="on" then
  response.write "<form name='queryUser' method='POST' action='queryResult.asp' target='_blank'><input type='hidden' name='keyword' size='17' value="&"'"&keyword&"'"&"></form>"
  response.write chr(13)&"<script language='javascript'>"&chr(13)&"document.queryUser.submit();"&chr(13)&"</script>"
 end if

 if doc="on" then
  response.write "<form method='POST' name='dl' action='searchdl.asp' target='_blank'><input type='hidden' name='keywords' size='17' value="&"'"&keyword&"'"&"></form>"
  response.write chr(13)&"<script language='javascript'>document.dl.submit();</script>"
 end if

'response.write "查询结果已经显示在不同窗口中。"
response.write chr(13)&"<script language='javascript'>window.open ('alert3.htm','警告', 'height=100, width=450, top=100, left=100,location=no');</script>"
else
'response.write "查询条件不正确，请重新输入。"
response.write chr(13)&"<script language='javascript'>window.open ('alert4.htm','警告', 'height=100, width=450, top=100, left=100,location=no');</script>"
end if

response.write chr(13)&"<script language='javascript'>self.close()</script>"
'response.write keyword
%>
