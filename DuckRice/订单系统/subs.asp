
<%
'这个文件要在宿主嵌入文件最顶端
dim conn   
dim connstr

dim cmdTemp,msg
dim InsertCursor
dim dataconn
dim rs
dim sql
dim dlwm,dlmm,ndxm,cysj,gddh,czhm,jstx,dzyj,qtfs  '客户信息
dim dlwm_tem,dlmm_tem,ndxm_tem,cysj_tem  '用于管理员操作客户时
dim dgxs,pzdj,ddlx,shfs,xzdh,shr,shdh,shdz,yzbm,qtsm        '订单信息
dim can_add_user,can_add_order,user_exist,pw_ok,log_in,is_adm,can_modify_del_order,can_modify_del_user
dim only_single_user
   
   'on error resume next
   'call conn_init()

   SUB conn_init()
       on error resume next
       connstr="DBQ="+server.mappath("database/ggym.mdb")+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};"
       set conn=server.createobject("ADODB.CONNECTION")
       if err.number<>0 then 
           err.clear
		%> 
			<script language="javascript">
				top.location="sessionerr.htm"
			</script>
		<%      
       else
           conn.open connstr
           if err then 
              err.clear
           %>
              <script language="javascript">
                  top.location="sessionerr.htm"
              </script>
           <%      
              
           end if
       end if   
  END SUB
  
  SUB endConnection
      conn.close
      set conn=nothing
  END SUB

  SUB conn_reconnect()  '为了保证最新加入的记录能够查询出来，必须重新连接一次
     endConnection()
     conn_init()
  END SUB






SUB verify_user()   '检查用户是否login
if  request.cookies("ggymadm")="YES" then is_adm=1
dlwm=request.cookies("ggymdlwm")
ndxm=request.cookies("ggymndxm")
cysj=request.cookies("ggymcysj")
END SUB


SUB find_user()   '在数据库中检查用户存在否
   if dlwm="" then
      response.write "失败：[登陆网名]必须填写<br>"
      false_end_process()
   end if
   if dlmm="" then
      response.write "失败：[登陆密码]必须填写<br>"
      false_end_process()
   end if

   '检查数据库中的用户是否存在
        set rs=server.createobject("adodb.recordset")
        sql="select * from userlist where dlwm='" & dlwm & "'"
        rs.open sql,conn,1,1

        if not rs.eof then 
           user_exist=1
           if rs("dlmm")=dlmm then pw_ok=1
        end if

    if user_exist=1 then
        if pw_ok <> 1 then   '用户存在，但密码不对时
           response.write "失败：[登陆网名]已被占用，或[登陆密码]错误<br>"
           false_end_process()           
        end if
        if pw_ok=1 then    '账号验证通过
			dlwm=rs("dlwm")
			dlmm=rs("dlmm")
			ndxm=rs("ndxm")
			cysj=rs("cysj")
			gddh=rs("gddh")
			czhm=rs("czhm")
			jstx=rs("jstx")
			dzyj=rs("dzyj")
			qtfs=rs("qtfs")
           log_in=1
           '设置用户cookie
           response.cookies("ggymdlwm")=dlwm
           response.cookies("ggymndxm")=ndxm
           response.cookies("ggymcysj")=cysj

           '判断是不是管理员
           if rs("yhqx")="1" then
              is_adm=1
              '设置管理员cookie
              response.cookies("ggymadm")="YES" 
           end if
        end if
    end if
    rs.Close
END SUB


SUB check_new_user()   '检查新用户必填项填否
'此前在 find_user() 已经检查过登录网名 和 登录密码是否已填写
	if user_exist=0 then
	   if ndxm="" then
	       response.write "失败：首次登记必须填写[您的姓名]<br>"
	       false_end_process()
	   end if
	   if cysj="" then
	       response.write "失败：首次登记必须填写[常用手机]<br>"
	       false_end_process()
	   end if
	end if
	'如果能够执行到这里，则可以增加用户了
	can_add_user=1
END SUB

SUB check_new_order()
	if dgxs<>"" then can_add_order=1
	if pzdj<>"" then can_add_order=1
	if ddlx<>"" then can_add_order=1
	if shfs<>"" then can_add_order=1
	if xzdh<>"" then can_add_order=1
	if shr<>""  then can_add_order=1
	if shdh<>"" then can_add_order=1
	if shdz<>"" then can_add_order=1
	if yzbm<>"" then can_add_order=1
	if qtsm<>"" then can_add_order=1
END SUB


