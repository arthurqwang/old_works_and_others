Set fs=Wscript.CreateObject("Scripting.FileSystemObject6")
ss=fs.GetAbsolutePathName (CurDir)
strHostName ="localhost"
strVRPath=InputBox("请输入本系统所在目录","设定路径",ss)
i = InStrRev(ss, "\")
if i<Len(ss)-1 and i>0 then
vn = Right(ss, Len(ss) - i)
end if

if right(ss,2)=":\" then '如果是根目录
vn=lcase(left(ss,1))
end if

strVRName=InputBox("请输入虚拟目录名,然后用[http://localhost/虚拟路径名]来访问本系统","设定虚拟路径",vn)
strDefaultDoc="default.asp"  '起始文档

'---------------------------------------------------------------------
Dim ServiceObj,ServerObj,VirDir '服务，站点，虚拟目录  
Set ServiceObj = GetObject("IIS://"&strHostName&"/W3SVC")' 首先创建一个服务实例  

'if ServiceObj.StartType=4 then
'ServiceObj.StartType = 2  ' 自动
 'ServiceObj.StartType = 3  ' 手动
'ServiceObj.StartType = 4  ' 禁用
 'ServiceObj.SetInfo
'end if
'---------------------------------------------------------------------
On Error Resume Next
Set ServerObj=GetObject("IIS://" & strHostName & "/W3SVC/1")

If err=-2147024893 Then
MsgBox "IIS不存在!" & vbcrlf & "请验证IIS是否已正确安装!",vbcritical
Wscript.Quit
ElseIf err<>0 Then
'MsgBox "未知错误!",vbcritical '如果是默认web站点没有的话
'---------------------------------------------------------
createWebSite
'----------------------------------------------------------
'Wscript.Quit
End If

On Error GoTo 0

Set objVirtualDir=ServerObj.GetObject("IISWebVirtualDir","Root")
For each VR in objVirtualDir
If VR.Name=strVRName Then
MsgBox "虚拟目录" & strVRName & "已存在!",vbinformation
Wscript.Quit
End If
Next

On Error Resume Next
'Set fs=Wscript.CreateObject("Scripting.FileSystemObject6")
Set objFolder=fs.GetFolder(strVRPath)

If err=76 Then 
MsgBox "路径" & strVRPath & "不存在!",vbcritical
Wscript.Quit
End If

Set objFolder=nothing
Set fs=nothing
On Error GoTo 0

On Error Resume Next
Set VirDir=objVirtualDir.Create("IISWebVirtualDir",strVRName)

VirDir.Path=strVRPath
VirDir.AccessRead=true '读取
VirDir.AccessScript=True '运行脚本
'VirDir.AccessWrite = True '写入
'VirDir.AccessExecute = True   '执行
VirDir.EnableDirBrowsing = False '目录浏览  
VirDir.EnableDefaultDoc=True  

VirDir.AppCreate2 2  
VirDir.AppFriendlyName="默认应用程序" '可以有自己的global.aua
VirDir.DefaultDoc=VirDir.DefaultDoc & "," & strDefaultDoc

VirDir.setInfo

If err<>0 Then
MsgBox "创建虚拟目录失败!",vbcritical
Else
MsgBox "虚拟目录" & strVRName & "成功创建在服务器" & strHostName & "上!",vbinformation,"安装成功了！"
End If

'ServiceObj.Start   '实际上无法启动任何服务
'If (Err.Number <> 0) Then   
'MsgBox "起动IIS服务时出错！请手动启动IIS服务!",vbcritical
'Wscript.Quit
'End If  

'ServerObj.Start  
'If (Err.Number <> 0) Then   
'MsgBox "起动Web站点时出错！请手动启动Web站点!",vbcritical
'End If  


sub createWebSite()
WNumber=1  
Do While IsObject(ServiceObj.GetObject("IIsWebServer",WNumber))  
If Err.number<>0 Then  
Err.Clear()  
Exit Do  
End If  
WNumber=WNumber+1  
Loop  

Set ServerObj = ServiceObj.Create("IISWebServer", WNumber)' 然后创建一个WEB服务器  

If (Err.Number <> 0) Then' 是否出错  
MsgBox "错误: 创建Web服务器的ADSI操作失败！",vbcritical
Wscript.Quit
End If  

' 接着配置服务器  
ServerObj.ServerSize = 1 ' 中型大小  
ServerObj.ServerComment = "运行清露论坛"  
ServerObj.ServerBindings = 80 '端口  
ServerObj.EnableDefaultDoc=True  

' 提交信息  
ServerObj.SetInfo  
end sub