<%
   const iis3onchsys=false       '是否运行于IIS3+中文NT（或pws10a+中文win95）
   const pwsonchsys=true         '本参数是历史遗留问题，请不要改动它的值
   const ANNOUNCE_ALL=false      '是否允许一贴多投
   const PrevAnnounce=false      '是否允许显示前贴内容（如同回复EMAIL一样回复帖子）
   const PRECHAR="> "            '回复帖子时候的前导字符串，只有当PrevAnnounce=true时有效
   const ANNOUNCE_MAXBYTE=16384  '帖子内容最大的字节数,为16KB
   const SCRIPT_TIMEOUT=300      '服务器ASP脚本超时时间值，建议不要使用   
   const REFRESH_TIME=0          '帖子列表刷新时间，如果其值<100时无效不刷新
   const TIME_ADJUST=0  'hour    '如果服务器远在海外，用于调整帖子加贴时间（调整为北京时间），其值您自定
   const Need_password=true      '是否加贴时每次都需要输入口令
   const Need_Expresstion=false  '是否显示表情符号
   const HasSpace=true           '是否在每个主题之间加个空行

   dim WINNT_CHINESE
   WINNT_CHINESE=(len("是否加贴")=4)

   function strLength(str)
       if WINNT_CHINESE then
          dim l,t,c
          dim i
          l=len(str)
          t=l
          for i=1 to l
             c=asc(mid(str,i,1))
             if c<0 then c=c+65536  '汉字的ascii码都小于0
             if c>255 then
                t=t+1
             end if
          next
          strLength=t
       else 
          strLength=len(str)
       end if
   end function 



   function htmlencode(str)
    dim result
    dim l
    if isnull(str) then
       htmlencode=""
       exit function
    end if

    l=len(str)
    result=""
	dim i
	for i = 1 to l
	    select case mid(str,i,1)
	           case "<"
	                result=result+"&lt;"
	           case ">"
	                result=result+"&gt;"
	           case chr(34)
	                result=result+"&quot;"
	           case "&"
	                result=result+"&amp;"
	           case chr(13)
	                result=result+"<br>"
	           case chr(9)
	                result=result+"&nbsp;&nbsp;&nbsp;&nbsp;"
	           case chr(32)	           
	                'result=result+"&nbsp;"
	                if i+1<=l and i-1>0 then
	                   if mid(str,i+1,1)=chr(32) or mid(str,i+1,1)=chr(9) or mid(str,i-1,1)=chr(32) or mid(str,i-1,1)=chr(9)  then	                      
	                      result=result+"&nbsp;"
	                   else
	                      result=result+" "
	                   end if
	                else
	                   result=result+"&nbsp;"	                    
	                end if
	           case else
	                result=result+mid(str,i,1)
         end select
       next 
       htmlencode=result
   end function

   function htmlencode2(str)
    dim result
    dim l
    if isnull(str) then
       htmlencode2=""
       exit function
    end if

    l=len(str)
    result=""
	dim i
	for i = 1 to l
	    select case mid(str,i,1)
	           case "<"
	                result=result+"&lt;"
	           case ">"
	                result=result+"&gt;"
	           case chr(34)
	                result=result+"&quot;"
	           case "&"
	                result=result+"&amp;"
	           case chr(9)
	                result=result+"    "
	           case else
	                result=result+mid(str,i,1)
         end select
       next 
       htmlencode2=result
   end function


   sub ShowBody(Str)
    dim result,t1,t2,t3,t4
    dim l,pointer,end_pointer,tp,sp,ep,sap,eap,atp,le,re
    
    result=""
	dim i