SUB adduser()   '增加一个新用户
	Set DataConn = Server.CreateObject("ADODB.Connection")
	dataconn.open connstr
	Set cmdTemp = Server.CreateObject("ADODB.Command")
	Set InsertCursor = Server.CreateObject("ADODB.Recordset")
	
	cmdTemp.CommandText = "SELECT * FROM userlist"
	cmdTemp.CommandType = 1
	Set cmdTemp.ActiveConnection = dataConn
	InsertCursor.Open cmdTemp, , 1, 3
	InsertCursor.AddNew
	
	InsertCursor("dlwm") = dlwm
	InsertCursor("dlmm") = dlmm
	InsertCursor("ndxm") = ndxm
	InsertCursor("cysj") = cysj
	InsertCursor("gddh") = gddh
	InsertCursor("czhm") = czhm
	InsertCursor("jstx") = jstx
	InsertCursor("dzyj") = dzyj
	InsertCursor("qtfs") = qtfs
	InsertCursor("djrq") = now()
	InsertCursor("yhqx") = "0"
	
	InsertCursor.Update

	if err.number > 0 then
	   err.clear
	   FoundError=true
	   msg="数据库操作失败，请以后再试" & err.Description
	else
	   msg="客户登记成功"
	end if
	
	InsertCursor.close
	dataconn.close
	
	response.write msg & "<br>"
	
    log_in=1
    '设置用户cookie
    response.cookies("ggymdlwm")=dlwm
    response.cookies("ggymndxm")=ndxm
    response.cookies("ggymcysj")=cysj
END SUB


SUB addorder()    '增加一个新订单,管理员不能给自己加订单，但可以帮客户加订单
                  '此时dlwm=管理员  dlwm_tem=客户
    dlwm_tem=request("dlwm_tem")
    ndxm_tem=request("ndxm_tem")
    cysj_tem=request("cysj_tem")

if is_adm=1 and dlwm_tem="" then
      response.write "管理员只能帮助客户加订单，不能在自己名下加订单<br>"
else
	Set DataConn = Server.CreateObject("ADODB.Connection")
	dataconn.open connstr
	Set cmdTemp = Server.CreateObject("ADODB.Command")
	Set InsertCursor = Server.CreateObject("ADODB.Recordset")
	
	cmdTemp.CommandText = "SELECT * FROM orderlist"
	cmdTemp.CommandType = 1
	Set cmdTemp.ActiveConnection = dataConn
	InsertCursor.Open cmdTemp, , 1, 3
	InsertCursor.AddNew



	if is_adm=1 then
      InsertCursor("dlwm") = dlwm_tem
    else
      InsertCursor("dlwm") = dlwm
    end if

	if (shr="") then
	   shr=ndxm
       if is_adm=1 then shr=ndxm_tem
	end if
	if (shdh="") then
	   shdh=cysj
       if is_adm=1 then shdh=cysj_tem
	end if

	InsertCursor("dgxs") = dgxs

    dim pzdj_str,ddlx_str,shfs_str
    pzdj_str=""
    ddlx_str=""
    shfs_str=""

	if pzdj="0" then pzdj_str = "特级"
	if pzdj="1" then pzdj_str = "一级"
	if pzdj="2" then pzdj_str = "二级"

	if ddlx="0" then ddlx_str = "现货存米"
	if ddlx="1" then ddlx_str = "年度预订"

	if shfs="0" then shfs_str = "特快直达"
	if shfs="1" then shfs_str = "同城自取"

	InsertCursor("pzdj") = pzdj_str
	InsertCursor("ddlx") = ddlx_str
	InsertCursor("shfs") = shfs_str
	InsertCursor("xzdh") = xzdh
	InsertCursor("shr") = shr
	InsertCursor("shdh") = shdh
	InsertCursor("shdz") = shdz
	InsertCursor("yzbm") = yzbm
	InsertCursor("qtsm") = qtsm
	InsertCursor("djrq") = now()
	InsertCursor("dqzt") = "1 最新登记"
	InsertCursor("dgdj") = dgdj
	InsertCursor("zje") = zje
	InsertCursor("yjje") = yjje
	InsertCursor("bz") = bz
	if is_adm=1 then InsertCursor("bz") = "代"	
	InsertCursor.Update
	
	if err.number > 0 then
	   err.clear
	   FoundError=true
	   msg="数据库操作失败，请以后再试" & err.Description
	else
	   msg="订货信息登记成功"
	end if
	
	InsertCursor.close
	dataconn.close
	
	response.write msg & "<br>"
end if
END SUB


