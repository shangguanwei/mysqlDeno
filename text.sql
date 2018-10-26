#注释1
--注释2
--创建数据库
CREATE DATABASE IF NOT EXISTS `siyan` CHARACTER SET 'UTF8';
USE `siyan`;
--创建成员表（user）
--编号 id
--用户名 username
--年龄 age
--性别 sex
--邮箱 email
--地址 addr
--生日 birth
--薪水 salary
--电话 tel
--是否结婚 married
--注意，有中文时需临时转换客户端编码方式 SET NAMES GBK;
--字段注释 COMMENT 注释内容
CREATE TABLE IF NOT EXISTS user (
id SMALLINT,
username VARCHAR(20),
age SMALLINT,
sex ENUM('男','女','保密'),
email VARCHAR(50),
addr VARCHAR(200),
birth YEAR,
salary FLOAT(8,2),
tel INT,
married TINYINT(1) COMMENT '0未婚，非0已婚'
)ENGINE=INNODB CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS user1 (
id SMALLINT UNSIGNED KEY AUTO_INCREMENT,
username VARCHAR(20) NOT NULL,
password CHAR(36) NOT NULL,
email VARCHAR(50) NOT NULL DEFAULT '384840894@qq.com',
age TINYINT UNSIGNED DEFAULT 18,
sex ENUM('男','女','保密') DEFAULT '保密',
addr VARCHAR(200),
birth YEAR,
salary FLOAT(8,2),
tel INT,
married TINYINT(1) COMMENT '0未婚，非0已婚'
)ENGINE=INNODB CHARSET=UTF8;

--创建课程表 course
--编号 cid
--课程名称 courseName
--课程描述 courseDesc
CREATE TABLE IF NOT EXISTS course(
cid TINYINT,
courseName VARCHAR(50),
courseDesc VARCHAR(200)
);
--创建新闻分类表cms_cate
--编号、分类名称、分类描述
CREATE TABLE IF NOT EXISTS cms_cate(
cms_cate_id TINYINT,
cms_cate_name VARCHAR(50),
cms_cate_desc VARCHAR(200)
)ENGINE=INNODB CHARSET=UTF8;

--创建新闻表cms_news
--编号、新闻标题、新闻内容、发布时间、点击量、是否置顶、所属分类、发布人
CREATE TABLE IF NOT EXISTS cms_news(
cms_news_id INT,
cms_news_title VARCHAR(50),
cms_news_article TEXT,
cms_news_time INT,
cms_news_clicks INT,
cms_news_top TINYINT(1) COMMENT'0不置顶，非0置顶'
)ENGINE=MyISAM CHARSET=UTF8;

--建表testUser
--注意逗号分割符的位置，漏写多写会导致建表失败
CREATE TABLE IF NOT EXISTS testUser(
id TINYINT UNSIGNED KEY AUTO_INCREMENT,
username VARCHAR(50) NOT NULL UNIQUE,
password CHAR(32) NOT NULL
)ENGINE=INNODB CHARSET=UTF8;

--数据插入，不指定字段的插入方式需将值填写完整
INSERT INTO testUser VALUES(1,'aaa','123');
INSERT testUser(username,password) VALUES('bbb','456');
INSERT testUser(username,password) VALUES('ccc','789'),('ddd','000');
INSERT testUser VALUES(10,'eee','111');
INSERT testUser VALUES(11,'fff','333'),(12,'ggg','444');

--建表testUser1
CREATE TABLE IF NOT EXISTS testUser1(
id TINYINT UNSIGNED KEY AUTO_INCREMENT,
username1 VARCHAR(50) NOT NULL UNIQUE,
password1 CHAR(32) NOT NULL
)ENGINE=INNODB CHARSET=UTF8;

--插入数据
INSERT testUser1(username1,password1) VALUES('sgw','111');
INSERT testUser1(username1,password1) SELECT username,password FROM testUser WHERE id=10;
--username1唯一约束，下列语句会报错
INSERT testUser1 SELECT username,password FROM testUser;
--下方语句会将testUser中的数据全部插入testUser1中，插入字段需匹配
INSERT testUser1(username1,password1) SELECT username,password FROM testUser WHERE id！=10;

--更新数据
--不加where条件会更新整张表
--存在唯一约束无法更新
UPDATE testUser1 SET password1='123qwe',username1='sgw';
UPDATE testUser1 SET password1='123qwe';
--依据主键更新特定数据
UPDATE testUser1 SET password1='bbb' WHERE id=11;

--删除数据
DELETE FROM testUser1 WHERE id>12;
--清空表，TRUNCATE会重置AUTO_INCREMENT值，DELETE不会重置
TRUNCATE TABLE testUser1;
DELETE FROM testUser1;
INSERT testUser1 SET username1='sgw',password1='sgw';




