
<%
'����ļ�Ҫ������Ƕ���ļ����
dim conn   
dim connstr

dim cmdTemp,msg
dim InsertCursor
dim dataconn
dim rs
dim sql
dim dlwm,dlmm,ndxm,cysj,gddh,czhm,jstx,dzyj,qtfs  '�ͻ���Ϣ
dim dlwm_tem,dlmm_tem,ndxm_tem,cysj_tem  '���ڹ���Ա�����ͻ�ʱ
dim dgxs,pzdj,ddlx,shfs,xzdh,shr,shdh,shdz,yzbm,qtsm        '������Ϣ
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

  SUB conn_reconnect()  'Ϊ�˱�֤���¼���ļ�¼�ܹ���ѯ������������������һ��
     endConnection()
     conn_init()
  END SUB






SUB verify_user()   '����û��Ƿ�login
if  request.cookies("ggymadm")="YES" then is_adm=1
dlwm=request.cookies("ggymdlwm")
ndxm=request.cookies("ggymndxm")
cysj=request.cookies("ggymcysj")
END SUB


SUB find_user()   '�����ݿ��м���û����ڷ�
   if dlwm="" then
      response.write "ʧ�ܣ�[��½����]������д<br>"
      false_end_process()
   end if
   if dlmm="" then
      response.write "ʧ�ܣ�[��½����]������д<br>"
      false_end_process()
   end if

   '������ݿ��е��û��Ƿ����
        set rs=server.createobject("adodb.recordset")
        sql="select * from userlist where dlwm='" & dlwm & "'"
        rs.open sql,conn,1,1

        if not rs.eof then 
           user_exist=1
           if rs("dlmm")=dlmm then pw_ok=1
        end if

    if user_exist=1 then
        if pw_ok <> 1 then   '�û����ڣ������벻��ʱ
           response.write "ʧ�ܣ�[��½����]�ѱ�ռ�ã���[��½����]����<br>"
           false_end_process()           
        end if
        if pw_ok=1 then    '�˺���֤ͨ��
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
           '�����û�cookie
           response.cookies("ggymdlwm")=dlwm
           response.cookies("ggymndxm")=ndxm
           response.cookies("ggymcysj")=cysj

           '�ж��ǲ��ǹ���Ա
           if rs("yhqx")="1" then
              is_adm=1
              '���ù���Աcookie
              response.cookies("ggymadm")="YES" 
           end if
        end if
    end if
    rs.Close
END SUB


SUB check_new_user()   '������û����������
'��ǰ�� find_user() �Ѿ�������¼���� �� ��¼�����Ƿ�����д
	if user_exist=0 then
	   if ndxm="" then
	       response.write "ʧ�ܣ��״εǼǱ�����д[��������]<br>"
	       false_end_process()
	   end if
	   if cysj="" then
	       response.write "ʧ�ܣ��״εǼǱ�����д[�����ֻ�]<br>"
	       false_end_process()
	   end if
	end if
	'����ܹ�ִ�е��������������û���
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


SUB adduser()   '����һ�����û�
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
	   msg="���ݿ����ʧ�ܣ����Ժ�����" & err.Description
	else
	   msg="�ͻ��Ǽǳɹ�"
	end if
	
	InsertCursor.close
	dataconn.close
	
	response.write msg & "<br>"
	
    log_in=1
    '�����û�cookie
    response.cookies("ggymdlwm")=dlwm
    response.cookies("ggymndxm")=ndxm
    response.cookies("ggymcysj")=cysj
END SUB


SUB addorder()    '����һ���¶���,����Ա���ܸ��Լ��Ӷ����������԰�ͻ��Ӷ���
                  '��ʱdlwm=����Ա  dlwm_tem=�ͻ�
    dlwm_tem=request("dlwm_tem")
    ndxm_tem=request("ndxm_tem")
    cysj_tem=request("cysj_tem")

if is_adm=1 and dlwm_tem="" then
      response.write "����Աֻ�ܰ����ͻ��Ӷ������������Լ����¼Ӷ���<br>"
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

	if pzdj="0" then pzdj_str = "�ؼ�"
	if pzdj="1" then pzdj_str = "һ��"
	if pzdj="2" then pzdj_str = "����"

	if ddlx="0" then ddlx_str = "�ֻ�����"
	if ddlx="1" then ddlx_str = "���Ԥ��"

	if shfs="0" then shfs_str = "�ؿ�ֱ��"
	if shfs="1" then shfs_str = "ͬ����ȡ"

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
	InsertCursor("dqzt") = "1 ���µǼ�"
	InsertCursor("dgdj") = dgdj
	InsertCursor("zje") = zje
	InsertCursor("yjje") = yjje
	InsertCursor("bz") = bz
	if is_adm=1 then InsertCursor("bz") = "��"	
	InsertCursor.Update
	
	if err.number > 0 then
	   err.clear
	   FoundError=true
	   msg="���ݿ����ʧ�ܣ����Ժ�����" & err.Description
	else
	   msg="������Ϣ�Ǽǳɹ�"
	end if
	
	InsertCursor.close
	dataconn.close
	
	response.write msg & "<br>"