SUB showuser()   '显示用户信息
   dim iii,tt_str
   iii=1
   only_single_user=request("only_single_user")
   dlwm_tem=request("dlwm_tem")
   set rs=server.createobject("adodb.recordset")
   sql="select * from userlist where dlwm='" & dlwm & "'"
   if is_adm=1 then sql="select * from userlist order by yhqx,ndxm,djrq"
   if only_single_user="1" then sql="select * from userlist where dlwm='" & dlwm_tem & "'"
   rs.open sql,conn,1,1
   response.write "<br><br><font color=#007700>您的账号信息</font><br>" 

       response.write "<center><table border=1 cellpadding=0 cellspacing=0 style=border-collapse:collapse bordercolor=#aaaaaa align=center width=1000>"
       response.write "<tr>"
       response.write "<td  align=center bgcolor=#ddddff width=30></td>"
       if is_adm=1 then
          response.write "<td  align=center bgcolor=#ddddff width=30></td>"
          response.write "<td  align=center bgcolor=#ddddff width=30></td>"
          response.write "<td  align=center bgcolor=#ddddff width=30></td>"
       end if
       if is_adm=1 then response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>序号</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>客户<br>姓名</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>登陆<br>网名</font></td>"
       'response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>登录<br>密码</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>常用<br>手机</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>固定<br>电话</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>传真<br>号码</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>即时<br>通讯</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>电子<br>邮件</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>其他<br>方式</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>登记<br>日期</font></td>"
       response.write "</tr>"

   do while not rs.EOF
       response.write "<tr>"
       response.write "<td><a href='mdfyusr.asp?dlwm=" & rs("dlwm") & "'><font size=2 color=#339933>修改</font></a></td>"
       if is_adm=1 then
          if  rs("yhqx")="0" then
	         response.write "<td><a href='delusr.asp?dlwm=" & rs("dlwm") & "'><font size=2 color=#663399>删除</font></a></td>"
	         response.write "<td><a href='ggymreg4.asp?dlwm_tem=" & rs("dlwm") & "&ndxm_tem=" & rs("ndxm") & "&cysj_tem=" & rs("cysj") & "'><font size=2 color=#669933>加单</font></a></td>"
	         response.write "<td><a href='showall.asp?only_single_user=1&dlwm_tem=" & rs("dlwm") & "'><font size=2 color=#993366>查单</font></a></td>"
          else
	         response.write "<td></td>"
	         response.write "<td></td>"
	         response.write "<td></td>"
          end if
       end if
       if is_adm=1 then response.write "<td><font size=2 color=#336699>"&iii&"</font></td>"
       dim clr_tmp
       clr_tmp="009900"
       if rs("yhqx")="1" then clr_tmp="990000"
       response.write "<td><font size=2 color=#" & clr_tmp & ">" & rs("ndxm") & "</font></td>"
       response.write "<td><font size=2 color=#666666>" & rs("dlwm") & "</font></td>"
       'response.write "<td><font size=2 color=#666666>" & rs("dlmm") & "</font></td>"
       response.write "<td><font size=2 color=#666666>" & rs("cysj") & "</font></td>"
       response.write "<td><font size=2 color=#666666>" & rs("gddh") & "</font></td>"
       response.write "<td><font size=2 color=#666666>" & rs("czhm") & "</font></td>"
       response.write "<td><font size=2 color=#666666>" & rs("jstx") & "</font></td>"
       response.write "<td><font size=2 color=#666666>" & rs("dzyj") & "</font></td>"
       response.write "<td><font size=2 color=#666666>" & rs("qtfs") & "</font></td>"
       tt_str=rs("djrq")
       tt_str=year(tt_str) & "-" & month(tt_str) & "-" & day(tt_str)
       response.write "<td><font size=2 color=#666666>" & tt_str & "</font></td>"
       response.write "</tr>"
       rs.MoveNext
       iii=iii+1
	loop
    response.write "</table></center>"
	rs.Close
END SUB

