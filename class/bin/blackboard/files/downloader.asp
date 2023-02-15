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
response.write("请输入文件id:<form method='POST' action='./downloader.asp'><input type='text' name='id'><input type='submit' name='send' value='提交'>")
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
response.write("&fileid="&fileid&"'>点击下载</a><br>文件名称为：")
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
end if
end if
%>