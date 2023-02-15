<%
setid=request("setid")
toprivate=request("private")
csetid=request.cookies("privateid")
if csetid="" then
csetid=csetid
else
setid=csetid
toprivate="true"
response.cookies("privateid")=""
response.cookies("jumpto")=""
end if
uid=request.cookies("uid")
pwd=request.cookies("pwd")
if setid="" or toprivate="" or toprivate="false" then
response.redirect("./upload.asp")
else
if uid="" or pwd="" then
response.cookies("privateid")=setid
response.redirect("../login.asp?from=private")
end if
set conn=server.createobject("adodb.connection")
conn.open "signclass"
sql1="update filetree set uid='"&uid&"' where fileid="&setid&";"
sql2="update filetree set private=1 where fileid="&setid&";"
conn.execute(sql1)
conn.execute(sql2)
response.redirect("./upload.asp")
end if
%>