SUB showorder()   '显示订货信息
   dim total1,total2,total3,total4,total5
   only_single_user=request("only_single_user")
   dlwm_tem=request("dlwm_tem")
    iii=1
    set rs=server.createobject("adodb.recordset")
	sql="select orderlist.*,userlist.dlwm,userlist.ndxm from orderlist,userlist where orderlist.dlwm=userlist.dlwm and orderlist.dlwm='" & dlwm & "' order by orderlist.djrq desc"
	if is_adm=1 then sql="SELECT orderlist.*, userlist.dlwm,userlist.ndxm FROM orderlist, userlist WHERE orderlist.dlwm=userlist.dlwm ORDER BY orderlist.djrq DESC;"
    if only_single_user="1" then 	sql="select orderlist.*,userlist.dlwm,userlist.ndxm from orderlist,userlist where orderlist.dlwm=userlist.dlwm and orderlist.dlwm='" & dlwm_tem & "' order by orderlist.djrq desc"
	rs.open sql,conn,1,1
    response.write "<br><br><font color=#007700>您的订货信息</font><br>" 

       response.write "<center><table border=1 cellpadding=0 cellspacing=0 style=border-collapse:collapse bordercolor=#aaaaaa align=center width=1000>"
       response.write "<tr>"
       response.write "<td  align=center bgcolor=#ddffdd width=30></td>"
       response.write "<td  align=center bgcolor=#ddffdd width=30></td>"
       if is_adm=1 then response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>序号</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>订单号</font></td>"
       if is_adm=1 then response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>客户<br>姓名</font></td>"
       if is_adm=1 then response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>登录<br>网名</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>订购<br>箱数</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>品质<br>等级</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>订单<br>类型</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>收货<br>方式</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>选择<br>地号</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>收货人</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>收货<br>电话</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>收货<br>地址</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>邮政<br>编码</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>其他<br>说明</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>登记<br>日期</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>当前<br>状态</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>订购<br>单价</font></td>"

       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>总金额</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>已交<br>金额</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>备注</font></td>"
       response.write "</tr>"

		total1=0
		total2=0
		total3=0
		total4=0
		total5=0
	do while not rs.EOF
       total1=total1+1  '订单总数
       if rs("dgxs")<>"" then total2=total2+cint(rs("dgxs"))
       if rs("zje")<>"" then total4=total4+cint(rs("zje"))
       if rs("yjje")<>"" then total5=total5+cint(rs("yjje"))
     
       tt_str=rs("djrq")
       tt_str=right(year(tt_str),2) & "-" & month(tt_str) & "-" & day(tt_str)
       tt_str=tt_str & "_" & trim(rs("oid"))
       response.write "<tr>"
       check_modify_del_order()
       if can_modify_del_order=1 then
	       response.write "<td><a href='mdfyodr.asp?oid=" & rs("oid") & "'><font size=2 color=#339933>修改</font></a></td>"
	       response.write "<td><a href='delodr.asp?oid=" & rs("oid") & "'><font size=2 color=#663399>删除</font></a></td>"
       else
	       response.write "<td></td>"
	       response.write "<td></td>"
       end if
       if is_adm=1 then response.write "<td><font size=2 color=#336699>"&iii&"</font></td>"
       response.write "<td><font size=2 color=#336699>" & tt_str & "</font></td>"
	   if is_adm=1 then response.write "<td><font size=2 color=#666666>" & rs("ndxm") & "</font></td>"
	   if is_adm=1 then response.write "<td><font size=2 color=#666666>" & rs("dlwm") & "</font></td>"
	   response.write "<td align=right><font size=2 color=#666666>" & rs("dgxs") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("pzdj") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("ddlx") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("shfs") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("xzdh") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("shr") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("shdh") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("shdz") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("yzbm") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("qtsm") & "</font></td>"
       tt_str=rs("djrq")
       tt_str=year(tt_str) & "-" & month(tt_str) & "-" & day(tt_str)
	   response.write "<td><font size=2 color=#666666>" & tt_str & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("dqzt") & "</font></td>"
	   response.write "<td align=right><font size=2 color=#666666>" & rs("dgdj") & "</font></td>"
	   response.write "<td align=right><font size=2 color=#666666>" & rs("zje") & "</font></td>"
	   response.write "<td align=right><font size=2 color=#666666>" & rs("yjje") & "</font></td>"
	   response.write "<td><font size=2 color=#666666>" & rs("bz") & "</font></td>"
       response.write "</tr>"
	   rs.MoveNext
       iii=iii+1
	loop
    if total2<>0 then total3=cint(total4/total2*100)/100   '平均单价
    response.write "<tr><td><font size=2 color=#0000ff>合计</font></td><td></td>"
    if is_adm=1 then response.write "<td></td>"
    response.write "<td align=right><font size=2 color=#0000ff>订单<br>总数<br>" & total1 & "</font></td>"
    if is_adm=1 then response.write "<td></td><td></td>"
    response.write "<td align=right><font size=2 color=#0000ff>总箱数<br><br>" & total2 & "</font></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>"
    response.write "<td align=right><font size=2 color=#0000ff>平均<br>单价<br>" & total3 & "</font></td>"
    response.write "<td align=right><font size=2 color=#0000ff>总金额<br><br>" & total4 & "</font></td>"
    response.write "<td align=right><font size=2 color=#0000ff>已交<br>金额<br>" & total5 & "</font></td><td></td></tr>"
    response.write "</table></center>"
    if is_adm=1 then 
       response.write "<font size=2 color=#007700><br>　　　您可以点击这里<a href='ggymreg2.html'>增加客户和订货信息</a></font><br>"
    else
       response.write "<font size=2 color=#007700><br>　　　您可以点击这里<a href='ggymreg3.asp'>增加订货信息</a></font><br>"
    end if
    response.write "<font size=2 color=#ff0000><br>* 以双方签订的正式订单为准，网上登记仅供沟通使用</font><br>"
	rs.Close