-----------------------------------------------------------------------------------------------------

--创建cms数据库
CREATE DATABASE IF NOT EXISTS cms DEFAULT CHARACTER SET = UTF8;
USE cms;

--创建管理员表
CREATE TABLE cms_admin(
id TINYINT UNSIGNED AUTO_INCREMENT KEY,
username VARCHAR(50) NOT NULL UNIQUE,
password CHAR(32) NOT NULL,
email VARCHAR(50) NOT  NULL DEFAULT 'admin@qq.com',
role ENUM('普通管理员','超级管理员') DEFAULT '普通管理员'
);

INSERT cms_admin(username,password,email,role) VALUES('admin','admin','admin@qq.com',2);
INSERT cms_admin(username,password) VALUES('sgw','sgw'),
('wsy','wsy'),
('zgl','zgl'),
('test','test');


--创建分类表
CREATE TABLE IF NOT EXISTS cms_cate(
id TINYINT UNSIGNED AUTO_INCREMENT KEY,
cateName VARCHAR(50) NOT NULL UNIQUE,
cateDesc VARCHAR(200) DEFAULT '无'
);

INSERT cms_cate(cateName,cateDesc) VALUES('国内新闻','聚焦国内新闻'),
('国际新闻','聚焦国际新闻'),
('游戏新闻','聚焦游戏新闻'),
('军事新闻','聚焦军事新闻'),
('娱乐新闻','聚焦娱乐新闻');



--创建新闻表
CREATE TABLE IF NOT EXISTS cms_news(
id INT UNSIGNED AUTO_INCREMENT KEY,
title VARCHAR(50) NOT NULL UNIQUE,
content TEXT,
clickNum INT UNSIGNED DEFAULT 0,
pubTime INT UNSIGNED,
cId TINYINT UNSIGNED NOT NULL COMMENT '新闻所属分类，对应cms_cate中id',
aId TINYINT UNSIGNED NOT NULL COMMENT '那个管理员发布的，对应cms_admin中id'
);

INSERT cms_news(title,content,pubTime,cId,aId) VALUES('国内新闻1','国内新闻具体内容如下...',1419818508,1,1),
('国际新闻1','国际新闻具体内容如下...',1419818508,1,2),
('游戏新闻1','游戏新闻具体内容如下...',1419818508,1,3),
('军事新闻1','军事新闻具体内容如下...',1419818508,2,4),
('娱乐新闻1','娱乐新闻具体内容如下...',1419818508,2,5);


--创建省份表
CREATE TABLE IF NOT EXISTS provinces(
id TINYINT UNSIGNED AUTO_INCREMENT KEY,
proName VARCHAR(20) NOT NULL UNIQUE
);

INSERT INTO provinces(proName) VALUES('北京'),
('上海'),
('广州'),
('深圳'),
('杭州');


--创建用户表
CREATE TABLE IF NOT EXISTS cms_user (
id INT UNSIGNED AUTO_INCREMENT KEY,
username VARCHAR(20) NOT NULL UNIQUE,
password CHAR(32) NOT NULL,
email VARCHAR(50) NOT NULL DEFAULT 'user@qq.com',
regTime INT UNSIGNED NOT NULL,
face VARCHAR(100) NOT NULL DEFAULT 'user.jpg',
proId TINYINT UNSIGNED NOT NULL COMMENT '用户所在省份'
)ENGINE=INNODB CHARSET=UTF8;

INSERT cms_user(username,password,regTime,proId) 
VALUES('张三','zhangsan',1419811708,1),
('李四','lisi',1419811708,2),
('王五','wangwu',1419811708,3),
('赵六','zhaoliu',1419811708,4),
('沈七','shenqi',1419811708,5);

INSERT cms_user(username,password,regTime,proId) 
VALUES('张三三','zhangsansan',1419811708,1),
('李四思思','lisisi',1419811708,2),
('王呜呜','wangwuwu',1419811708,3),
('赵溜溜','zhaoliuliu',1419811708,4),
('沈琪琪','shenqiqi',1419811708,5);

--查询语句
SELECT * FROM cms_admin;
SELECT id,username FROM cms_admin;

--直接指定数据库及表名：db_name.tbl_name
SELECT id,username,role FROM cms.cms_admin;
--直接指定表名及字段名：tbl_name.field_name
SELECT cms_admin.id,cms_admin.username,cms_admin.role FROM cms.cms_admin;
--给表名起别名,一般用表名的前一到两个字母，AS可省略，不推荐
SELECT id,username FROM cms_admin AS a;
--给字段起别名
SELECT id AS '编号',username AS '姓名' FROM cms_admin AS ad;