end if
END SUB


SUB showuser()   '��ʾ�û���Ϣ
   dim iii,tt_str
   iii=1
   only_single_user=request("only_single_user")
   dlwm_tem=request("dlwm_tem")
   set rs=server.createobject("adodb.recordset")
   sql="select * from userlist where dlwm='" & dlwm & "'"
   if is_adm=1 then sql="select * from userlist order by yhqx,ndxm,djrq"
   if only_single_user="1" then sql="select * from userlist where dlwm='" & dlwm_tem & "'"
   rs.open sql,conn,1,1
   response.write "<br><br><font color=#007700>�����˺���Ϣ</font><br>" 

       response.write "<center><table border=1 cellpadding=0 cellspacing=0 style=border-collapse:collapse bordercolor=#aaaaaa align=center width=1000>"
       response.write "<tr>"
       response.write "<td  align=center bgcolor=#ddddff width=30></td>"
       if is_adm=1 then
          response.write "<td  align=center bgcolor=#ddddff width=30></td>"
          response.write "<td  align=center bgcolor=#ddddff width=30></td>"
          response.write "<td  align=center bgcolor=#ddddff width=30></td>"
       end if
       if is_adm=1 then response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>���</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>�ͻ�<br>����</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>��½<br>����</font></td>"
       'response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>��¼<br>����</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>����<br>�ֻ�</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>�̶�<br>�绰</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>����<br>����</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>��ʱ<br>ͨѶ</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>����<br>�ʼ�</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>����<br>��ʽ</font></td>"
       response.write "<td  align=center bgcolor=#ddddff><font size=2 color=#996633>�Ǽ�<br>����</font></td>"
       response.write "</tr>"

   do while not rs.EOF
       response.write "<tr>"
       response.write "<td><a href='mdfyusr.asp?dlwm=" & rs("dlwm") & "'><font size=2 color=#339933>�޸�</font></a></td>"
       if is_adm=1 then
          if  rs("yhqx")="0" then
	         response.write "<td><a href='delusr.asp?dlwm=" & rs("dlwm") & "'><font size=2 color=#663399>ɾ��</font></a></td>"
	         response.write "<td><a href='ggymreg4.asp?dlwm_tem=" & rs("dlwm") & "&ndxm_tem=" & rs("ndxm") & "&cysj_tem=" & rs("cysj") & "'><font size=2 color=#669933>�ӵ�</font></a></td>"
	         response.write "<td><a href='showall.asp?only_single_user=1&dlwm_tem=" & rs("dlwm") & "'><font size=2 color=#993366>�鵥</font></a></td>"
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