'*********************************处理邮件地址@
    t1=LCase(str)&" " '为了解决邮件最后一个字符未计入问题
    t4=""
    sp=1
    atp=instr(1,t1,"@")
    end_pointer=0
   do while atp>1 and not isnull(atp)
   
    pointer=atp-1
    end_pointer=atp+1
    do while pointer>1 and ( (asc(mid(t1,pointer,1))>=45 and asc(mid(t1,pointer,1))<=46) or (asc(mid(t1,pointer,1))>=48 and asc(mid(t1,pointer,1))<=57) or (asc(mid(t1,pointer,1))>=94 and asc(mid(t1,pointer,1))<=96) or (asc(mid(t1,pointer,1))>=97 and asc(mid(t1,pointer,1))<=122) )
       pointer=pointer-1
    loop
    do while end_pointer<len(t1) and ( (asc(mid(t1,end_pointer,1))>=45 and asc(mid(t1,end_pointer,1))<=46) or (asc(mid(t1,end_pointer,1))>=48 and asc(mid(t1,end_pointer,1))<=57) or (asc(mid(t1,end_pointer,1))>=94 and asc(mid(t1,end_pointer,1))<=96) or (asc(mid(t1,end_pointer,1))>=97 and asc(mid(t1,end_pointer,1))<=122) )
       end_pointer=end_pointer+1
    loop
    pointer=pointer+1
    end_pointer=end_pointer-1
    t4=t4&mid(str,sp,pointer-sp)
    t2=mid(str,pointer,end_pointer-pointer+1)
    if end_pointer-pointer>=6 and LCase(mid(t1,pointer-7,7))<>"mailto:" then
      t3="<a href=mailto:"&t2&">"&t2&"</a>"
    else
      t3=t2
    end if
    t4=t4&t3
    sp=end_pointer+1
    atp=instr(sp,t1,"@")
   loop
    t4=t4&mid(str,end_pointer+1,len(str)-end_pointer)
    str=t4

'*************************处理http://
    t1=LCase(str)
    t4=""
    pointer=instr(1,t1,"http://")
    sp=1
    ep=pointer
 
    do while pointer>=1 
     
      t4=t4&mid(str,sp,ep-sp)
      end_pointer=len(str)
      tp=instr(pointer,t1," ")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,chr(9))
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,chr(13))
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,">")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,"<")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      for i=pointer+7 to end_pointer
        if abs(asc(mid(t1,i,1)))>=164 then
          if i<end_pointer+1 then
             end_pointer=i-1
             exit for
          end if
        end if
      next
      t2=mid(str,pointer,end_pointer-pointer+1)

      le=0
      re=0
      sap=-1
      eap=-1
      for i=pointer to 1 step -1
       if mid(t1,i,3)="<a " then
          sap=i
       end if
       if mid(t1,i,4)="</a>" then
          eap=i
       end if
       if sap<>-1 and eap<>-1 then
         exit for
       end if
      next
      if sap>eap then
        le=1
      end if

      for i=end_pointer to len(t1)
       if mid(t1,i,4)="</a>" then
          re=1
          exit for
       end if
      next
      
      if not(re=1 and le=1) then
        t3="<a href="&t2&">"&t2&"</a>"
      else
        t3=t2
      end if
      t4=t4&t3
      sp=end_pointer+1
      ep=instr(sp,t1,"http://")
      'pointer=pointer+len(t3)
      pointer=instr(end_pointer,t1,"http://")
    loop
    t4=t4&mid(str,sp,len(str)-sp+1)
    str=t4