--WHERE条件
SELECT id,username FROM cms_user WHERE id = 5;
SELECT id,username FROM cms_user WHERE id <=> NULL;
SELECT id,username FROM cms_user WHERE id IS NULL;
SELECT id,username FROM cms_user WHERE id BETWEEN 2 AND 4;
SELECT id,username FROM cms_user WHERE id IN (1,3,5);
SELECT id,username FROM cms_user WHERE username IN ('张三','王五');
SELECT * FROM cms_user WHERE username LIKE '%王%';
SELECT * FROM cms_admin WHERE username='sgw' AND password='sgw';
SELECT * FROM cms_user WHERE username LIKE '张_' OR password IN ('wangwu');

--GROUP BY
SELECT * FROM cms_user GROUP BY proId;

--给表新建字段别忘写TABLE
ALTER TABLE cms_user ADD sex ENUM('男','女','未填写') NOT NULL DEFAULT '未填写' AFTER password;
UPDATE cms_user SET sex = '男' WHERE id IN (1,2);

--错误！
SELECT * FROM cms_user GROUP BY sex; 
--需搭配聚合函数
SELECT sum(proId),sex FROM cms_user GROUP BY sex;
SELECT max(proId),sex FROM cms_user GROUP BY sex;
SELECT min(proId),sex FROM cms_user GROUP BY sex;
SELECT avg(proId),sex FROM cms_user GROUP BY sex;
--first/last不支持
SELECT first(proId),sex FROM cms_user GROUP BY sex;
SELECT last(proId),sex FROM cms_user GROUP BY sex;
--注意是count 不是cont！
SELECT count(proId),sex FROM cms_user GROUP BY sex;

--GROUP_CONCAT()
SELECT sex,count(username),GROUP_CONCAT(username) FROM cms_user GROUP BY sex;

ALTER TABLE cms_user ADD age TINYINT UNSIGNED;
ALTER TABLE cms_user MODIFY age TINYINT UNSIGNED AFTER sex;

--批量更新
UPDATE cms_user
	SET age = CASE id
		WHEN 1 THEN 10
		WHEN 2 THEN 15
		WHEN 3 THEN 20
		WHEN 4 THEN 25
		WHEN 5 THEN 30
		WHEN 6 THEN 10
		WHEN 7 THEN 15
		WHEN 8 THEN 20
		WHEN 9 THEN 25
		WHEN 10 THEN 30
	END
WHERE id IN (1,2,3,4,5,6,7,8,9,10);

--HAVING子句
SELECT sex,GROUP_CONCAT(username),COUNT(username),MAX(age),SUM(age) FROM cms_user GROUP BY sex HAVING COUNT(*)>2;

--ORDER BY子句
SELECT * FROM cms_user WHERE id > 5 ORDER BY age DESC;
--随机排序
SELECT age FROM cms_user ORDER BY RAND();

--LIMIT 偏移量从0开始
SELECT * FROM cms_user ORDER BY id DESC LIMIT 3;
SELECT * FROM cms_user LIMIT 0,3;
SELECT * FROM cms_user LIMIT 3,5;

--更新数据 使用LIMIT只允许一个参数
UPDATE cms_user SET email = '123@qq.com' WHERE id < 3 LIMIT 5;
DELETE FROM cms_user WHERE sex = '未填写' ORDER BY id DESC LIMIT 1;

--多表查询
SELECT u.id,u.username,p.proName FROM cms_user AS u,provinces AS p WHERE u.proId = p.id;
SELECT u.id,u.username,p.proName FROM cms_user AS u JOIN provinces AS p ON u.proId = p.id;
SELECT GROUP_CONCAT(u.id),GROUP_CONCAT(u.username),GROUP_CONCAT(u.sex),p.proName FROM cms_user AS u JOIN provinces AS p ON u.proId = p.id WHERE u.sex = '未填写' GROUP BY p.proName HAVING COUNT(*) >= 2 ORDER BY GROUP_CONCAT(u.id) DESC LIMIT 0,2;

--三张表
SELECT n.title,c.cateName,a.username FROM cms_news AS n 
JOIN cms_cate AS c ON n.cId = c.id 
JOIN cms_admin AS a ON n.aId = a.id;

--外连接查询，左外连接以左侧表为主表，，右外连接以右侧表为主表，可查询出主表的NULL值
INSERT provinces(proName) VALUES ('山西');
SELECT u.id,u.username,p.proName FROM cms_user AS u RIGHT JOIN provinces AS p ON u.proId = p.id;



