Set fs=Wscript.CreateObject("Scripting.FileSystemObject6")
ss=fs.GetAbsolutePathName (CurDir)
strHostName ="localhost"
strVRPath=InputBox("�����뱾ϵͳ����Ŀ¼","�趨·��",ss)
i = InStrRev(ss, "\")
if i<Len(ss)-1 and i>0 then
vn = Right(ss, Len(ss) - i)
end if

if right(ss,2)=":\" then '����Ǹ�Ŀ¼
vn=lcase(left(ss,1))
end if

strVRName=InputBox("����������Ŀ¼��,Ȼ����[http://localhost/����·����]�����ʱ�ϵͳ","�趨����·��",vn)
strDefaultDoc="default.asp"  '��ʼ�ĵ�

'---------------------------------------------------------------------
Dim ServiceObj,ServerObj,VirDir '����վ�㣬����Ŀ¼  
Set ServiceObj = GetObject("IIS://"&strHostName&"/W3SVC")' ���ȴ���һ������ʵ��  

'if ServiceObj.StartType=4 then
'ServiceObj.StartType = 2  ' �Զ�
 'ServiceObj.StartType = 3  ' �ֶ�
'ServiceObj.StartType = 4  ' ����
 'ServiceObj.SetInfo
'end if
'---------------------------------------------------------------------
On Error Resume Next
Set ServerObj=GetObject("IIS://" & strHostName & "/W3SVC/1")

If err=-2147024893 Then
MsgBox "IIS������!" & vbcrlf & "����֤IIS�Ƿ�����ȷ��װ!",vbcritical
Wscript.Quit
ElseIf err<>0 Then
'MsgBox "δ֪����!",vbcritical '�����Ĭ��webվ��û�еĻ�
'---------------------------------------------------------
createWebSite
'----------------------------------------------------------
'Wscript.Quit
End If

On Error GoTo 0

Set objVirtualDir=ServerObj.GetObject("IISWebVirtualDir","Root")
For each VR in objVirtualDir
If VR.Name=strVRName Then
MsgBox "����Ŀ¼" & strVRName & "�Ѵ���!",vbinformation
Wscript.Quit
End If
Next

On Error Resume Next
'Set fs=Wscript.CreateObject("Scripting.FileSystemObject6")
Set objFolder=fs.GetFolder(strVRPath)

If err=76 Then 
MsgBox "·��" & strVRPath & "������!",vbcritical
Wscript.Quit
End If

Set objFolder=nothing
Set fs=nothing
On Error GoTo 0

On Error Resume Next
Set VirDir=objVirtualDir.Create("IISWebVirtualDir",strVRName)

VirDir.Path=strVRPath
VirDir.AccessRead=true '��ȡ
VirDir.AccessScript=True '���нű�
'VirDir.AccessWrite = True 'д��
'VirDir.AccessExecute = True   'ִ��
VirDir.EnableDirBrowsing = False 'Ŀ¼���  
VirDir.EnableDefaultDoc=True  

VirDir.AppCreate2 2  
VirDir.AppFriendlyName="Ĭ��Ӧ�ó���" '�������Լ���global.aua
VirDir.DefaultDoc=VirDir.DefaultDoc & "," & strDefaultDoc

VirDir.setInfo

If err<>0 Then
MsgBox "��������Ŀ¼ʧ��!",vbcritical
Else
MsgBox "����Ŀ¼" & strVRName & "�ɹ������ڷ�����" & strHostName & "��!",vbinformation,"��װ�ɹ��ˣ�"
End If

'ServiceObj.Start   'ʵ�����޷������κη���
'If (Err.Number <> 0) Then   
'MsgBox "��IIS����ʱ�������ֶ�����IIS����!",vbcritical
'Wscript.Quit
'End If  

'ServerObj.Start  
'If (Err.Number <> 0) Then   
'MsgBox "��Webվ��ʱ�������ֶ�����Webվ��!",vbcritical
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

Set ServerObj = ServiceObj.Create("IISWebServer", WNumber)' Ȼ�󴴽�һ��WEB������  

If (Err.Number <> 0) Then' �Ƿ����  
MsgBox "����: ����Web��������ADSI����ʧ�ܣ�",vbcritical
Wscript.Quit
End If  

' �������÷�����  
ServerObj.ServerSize = 1 ' ���ʹ�С  
ServerObj.ServerComment = "������¶��̳"  
ServerObj.ServerBindings = 80 '�˿�  
ServerObj.EnableDefaultDoc=True  

' �ύ��Ϣ  
ServerObj.SetInfo  
end sub