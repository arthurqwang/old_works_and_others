   <%
   dim conn   
   dim connstr
   
   'on error resume next
   call conn_init()

   sub conn_init()
       on error resume next
       connstr="DBQ="+server.mappath("database/board.mdb")+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};"
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
  end sub
  
  sub endConnection
      conn.close
      set conn=nothing
  end sub
%>