'******************处理ftp://
    t1=LCase(str)
    t4=""
    pointer=instr(1,t1,"ftp://")
    sp=1
    ep=pointer

    do while pointer>=1 
     
      t4=t4&mid(str,sp,ep-sp)
      end_pointer=len(str)
      tp=instr(pointer,t1," ")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,chr(9))
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,chr(13))
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,">")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,"<")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      for i=pointer+6 to end_pointer
        if abs(asc(mid(t1,i,1)))>=164 then
          if i<end_pointer+1 then
             end_pointer=i-1
             exit for
          end if
        end if
      next
      t2=mid(str,pointer,end_pointer-pointer+1)

      le=0
      re=0
      sap=-1
      eap=-1
      for i=pointer to 1 step -1
       if mid(t1,i,3)="<a " then
          sap=i
       end if
       if mid(t1,i,4)="</a>" then
          eap=i
       end if
       if sap<>-1 and eap<>-1 then
         exit for
       end if
      next
      if sap>eap then
        le=1
      end if

      for i=end_pointer to len(t1)
       if mid(t1,i,4)="</a>" then
          re=1
          exit for
       end if
      next
      
      if not(re=1 and le=1) then
        t3="<a href="&t2&">"&t2&"</a>"
      else
        t3=t2
      end if
      t4=t4&t3
      sp=end_pointer+1
      ep=instr(sp,t1,"ftp://")
      'pointer=pointer+len(t3)
      pointer=instr(end_pointer,t1,"ftp://")
    loop
    t4=t4&mid(str,sp,len(str)-sp+1)
    str=t4

'********************处理mailto:  
    t1=LCase(str)
    t4=""
    pointer=instr(1,t1,"mailto:")
    sp=1
    ep=pointer

    do while pointer>=1 
     
      t4=t4&mid(str,sp,ep-sp)
      end_pointer=len(str)
      tp=instr(pointer,t1," ")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,chr(9))
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,chr(13))
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,">")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      tp=instr(pointer,t1,"<")
      if tp<end_pointer and tp<>0 and not isnull(tp) then
        end_pointer=tp-1
      end if
      for i=pointer+7 to end_pointer
        if abs(asc(mid(t1,i,1)))>=164 then
          if i<end_pointer+1 then
             end_pointer=i-1
             exit for
          end if
        end if
      next
      t2=mid(str,pointer,end_pointer-pointer+1)

      le=0
      re=0
      sap=-1
      eap=-1
      for i=pointer to 1 step -1
       if mid(t1,i,3)="<a " then
          sap=i
       end if
       if mid(t1,i,4)="</a>" then
          eap=i
       end if
       if sap<>-1 and eap<>-1 then
         exit for
       end if
      next
      if sap>eap then
        le=1
      end if

      for i=end_pointer to len(t1)
       if mid(t1,i,4)="</a>" then
          re=1
          exit for
       end if
      next
      
      if not(re=1 and le=1) then
        t3="<a href="&t2&">"&t2&"</a>"
      else
        t3=t2
      end if
      t4=t4&t3
      sp=end_pointer+1
      ep=instr(sp,t1,"mailto:")
      'pointer=pointer+len(t3)
      pointer=instr(end_pointer,t1,"mailto:")
     loop
    t4=t4&mid(str,sp,len(str)-sp+1)
    str=t4


    l=len(str)
	for i = 1 to l
	    select case mid(str,i,1)
        '注释掉的是为了能引用url
	           'case "<"
	           '     result=result+"&lt;"
	           'case ">"
	           '     result=result+"&gt;"
	           'case chr(34)
	           '     result=result+"&quot;"
	           'case "&"
	           '     result=result+"&amp;"
	           case chr(13)
	                result=result+"<br>"
	           case chr(9)
	                result=result+"&nbsp;&nbsp;&nbsp;&nbsp;"
	           case chr(32)	           
	                'result=result+"&nbsp;"
	                if i+1<=l and i-1>0 then
	                   if mid(str,i+1,1)=chr(32) or mid(str,i+1,1)=chr(9) or mid(str,i-1,1)=chr(32) or mid(str,i-1,1)=chr(9)  then	                      
	                      result=result+"&nbsp;"
	                   else
	                      result=result+" "
	                   end if
	                else
	                   result=result+"&nbsp;"	                    
	                end if
	           case else
	                result=result+mid(str,i,1)
         end select
       next 
       response.write result
   end sub

   sub display(str)
     if not isNULL(str) then 
           showbody str
     end if
   end sub
   
   
   


%>
