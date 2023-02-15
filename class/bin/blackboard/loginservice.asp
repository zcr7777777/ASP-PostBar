<%
response.charset="utf-8"
registed=request("registed")
requid=request.cookies("requid")
reqpwd=request.querystring("reqpwd")
set rs=server.createobject("adodb.recordset")
Set conn=Server.CreateObject("Adodb.Connection")
conn.Open "signclass"
sql="select pwd from bregister where uid='"&requid&"'"
rs.open sql,conn,1,3
if rs.eof or rs.bof then
response.write("参数错误：未注册或cookies配置错误")
else
tpwd=rs(0).value
if tpwd=reqpwd then
response.cookies("requid")=""
response.cookies("uid")=requid
response.cookies("pwd")=reqpwd
jumpto=request("jumpto")
if registed=1 then
response.redirect("./?from=loginbyreg")
else
if jumpto="private" then
response.redirect("./files/privatization.asp")
else
if jumpto="download" then
response.redirect("./files/downloader.asp?id="&request("downloadid"))
else
response.redirect("./?from=login")
end if
end if
end if
else
response.redirect("./login.asp?requid="&requid&"&from=errpwd")
end if
conn.close
set conn=mothing
end if
%>
