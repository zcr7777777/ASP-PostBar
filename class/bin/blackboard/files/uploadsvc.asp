<%
response.charset="utf-8"
%>
<head><title>上传文件</title><link rel="stylesheet" type="text/css" href="/bin/css/istyle.css"></head><iframe src="/bin/iframe/bottom.html" scrolling="no" frameborder="0" class="ifr"></iframe>
<%
ttb=request.totalbytes
if ttb<300 then
response.redirect("./upload.asp")
else
response.buffer=true
response.write("上传完成，请不要离开此页面，服务器正在处理中...<br>")
response.flush
aFData=request.binaryread(ttb-1)
divider=leftB(aFData,clng(instrb(aFData,chrB(13)&chrB(10)))-1)
datastart=instrb(aFData,chrB(13)&chrB(10) & chrB(13)&chrB(10))+4 
dataend=instrb(datastart+1,aFData,divider)-datastart
rdata=midb(aFData,datastart,dataend)
nleft=instrb(aFData,chrb(108)&chrb(101)&chrb(110)&chrb(97))+8
nright=instrb(aFData,chrb(84)&chrb(121)&chrb(112)&chrb(101))-nleft-10.5
filename=midb(aFData,nleft,nright)
set conn=server.createobject("adodb.connection")
conn.open "signclass"
set rsa=server.createobject("adodb.recordset")
sql="select * from filetree"
rsa.open sql,conn,1,3
if rsa.eof or rsa.bof then
fileid=1
else
rsa.movelast
fileid=rsa(0)+1
end if
rsa.addnew
rsa("fileid")=fileid
rsa("filename").appendchunk filename
rsa("totalbytes")=ttb
rsa("private")=0
rsa.update
rsa.close
set rsa=nothing
set rs=server.createobject("adodb.recordset")
rs.open "select * from files",conn,1,3
rs.addnew
rs("filecontent").appendchunk rdata
rs("fileid")=fileid
rs.update
rs.close
set rs=nothing
conn.close
set conn=nothing
response.clear
response.write("上传成功，文件id为："&fileid)
response.write("<br>请选择是否私有此文件：<form method='POST' action='./privatization.asp?setid="&fileid&"'><select name='private'><option value='false'>保持公开</option><option value='true'>私有</option></select><input type='submit' name='send' value='确定'>")
end if
%>
