<%
'如果能够确认为"出于活动状态的"专家，则 isexp=1，否则 isexp=0

dim isexp,expertnm,expertpw,realnm,expfolder
isexp=0
expertnm=""
expertpw=""
realnm=""
expfolder=0

if request("hiddenflag")="do456wangquan" then
  expertnm=trim(request("expertnm"))
  expertpw=trim(request("expertpw"))
  if expertnm="" or expertpw="" then
    response.write "<script language='javascript'>window.open ('alert1.htm','警告', 'height=100, width=450, top=100, left=100,location=no')</script>"
    del_cookies("expertnm")
    del_cookies("expertpw")
  end if
end if
if expertnm="" or expertpw="" then
  expertnm=trim(request.cookies("expertnm"))
  expertpw=trim(request.cookies("expertpw"))
end if
if expertnm<>"" and expertpw<>"" then
    dim rsexp,sqlexp,temppw,active
    temppw=""
    active=0
    set rsexp=server.createobject("adodb.recordset")
    sqlexp="select * from experts where expertnm='"&expertnm&"'"
    rsexp.open sqlexp,conn,1,1
    if not rsexp.EOF then
      temppw=rsexp("expertpw")
      active=rsexp("active")
      realnm=rsexp("realnm")
      expfolder=rsexp("folder")
    end if
    rsexp.Close
  if expertpw=temppw and active=1 then
    response.cookies("expertnm")=expertnm
    response.cookies("expertpw")=expertpw
    response.cookies("realnm")=realnm
    isexp=1
  else
    response.write "<script language='javascript'>window.open ('alert1.htm','警告', 'height=100, width=450, top=100, left=100,location=no')</script>"
    del_cookies("expertnm")
    del_cookies("expertpw")
  end if
end if

'记载登录时间
if request("hiddenflag")="do456wangquan" and isexp=1 then
'    dim rs
    set rs=server.createobject("adodb.recordset")
    sql="select * from experts where expertnm='"&expertnm&"'"
    rs.open sql,conn,3,3
    if (not rs.eof) then
       rs("loginrec")=rs("loginrec")&"[IN:"&Date()&" "&Time()&"]"
	   rs.update
    end if
   rs.close
end if

function del_cookies(cookiesnm)
  response.cookies(cookiesnm)=""
end function

function display_if_expert(str)
  dim img_loc,tempstr
  img_loc=0
  if isexp=1 then 
    'replace str,"^","<img border='0' src='images/expert.gif'>"
    img_loc=instr(str,"^")
    if img_loc>0 then
      tempstr=left(str,img_loc-1)
      tempstr=tempstr&"<img border='0' src='images/expert.gif'>"
      tempstr=tempstr&mid(str,img_loc+1,len(str)-img_loc)
      str=tempstr
    end if
    response.write str
  end if
end function
%>
