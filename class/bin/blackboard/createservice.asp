<%
text=request("text")
unsigned=request("unsigned")
uid=request.cookies("uid")
tim=year(now())&right("0"&month(now()),2)&right("0"&day(now()),2)&right("0"&hour(now()),2)&right("0"&minute(now()),2)
cid=request.cookies("cid")
set conn=server.CreateObject("adodb.connection")
sql0="insert into blackboard values('" & uid & "','" & unsigned & "','" & text & "','" & tim & "','" & cid & "','0','0')"
sql1="CREATE TABLE `"&tim&cid&"` (`uuid` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,`like` tinyint NOT NULL,`text` mediumtext CHARACTER SET gb18030 COLLATE gb18030_chinese_ci NOT NULL,`tid` int NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=gb18030"
conn.open "signclass"
conn.execute(sql0)
conn.execute(sql1)
conn.close
set conn=nothing
response.redirect("./?from=create&cidd="&cid)
%>