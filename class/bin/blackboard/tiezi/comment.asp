<%Response.Charset="utf-8"%>
<%
cklike=2
uuid=Request.Cookies("uid")
likep=Request("like")
if likep=0 then
Response.Write("开发中...")
end if
if likep=1 then
tid=Request("tid")
tim=Request("tim")
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