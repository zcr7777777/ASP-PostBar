<%Response.Charset="utf-8"%>
<%
if request("from")="empty" then
response.write("<script>alert('不得为空')</script>")
end if
uuid=Request.Cookies("uid")
if uuid="" then
response.redirect("../login.asp?from=index")
end if
cklike=2
tid=Request("tid")
tim=Request("tim")
likep=Request("like")
if likep=0 then
Response.write("<head><title>发表评论</title><link rel='stylesheet' type='text/css' href='/bin/css/istyle.css'></head><form action='./commentservice.asp?ttid="&tim&tid&"' method='post' accept-charset='ISO-8859-1'><x>请输入评论：</x><label for='text'></label><br><textarea id='text' name='text' style='width: 399px; height: 100px; border: 3px solid green; border-radius: 3px;'></textarea><br><x style='color: grey;'>附加到：</x><input type='text' name='ttid' value='"&tim&tid&"' disabled=true style='width:125px;border: 2px solid grey;'><br><button class='btn' style='vertical-align:middle'><span>提交</span></button></form>")
end if
if likep=1 then
set rs=Server.CreateObject("Adodb.Recordset")
Set conn=Server.CreateObject("Adodb.Connection")
conn.Open "signclass"
sql="select * from `"&tim&tid&"`"
rs.open sql,conn,1,3
if rs.EOF or rs.BOF then
cklike=1
else
rs.MoveLast
ct=rs(3)
for i=0 to ct
if rs.eof or rs.bof then
cklike=1
else
quid=rs(0)
liked=rs(1)
if  quid=uuid and liked=1 then
cklike=0
i=ct
else
rs.MovePrevious
end if
end if
next
if cklike=2 then
cklike=1
end if
end if
if cklike=1 then
sql1="insert into `"&tim&tid&"` values('"&uuid&"','1','null','"&ct+1&"');"
conn.Execute(sql1)
end if
conn.Close
set conn=nothing
if cklike=1 then
set rsa=server.createobject("adodb.recordset")
Set conna=Server.CreateObject("Adodb.Connection")
conna.Open "signclass"
sql2="select likec from blackboard where tid="&tid
rsa.open sql2,conna,1,3
likecn=rsa(0)+1
sql3="update `blackboard` set `likec`="&likecn&" where `tid`="&tid
conna.execute(sql3)
conna.close
set conna=nothing
end if
end if
if cklike=1 then
Response.redirect("../?from=likesucc")
end if
if cklike=0 then
Response.redirect("../?from=likeerr")
end if
%>
