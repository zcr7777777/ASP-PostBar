<%
ttid=request("ttid")
text=request("text")
uid=request.cookies("uid")
if uid="" then
response.redirect("./login.asp?from=index")
end if
Set conn=Server.CreateObject("Adodb.Connection")
set rsa=Server.CreateObject("Adodb.Recordset")
conn.Open "signclass"
sql2="select * from blackboard"
rsa.CursorLocation=3
rsa.open sql2,conn,1,3
rsacnt=rsa.recordcount
nempty=0
for i=0 to rsacnt-2
if ttid=rsa(3).value&rsa(4).value then
nempty=1
end if
rsa.movenext
next
if ttid=rsa(3).value&rsa(4).value then
nempty=1
end if
if nempty=0 then
response.redirect("../?from=commenterror")
else
tid=right(ttid,len(ttid)-12)
if text="" then
response.redirect("./comment.asp?like=0&from=empty&tim="&left(ttid,12)&"&tid="&tid)
else
set rsb=Server.CreateObject("Adodb.Recordset")
sqlc="select commentc from blackboard where tid="&tid
rsb.open sqlc,conn,1,3
commentcn=rsb(0)+1



set rs=Server.CreateObject("Adodb.Recordset")
sql="select * from `"&ttid&"`"
rs.CursorLocation=3
rs.open sql,conn,1,3
rscnt=rs.recordcount
sql="insert into `"&ttid&"` values('"&uid&"','0','"&text&"','"&rscnt+1&"');"
conn.execute(sql)
sql3="update `blackboard` set `commentc`="&commentcn&" where `tid`="&tid
conn.execute(sql3)
response.redirect("./?from=create&id="&ttid)

end if
end if
conn.close
set conn=nothing
%>