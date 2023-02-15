<%
response.charset="utf-8"
%>
<head><title>下载文件</title><link rel="stylesheet" type="text/css" href="/bin/css/istyle.css"></head><iframe src="/bin/iframe/bottom.html" scrolling="no" frameborder="0" class="ifr"></iframe>
<%
fileid=request("id")
if request.cookies("jumpto")="download" then
response.cookies("jumpto")=""
response.cookies("downloadid")=""
end if
if fileid="" then
response.write("<form method='POST' action='./downloader.asp'>请点击文件名下载或输入文件id:<input type='text' name='id'><input type='submit' name='send' value='查询'>")
response.write("<hr>公开下载的文件：<br><table border=1><thead><tr><th>文件名称</th><th>id</th><th>文件大小</th></tr></thead><tbody>")
set conna=server.createobject("adodb.connection")
conna.open "signclass"
set rsa=server.createobject("adodb.recordset")
rsa.CursorLocation=3
sql="select * from filetree"
rsa.open sql,conna,1,3
rsa.movefirst
for j=1 to rsa.recordcount
if cint(rsa(4))=0 then
response.write("<tr><th><a href='./downloader.asp?id="&rsa(0)&"'>"&chrb(34))
response.binarywrite(rsa(1))
response.write("</a></th><th>"&rsa(0)&"</th><th>")
if rsa(2)<1024 then
  response.write(rsa(2)&"B")
  else
    if rsa(2)<1048576 then
    response.write(round(rsa(2)/1024,2)&"KB")
    else
      response.write(round(rsa(2)/1048576,2)&"MB")
    end if
  end if
response.write("</th></tr>")
end if
rsa.movenext
next
response.write("</tbody></table><hr>本账户下私有的文件：")
if request.cookies("uid")="" then
response.write("<br><a href='../login.asp'>登录</a>查看文件列表")
else
response.write("<br><table border=1><thead><tr><th>文件名称</th><th>id</th><th>文件大小</th></tr></thead><tbody>")
rsa.movefirst
for j=1 to rsa.recordcount
if cint(rsa(4))=1 and rsa(3)=request.cookies("uid") then
response.write("<tr><th><a href='./downloader.asp?id="&rsa(0)&"'>"&chrb(34))
response.binarywrite(rsa(1))
response.write("</a></th><th>"&rsa(0)&"</th><th>")
if rsa(2)<1024 then
  response.write(rsa(2)&"B")
  else
    if rsa(2)<1048576 then
    response.write(round(rsa(2)/1024,2)&"KB")
    else
      response.write(round(rsa(2)/1048576,2)&"MB")
    end if
  end if
response.write("</th></tr>")
rsa.movenext
end if
next
response.write("</tbody></table>")
end if
else
set conn=server.createobject("adodb.connection")
conn.open "signclass"
set rs=server.createobject("adodb.recordset")
sql="select * from filetree where fileid="&fileid
rs.open sql,conn,1,3
if rs.eof or rs.bof then
response.write("文件不存在！<br><a href='./downloader.asp'>返回</a>")
else
response.write("<a href='./download.asp?filename=")
response.binarywrite(rs(1))
response.write("&fileid="&fileid&"'>点击下载</a><br>此文件名称："&chrb(34))
response.binarywrite(rs(1))
ttb=rs(2).value
response.write("<br>此文件大小：")
  if ttb<1024 then
  response.write(ttb&"B")
  else
    if ttb<1048576 then
    response.write(round(ttb/1024,2)&"KB")
    else
      response.write(round(ttb/1048576,2)&"MB")
    end if
  end if
response.write("<br><a href='./downloader.asp'>返回下载其他文件</a>")
end if
end if
%>