END SUB


SUB updateuser()
if (shr="") then shr=ndxm
if (shdh="") then shdh=cysj

    set rs=server.createobject("adodb.recordset")
    sql="select * from userlist where dlwm='" & dlwm & "'"
    rs.open sql,conn,3,3
    if (not rs.eof) then
		rs("ndxm")=ndxm
		rs("cysj")=cysj
		rs("gddh")=gddh
		rs("czhm")=czhm
		rs("jstx")=jstx
		rs("dzyj")=dzyj
		rs("qtfs")=qtfs
	   rs.update
           response.cookies("ggymdlwm")=dlwm
           response.cookies("ggymndxm")=ndxm
           response.cookies("ggymcysj")=cysj

       response.write "修改成功<br>"
     else 
	   response.write "操作失败<br>"
    end if
   rs.close
END SUB

SUB updateorder()
if (shr="") then shr=ndxm
if (shdh="") then shdh=cysj

    set rs=server.createobject("adodb.recordset")
    sql="select * from orderlist where oid=" & oid
    rs.open sql,conn,3,3
    if (not rs.eof) then
       rs("dgxs")=dgxs

	    dim pzdj_str2,ddlx_str2,shfs_str2
	    pzdj_str2=""
	    ddlx_str2=""
	    shfs_str2=""
	
		if pzdj="0" then pzdj_str2 = "特级"
		if pzdj="1" then pzdj_str2 = "一级"
		if pzdj="2" then pzdj_str2 = "二级"
	
		if ddlx="0" then ddlx_str2 = "现货存米"
		if ddlx="1" then ddlx_str2 = "年度预订"
	
		if shfs="0" then shfs_str2 = "特快直达"
		if shfs="1" then shfs_str2 = "同城自取"

       rs("pzdj")=pzdj_str2
       rs("ddlx")=ddlx_str2
       rs("shfs")=shfs_str2

       rs("xzdh")=xzdh
       rs("shr")=shr
       rs("shdh")=shdh
       rs("shdz")=shdz
       rs("yzbm")=yzbm
       rs("qtsm")=qtsm
       rs("djrq")=now()

		if is_adm=1 then
	       rs("dqzt")=dqzt
	       if dgdj<>"" then rs("dgdj")=dgdj +0
	       if zje<>"" then rs("zje")=zje +0
	       if yjje<>"" then rs("yjje")=yjje +0
	       rs("bz")=bz
		end if

	   rs.update
       response.write "修改成功<br>"
     else 
	   response.write "操作失败<br>"
    end if
   rs.close
END SUB


SUB check_modify_del_user()
       if is_adm=1 or dlwm=request.cookies("ggymdlwm") then can_modify_del_user=1
END SUB

SUB check_modify_del_order()
       dim dqzt_tmp
       can_modify_del_order=0
       dqzt_tmp=cint(left(rs("dqzt"),2))
       if is_adm=1 or dqzt_tmp<=4 then can_modify_del_order=1
END SUB

SUB false_end_process()   '出错结束处理
   response.cookies("ggymadm")=""
   response.cookies("ggymdlwm")=""
   response.cookies("ggymndxm")=""
   response.cookies("ggymcysj")=""
   response.write "<br>正在处理，请稍等...<br>"
   end_this_file()
END SUB







SUB end_this_file()
	response.write "<font size=2 color=#666666><br><br><hr>如有必要，请联系：<br>"
	response.write "诺敏河鸭稻米农民合作社  王艳秋 先生<br>"
	response.write "地址: 黑龙江省绥棱县上集镇天放村10组<br>"
	response.write "邮编: 152235<br>"
	response.write "电话: 13029924234 0455-5160011<br>"
	response.write "QQ: 492533636<br>"
	response.write "Email: <a href='mailto:guaguayami@sohu.com'>guaguayami@sohu.com</a><br>"
	response.write "欢迎访问我们的博客: <a href='http://guaguayami.blog.sohu.com'>guaguayami.blog.sohu.com</a><br>"
	response.write "诺敏河鸭稻米农民合作社<br>诺敏河定制农业发展基地<br>荣誉出品：呱呱鸭米<br></font>"
	response.write "</body>"
	response.write "</html>" 
	response.end
END SUB



%>