--外键
--1.建表时添加
--创建主表部门表
--注意 引擎和编码之间没有逗号
CREATE TABLE IF NOT EXISTS department(
id TINYINT UNSIGNED AUTO_INCREMENT KEY,
depDesc VARCHAR(200)
)ENGINE=INNODB CHARSET=UTF8;

ALTER TABLE department CHANGE depDesc depName VARCHAR(20);
INSERT department(depName) VALUES('研发部'),('测试部'),('市场部'),('销售部');

--创建带外键的副表员工表
CREATE TABLE IF NOT EXISTS employee(
id SMALLINT UNSIGNED AUTO_INCREMENT KEY,
empName VARCHAR(50) NOT NULL,
depId TINYINT UNSIGNED,
FOREIGN KEY(depId) REFERENCES department(id)
)ENGINE=INNODB;

INSERT employee(empName,depId) VALUES ('wsy',1),('sgw',2),('xiaoming',3),('zxs',3),('dlz',4);

--存在外键约束，不允许直接删除主表记录
DELETE FROM department WHERE id=3;

DELETE FROM employee WHERE depId=3;
DELETE FROM department WHERE id=3;

--2建表后添加或删除外键
ALTER TABLE employee DROP FOREIGN KEY `employee_ibfk_1`;
ALTER TABLE employee ADD CONSTRAINT emp_fk_dep FOREIGN KEY(depId) REFERENCES department(id);

--ON DELETE CASCADE 和 ON UPDATE CASCADE 父表数据更新时自动更新子表
ALTER TABLE employee DROP FOREIGN KEY emp_fk_dep;

ALTER TABLE employee ADD 
CONSTRAINT emp_fk_dep FOREIGN KEY(depId) REFERENCES department(id) 
ON DELETE CASCADE ON UPDATE CASCADE;


SELECT * FROM employee;
DELETE FROM department WHERE id = 4;

--更新表中数据用update,修改表结构用modify,修改表名rename，修改字段名change
UPDATE department SET id = id + 10;

--ON DELETE SET NULL 和 ON UPDATE SET NULL 父表数据更新时自动子表数据置空
--前提条件，字表对应字段未设置 NOT NULL
ALTER TABLE employee DROP FOREIGN KEY emp_fk_dep;

ALTER TABLE employee ADD 
CONSTRAINT emp_fk_dep FOREIGN KEY(depId) REFERENCES department(id) 
ON DELETE SET NULL ON UPDATE SET NULL;

UPDATE department SET id = id - 10;
SELECT * FROM employee;

--联合查询
SELECT empName FROM employee UNION SELECT username FROM cms_user UNION SELECT depName FROM department;
SELECT empName FROM employee UNION ALL SELECT username FROM cms_user;

--子查询
CREATE TABLE IF NOT EXISTS student(
id TINYINT UNIQUE AUTO_INCREMENT KEY,
stuName VARCHAR(50) NOT NULL,
stuScore TINYINT
);
INSERT student(stuName,stuScore) VALUES('stu1',30),('stu2',40),('stu3',50),('stu4',60),('stu5',70),('stu6',80),('stu7',90),('stu8',100);

CREATE TABLE IF NOT EXISTS scholarship(
id TINYINT UNIQUE AUTO_INCREMENT KEY,
level TINYINT
);
INSERT scholarship(level) VALUES(70),(80),(90);

--[NOT]IN
SELECT stuName,stuScore FROM student WHERE stuScore IN (SELECT level FROM scholarship);
--比较运算符
SELECT stuName,stuScore FROM student WHERE stuScore >= (SELECT level FROM scholarship WHERE id =1);
--[NOT]EXISTS 子表达式查询结果成立才执行
SELECT stuName,stuScore FROM student WHERE EXISTS (SELECT level FROM scholarship WHERE id =1);
--ANY|SOME、ALL
SELECT stuName,stuScore FROM student WHERE stuScore > ANY (SELECT level FROM scholarship);
SELECT stuName,stuScore FROM student WHERE stuScore != ALL (SELECT level FROM scholarship);
--建表时插入数据,字段名称不一致会新建字段
CREATE TABLE IF NOT EXISTS test1(
id TINYINT UNSIGNED AUTO_INCREMENT KEY,
score TINYINT
)SELECT stuScore FROM student;
--数据插入 注意没有from
INSERT test1(score) SELECT stuScore FROM student;



--正则表达式
SELECT * FROM cms_user WHERE username REGEXP '^张';
SELECT * FROM cms_user WHERE username REGEXP '思$';
--字符集合可指定范围，如[a-f],要注意[^李张沈]的查询结果
SELECT * FROM cms_user WHERE username REGEXP '[^李张沈]';