SUB showorder()   '��ʾ������Ϣ
   dim total1,total2,total3,total4,total5
   only_single_user=request("only_single_user")
   dlwm_tem=request("dlwm_tem")
    iii=1
    set rs=server.createobject("adodb.recordset")
	sql="select orderlist.*,userlist.dlwm,userlist.ndxm from orderlist,userlist where orderlist.dlwm=userlist.dlwm and orderlist.dlwm='" & dlwm & "' order by orderlist.djrq desc"
	if is_adm=1 then sql="SELECT orderlist.*, userlist.dlwm,userlist.ndxm FROM orderlist, userlist WHERE orderlist.dlwm=userlist.dlwm ORDER BY orderlist.djrq DESC;"
    if only_single_user="1" then 	sql="select orderlist.*,userlist.dlwm,userlist.ndxm from orderlist,userlist where orderlist.dlwm=userlist.dlwm and orderlist.dlwm='" & dlwm_tem & "' order by orderlist.djrq desc"
	rs.open sql,conn,1,1
    response.write "<br><br><font color=#007700>���Ķ�����Ϣ</font><br>" 

       response.write "<center><table border=1 cellpadding=0 cellspacing=0 style=border-collapse:collapse bordercolor=#aaaaaa align=center width=1000>"
       response.write "<tr>"
       response.write "<td  align=center bgcolor=#ddffdd width=30></td>"
       response.write "<td  align=center bgcolor=#ddffdd width=30></td>"
       if is_adm=1 then response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>���</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>������</font></td>"
       if is_adm=1 then response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>�ͻ�<br>����</font></td>"
       if is_adm=1 then response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>��¼<br>����</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>����<br>����</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>Ʒ��<br>�ȼ�</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>����<br>����</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>�ջ�<br>��ʽ</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>ѡ��<br>�غ�</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>�ջ���</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>�ջ�<br>�绰</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>�ջ�<br>��ַ</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>����<br>����</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>����<br>˵��</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>�Ǽ�<br>����</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>��ǰ<br>״̬</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>����<br>����</font></td>"

       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>�ܽ��</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>�ѽ�<br>���</font></td>"
       response.write "<td  align=center bgcolor=#ddffdd><font size=2 color=#996633>��ע</font></td>"
       response.write "</tr>"

		total1=0
		total2=0
		total3=0
		total4=0
		total5=0
	do while not rs.EOF
       total1=total1+1  '��������
       if rs("dgxs")<>"" then total2=total2+cint(rs("dgxs"))
       if rs("zje")<>"" then total4=total4+cint(rs("zje"))
       if rs("yjje")<>"" then total5=total5+cint(rs("yjje"))
     
       tt_str=rs("djrq")
       tt_str=right(year(tt_str),2) & "-" & month(tt_str) & "-" & day(tt_str)
       tt_str=tt_str & "_" & trim(rs("oid"))
       response.write "<tr>"
       check_modify_del_order()
       if can_modify_del_order=1 then
	       response.write "<td><a href='mdfyodr.asp?oid=" & rs("oid") & "'><font size=2 color=#339933>�޸�</font></a></td>"
	       response.write "<td><a href='delodr.asp?oid=" & rs("oid") & "'><font size=2 color=#663399>ɾ��</font></a></td>"
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
    if total2<>0 then total3=cint(total4/total2*100)/100   'ƽ������
    response.write "<tr><td><font size=2 color=#0000ff>�ϼ�</font></td><td></td>"
    if is_adm=1 then response.write "<td></td>"
    response.write "<td align=right><font size=2 color=#0000ff>����<br>����<br>" & total1 & "</font></td>"
    if is_adm=1 then response.write "<td></td><td></td>"
    response.write "<td align=right><font size=2 color=#0000ff>������<br><br>" & total2 & "</font></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>"
    response.write "<td align=right><font size=2 color=#0000ff>ƽ��<br>����<br>" & total3 & "</font></td>"
    response.write "<td align=right><font size=2 color=#0000ff>�ܽ��<br><br>" & total4 & "</font></td>"
    response.write "<td align=right><font size=2 color=#0000ff>�ѽ�<br>���<br>" & total5 & "</font></td><td></td></tr>"
    response.write "</table></center>"
    if is_adm=1 then 
       response.write "<font size=2 color=#007700><br>�����������Ե������<a href='ggymreg2.html'>���ӿͻ��Ͷ�����Ϣ</a></font><br>"
    else
       response.write "<font size=2 color=#007700><br>�����������Ե������<a href='ggymreg3.asp'>���Ӷ�����Ϣ</a></font><br>"
    end if
    response.write "<font size=2 color=#ff0000><br>* ��˫��ǩ������ʽ����Ϊ׼�����ϵǼǽ�����ͨʹ��</font><br>"
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

       response.write "�޸ĳɹ�<br>"
     else 
	   response.write "����ʧ��<br>"
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
	
		if pzdj="0" then pzdj_str2 = "�ؼ�"
		if pzdj="1" then pzdj_str2 = "һ��"
		if pzdj="2" then pzdj_str2 = "����"
	
		if ddlx="0" then ddlx_str2 = "�ֻ�����"
		if ddlx="1" then ddlx_str2 = "���Ԥ��"
	
		if shfs="0" then shfs_str2 = "�ؿ�ֱ��"
		if shfs="1" then shfs_str2 = "ͬ����ȡ"

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
       response.write "�޸ĳɹ�<br>"
     else 
	   response.write "����ʧ��<br>"
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

SUB false_end_process()   '�����������
   response.cookies("ggymadm")=""
   response.cookies("ggymdlwm")=""
   response.cookies("ggymndxm")=""
   response.cookies("ggymcysj")=""
   response.write "<br>���ڴ������Ե�...<br>"
   end_this_file()
END SUB







SUB end_this_file()
	response.write "<font size=2 color=#666666><br><br><hr>���б�Ҫ������ϵ��<br>"
	response.write "ŵ����Ѽ����ũ�������  ������ ����<br>"
	response.write "��ַ: ������ʡ�������ϼ�����Ŵ�10��<br>"
	response.write "�ʱ�: 152235<br>"
	response.write "�绰: 13029924234 0455-5160011<br>"
	response.write "QQ: 492533636<br>"
	response.write "Email: <a href='mailto:guaguayami@sohu.com'>guaguayami@sohu.com</a><br>"
	response.write "��ӭ�������ǵĲ���: <a href='http://guaguayami.blog.sohu.com'>guaguayami.blog.sohu.com</a><br>"
	response.write "ŵ����Ѽ����ũ�������<br>ŵ���Ӷ���ũҵ��չ����<br>������Ʒ������Ѽ��<br></font>"
	response.write "</body>"
	response.write "</html>" 
	response.end
END SUB



%>