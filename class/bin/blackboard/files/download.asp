<%
response.charset="utf-8"
nn=request("filename")
fileid=request("fileid")
uid=request.cookies("uid")
if nn="" or fileid="" then
    response.redirect("./downloader.asp")
else
    set conn=server.createobject("adodb.connection")
    conn.open "signclass"
    set rs=server.createobject("adodb.recordset")
    sql="select * from filetree where fileid="&fileid
    rs.open sql,conn,1,3
    if rs.eof or rs.bof then
        response.write("文件不存在！<br><a href='./downloader.asp'>返回</a>")
    else
        if rs(4)=1 then
            if uid="" or rs(3)<>uid then
                response.cookies("jumpto")="download"
                response.cookies("downloadid")=fileid
                response.write("文件为私有，请登录对应账号以下载!<br><a href='../login.asp?from=logout'>前往</a>")
            else
                ck=1 
            end if
        else
            ck=1
        end if
            if ck=1 then
            if right(nn,1)=chr(34) then
                fname=left(nn,len(nn)-1)
            else
                fname=nn
            end if
            set conn=server.createobject("adodb.connection")
            conn.open "signclass"
            set rs=server.createobject("adodb.recordset")
            rs.open "select filecontent from files where fileid="&fileid,conn,1,3
            if rs.eof or rs.bof then
                response.redirect("./downloader.asp")
            else
                response.buffer=true
                response.clear
                response.charset="utf-8"
                Response.AddHeader "Content-Disposition","attachment;filename="&fname
                response.contenttype = "application/octet-stream"
                response.binarywrite rs(0)
                response.flush
            end if
            conn.close
            set conn=nothing
          end if
    end if
end if
%>