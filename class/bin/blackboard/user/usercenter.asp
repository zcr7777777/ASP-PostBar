<%
uid=request.querystring("uid")
if uid="" then
uid=request.cookies("uid")
if uid="" then
response.redirect("../")
else
response.redirect("./?uid="&uid)
end if
else
response.write("test")
end if
%>