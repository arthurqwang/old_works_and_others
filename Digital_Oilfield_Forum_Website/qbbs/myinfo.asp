<%@ LANGUAGE="VBSCRIPT" %>
<%
dim currentpage
if not isempty(request("page")) then
      currentpage=cint(request("page"))
   else
       currentpage=1
   end if

dim username
dim password
dim mode
username=request("username")
password=request("password")
mode=request("mode")
select case mode
     case "everydetails"   
	   currentpage=2
     case "everypassword"
	   currentpage=1
     case "everypic"
	   currentpage=3
end select
%>

<html>

<head>
<meta NAME="GENERATOR" Content="lousi soft 1.0">
<meta HTTP-EQUIV="Content-Type" content="text/html; charset=gb2312">
<title>������Ϣ</title>
<link rel="stylesheet" type="text/css" href="lun.css">
</head>

<body>
<BODY marginheight=0 marginwidth=0 topmargin="0" leftmargin="10" bgcolor="#FFFFFF">
<%=session("ErrMsg")%>
<%session("ErrMsg")=""%>
<div align="center"><center>

<table width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table border='1' width='100%' cellspacing='0' bordercolorlight='#000000' bordercolordark='#FFFFFF'  cellpadding='0'>

      <tr>
        <td  valign="top" align="left" bgcolor='#A9D46D'><p align="center"><a
        href="myinfo.asp?page=1">��������</a> </td>
        <td valign="top" align="left" bgcolor='#A9D46D'><p align="center"><a
        href="myinfo.asp?page=2">�޸�����</a></td>
        <td bgcolor='#A9D46D' valign="top" align="left"><p align="center"><a
        href="myinfo.asp?page=3">��ѯ����</a></td>
      </tr>
      <tr>
        <td valign="top" align="left" colspan="3" ><table width="100%" bgcolor='#E3F1D1'>
          <tr>
            <td width="34%"><%if currentpage=1 then%>
<form method="POST" name="frmChangePass" action="ChangePass.asp">
              <p><span class="smallFont">�ա�������</span><input class="smallInput" name="name"
              size="10" maxlength="50" value> <br>
              <span class="smallFont">�ɵ����룺</span><input class="smallInput" name="oldpwd"
              size="10" maxlength="10" type="password" value><br>
              <span class="smallFont">�µ����룺</span><input class="smallInput" name="newpwd"
              size="10" maxlength="10" type="password" value><br>
              <span class="smallFont">ȷ�����룺</span><input class="smallInput" name="compwd"
              size="10" maxlength="10" type="password" value><br>
              <input class="buttonface" type="submit" value="ȷ ��" name="B1"> <input
              class="buttonface" type="reset" value="�� ��" name="B2"></p>
            </form>
<%end if%>
            </td>
            <td width="33%"><%if currentpage=2 then%>
<form method="POST" name="frmmodify" action="mymodify.asp">
              <p><span class="smallFont">�ա�����</span><input class="smallInput" name="name"
              size="10" maxlength="50" value> <br>
              <span class="smallFont">��&nbsp; �룺</span><input class="smallInput" name="txtpwd"  
              size="10" maxlength="10" type="password"><br>  
              <br>  
              <input class="buttonface" type="submit" value="ȷ ��" name="B1"> </p>  
            </form>  
<%end if%>  
            </td>  
            <td width="33%"><%if currentpage=3 then%>  
<form method="POST" name="frmsearch" action="mysearch.asp">  
              <p><span class="smallFont">�� ����</span><input class="smallInput" name="name"  
              size="10" maxlength="50" value> <br>  
              <br>  
              <input class="buttonface" type="submit" value="ȷ ��" name="B1"> </p>  
            </form>  
<%end if%>  
            </td>  
          </tr>  
        </table>  
        </td>  
      </tr>  
    </table>  
    </td>  
  </tr>  
</table>  
</center></div></div>  
</body>  
</html>  
