<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.charset="utf-8"
uid = Request.Cookies("uid")
pwd = Request.Cookies("pwd")
if uid="" or pwd="" then
ck=0
Response.redirect("./login.asp?from=index")
else
ck=1
end if
from=Request.QueryString("from")
if from="loginbyreg" then
response.write("<script>alert('注册成功')</script>")
end if
if from="likesucc" then
Response.write("<script>alert('点赞成功')</script>")
end if
if from="likeerr" then
Response.write("<script>alert('你已赞过')</script>")
end if
if from="login" then
Response.write("<script>alert('登录成功')</script>")
end if
if from="reg" then
Response.write("<script>alert('注册成功')</script>")
end if
if from="create" then
Response.write("<script>alert('ID:"&Request.querystring("cidd")&" 发帖成功')</script>")
end if
if from="commenterror" then
response.write("<script>alert('帖子不存在')</script>")
end if
%>
<html>
<head>
<title>留言板</title>
<link rel="stylesheet" type="text/css" href="../css/istyle.css">
</head>
<body>
<ul>
  <li><b>留言板</b></li>
  <br>
  <li><a href="/?from=index"><b>在线选课</b></a></li>
  <br>
  <li><a href="./login.asp?from=logout&hide=1"><b>登出</b></a></li>
  <br>
  <br>
  <li><b>站长主页</b></li>
  <li><a href="https://github.com/zcr7777777/" target="_blank"><b>GitHub</b></a></li>
  <br>
  <li><a href="https://space.bilibili.com/470944142" target="_blank"><b>bilibili</b></a></li>
  <br>
  <li><a href="https://www.miyoushe.com/ys/accountCenter/postList?id=328055840" target="_blank"><b>米游社</b></a></li>
  <br>
  <li><b>制作</b></li>
  <li><b><h3 style="color: blue; font-size: 1.5em; background-color: yellow; text-align: center;">Leo唐</h3></b></li>
</ul>
<div class="lefth">
<a href="./create.asp"><x style="font-size: 1.5em;"><b>创建新帖</b></x></a> <a href="./">刷新</a>
<a href="./user/" target="_blank" style="color: white; padding: 8px 16px; text-decoration: none; background-color: blue; border-radius: 4px;"><b>我的</b></a></li>
<a href="./files/downloader.asp" target="_blank" style="color: white; padding: 8px 16px; text-decoration: none; background-color: red; border-radius: 4px;"><b>下载文件</b></a></li>
<a href="./files/upload.asp" target="_blank" style="color: white; padding: 8px 16px; text-decoration: none; background-color: red; border-radius: 4px;"><b>上传文件</b></a></li>
<hr>
<%
if ck=1 then
set rs=server.createobject("adodb.recordset")
Set conn=Server.CreateObject("Adodb.Connection")
conn.Open "signclass"
sql="select * from blackboard"
rs.CursorLocation=3
rs.open sql,conn,1,3
rscnt=rs.recordcount
if rscnt=0 then
Response.cookies("cid")=1
Response.write("没有条目")
else
rs.movelast
tid=rs(4)
Response.cookies("cid")=tid+1
for i=0 to rscnt-2
unsigned=rs(1)
tuid=rs(0)
if unsigned="0" then
Response.write("<b>发帖用户:</b><a href='./user/?uid="&tuid&"' target='_blank'>"&tuid&"</a>")
else
Response.write("<b style='color: red;'>匿名用户</b>")
end if
resp=rs(3)
tresp=mid(resp,1,4)&"年"&mid(resp,5,2)&"月"&mid(resp,7,2)&"日"&mid(resp,9,2)&"时"&mid(resp,11,2)&"分"
Response.write("<b> 发帖时间:</b>"&tresp&" ")
tid=rs(4)
Response.write(" <b>ID:</b>"&tid)
if tuid=uid then
Response.write(" <a href='./remove.asp?confirmed=0&id=" & tid & "&tim="&resp&"&uid=" & uid & "'><x  style='color: #555;'><b>删除本贴</b></x></a>")
end if
Response.write(" <a href='./tiezi/?id="&tid&"' target='_blank'><x  style='color: green;'><b>查看评论详情</b></x></a>")
resp=rs(2)
Response.write("<br><b>帖子正文:</b><table border='1' cellspacing='0' width='100%' style='border-radius:2px;border:4px solid;'><tr><td style='word-break:break-all'>"&resp&"</td></tr></table>")
likec=rs(5)
commentc=rs(6)
Response.write("<a href='./tiezi/comment.asp?like=1&tim="&rs(3)&"&tid="&tid&"'><x  style='color:blue;'><b>点赞</b></x></a><x>数："&likec&"  <a href='./tiezi/comment.asp?like=0&tim="&rs(3)&"&tid="&tid&"'><x  style='color:blue;'><b>评论</b></x></a>数："&commentc&"</x>")
Response.write("<hr>")
rs.moveprevious
next
unsigned=rs(1)
tuid=rs(0)
if unsigned="0" then
tuid=rs(0)
Response.write("<b>发帖用户:</b><a href='./user/?uid="&tuid&"' target='_blank'>"&tuid&"</a>")
else
Response.write("<b style='color: red;'>匿名用户</b>")
end if
resp=rs(3)
tresp=mid(resp,1,4)&"年"&mid(resp,5,2)&"月"&mid(resp,7,2)&"日"&mid(resp,9,2)&"时"&mid(resp,11,2)&"分"
Response.write("<b> 发帖时间:</b>"&tresp&" ")
tid=rs(4)
Response.write("<b> ID:</b>"&tid)
if tuid=uid then
Response.write(" <a href='./remove.asp?confirmed=0&id=" & tid & "&tim="&resp&"&uid=" & uid & "'><x  style='color: #555;'><b>删除本贴</b></x></a>")
end if
Response.write(" <a href='./tiezi/?id="&tid&"' target='_blank'><x  style='color: green;'><b>查看评论详情</b></x></a>")
resp=rs(2)
Response.write("<br><b>帖子正文:</b><table border='1' cellspacing='0' width='100%' style='border-radius:2px;border:4px solid;'><tr><td style='word-break:break-all'>"&resp&"</td></tr></table>")
likec=rs(5)
commentc=rs(6)
Response.write("<a href='./tiezi/comment.asp?like=1&tim="&rs(3)&"&tid="&tid&"'><x  style='color:blue;'><b>点赞</b></x></a><x>数："&likec&"  <a href='./tiezi/comment.asp?like=0&tim="&rs(3)&"&tid="&tid&"'><x  style='color:blue;'><b>评论</b></x></a>数："&commentc&"</x>")
Response.write("<hr>")
Response.write("共计" & rscnt & "条目")
end if
conn.close
set conn=nothing
end if
%>
</div>
</body>
</html>
