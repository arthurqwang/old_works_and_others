<html>

<head>
<title>管理者登陆</title>
<link rel="stylesheet" type="text/css" href="forum.css">
</head>

<body>
<div align="center"><center>

<table border="0" cellspacing="1" width="90%">
  <tr>
    <td>　<form method="post" action="adminchg.asp">
      <table width="45%" border="1" cellspacing="0" cellpadding="1" align="center"
      bordercolordark="#ecf5ff" bordercolorlight="#6699cc">
        <tr>
          <td><table width="100%" border="0" cellspacing="1" cellpadding="1">
            <tr>
              <td width="45%" align="right" height="30">管理员帐号：</td>
              <td width="55%"><input name="username" maxlength="20" class="smallInput" size="20" value="<%=request.cookies("myname")%>"> </td>
            </tr>
            
			<tr>
              <td width="45%" align="right" height="30">管理员密码：</td>
              <td width="55%"><input type=password name="oldpwd" maxlength="20" class="smallInput" size="20"> </td>
            </tr>
			<tr>
                      <td width="45%" align="right" height="30">新的管理密码：</td>
              <td width="55%"><input  type="password" name="password1" maxlength="20" class="smallInput" size="20"> </td>
            </tr>
            <tr>
                      <td width="45%" align="right" height="30">重复管理密码：</td>
              <td width="55%"><input type="password" name="password" maxlength="16" class="smallInput"
              size="20"> </td>
            </tr>
            <tr>
              <td colspan="2" height="15"></td>
            </tr>
          </table>
          </td>
        </tr>
        <tr align="center">
          <td height="40">
                  <input type="submit" name="Submit" value="确定" class="buttonface"> 
          &nbsp; 
                  <input type="reset" name="Submit2" value="重写" class="buttonface">
                   </td>
        </tr>
      </table>
    </form>
    <p align="center">　</td>
  </tr>
</table>
</center></div>
</body>
</html>
