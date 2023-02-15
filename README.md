# ASP-PostBar
开发中的留言板和选课，仅供参考<br>
文件名和变量名都是瞎起的，部分逻辑混乱，见谅<br>
signclass是一个
ODBC连接，使用MySQL数据库<br><br>
<hr>
选课表DDL<br>
CREATE TABLE `class_a1` (
  `student_name` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `student_grade` tinyint NOT NULL,
  `student_class` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin
<br><br><hr>
用户登记表DDL<br>
CREATE TABLE `bregister` (
  `uid` tinytext NOT NULL,
  `pwd` tinytext NOT NULL,
  `mailname` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk
<br><br><hr>
帖子根表(blackboard)DDL<br>
CREATE TABLE `blackboard` (
  `tuid` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `unsigned` tinyint NOT NULL,
  `text` mediumtext CHARACTER SET gb18030 COLLATE gb18030_chinese_ci NOT NULL,
  `time` bigint NOT NULL,
  `tid` int NOT NULL,
  `likec` tinyint NOT NULL,
  `commentc` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gb18030
<br><br><hr>
文件储存（files）表DDL<br>
CREATE TABLE `files` (
  `filecontent` longblob NOT NULL,
  `fileid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk
<br><br><hr>
文件登记表（filetree）DDL<br>
CREATE TABLE `filetree` (
  `fileid` int NOT NULL,
  `filename` longblob NOT NULL,
  `totalbytes` int NOT NULL,
  `uid` tinytext CHARACTER SET gbk COLLATE gbk_chinese_ci,
  `private` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk
