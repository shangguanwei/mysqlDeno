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




