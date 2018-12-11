

use master
go
if	exists(select * from sys.databases where name='ExamSys')
	drop database ExamSys
go
create database ExamSys
go
 
use ExamSys
go

create table Grade
(
	GradeID int not  null primary key identity(1,1),
	GradeName varchar(20) not null unique
)

go
create table TextBook
(
	BookID int not  null primary key identity(1,1),
	BookName varchar(100) not null unique,
	GradeID int not null foreign key references Grade(GradeID)
)
go
create table Chapter
(
	ChapterID int not  null primary key identity(1,1),
	ChapterName varchar(200) not null unique,
	BookID int not null foreign key references TextBook(BookID)
)
go
create table [Role]
(
	RoleID int not  null primary key identity(1,1),
	RoleName varchar(120) not null unique,
	[Description] varchar(200) not null default '没描述'
)
go

create table Teacher
(
	TeacherID int not  null primary key identity(1,1),
	TeacherName varchar(20) not null,
	UserName varchar(20) not null unique,
	[Password] varchar(20) not null,
	RoleID int not null foreign key references Role(RoleID),
	JoinTime date not null
)
go

create table Class
(
	ClassID int not  null primary key identity(1,1),
	ClassName varchar(50) not null unique,
	MasterID int not null foreign key references Teacher(TeacherID),
	TeacharID int not null foreign key references Teacher(TeacherID),
	GradeID int not null foreign key references Grade(GradeID),
	CreateTime date null
)
go

create table Student
(
	StudentID int not  null primary key identity(1,1),
	StudentName varchar(20) not null, --姓名
	[Password] varchar(20) not null,--密码
	Gender bit not null, -- 性别
	Phone varchar(11) not null, --电话
	CardID varchar(18) not null unique, -- 身份证号
	[Address] varchar(100) not null default '无', -- 住址
	Email varchar(50) null, -- 邮箱
	Borndate date not null, -- 出生日期
	CreateTime date null, -- 入学时间
	ClassID int foreign key references Class(ClassID) --班级编号
)


go
create table Question
(
	QuestionID int not  null primary key identity(1,1),
	QuestionTitle varchar(1000) not null ,
	QuestionType bit not null,
	QuestionLevel int not null check (QuestionLevel in (1,2,3)),
	BookID int not null foreign key references TextBook(BookID),
	ChapterID int not null foreign key references Chapter(ChapterID) ,
	IsCheck bit not null,
	CreatorID int not null foreign key references Teacher(TeacherID) ,
	CreateTime datetime not null default getdate(),
	CheckID int null foreign key references Teacher(TeacherID) ,
	CheckTime datetime  null default getdate(),
	[Description] varchar(500) not null
)



go
create table Answer
(
	AnswerID int not  null primary key identity(1,1),
	AnswerContent varchar(200) not null,
	QuestionID int not null foreign key references Question(QuestionID) ,
	IsResult bit not null
)

create table PaperRule
(
	RuleID int not  null primary key identity(1,1),
	RuleName varchar(50) not null unique,
	GradeID int not null foreign key references Grade(GradeID),
	CreatorID int not null foreign key references Teacher(TeacherID) ,
	CreateTime datetime not  null default getdate(),
)
go
select * from Question
create table RuleDetail
(
	DetailID int not  null primary key identity(1,1),
	RuleID int not  null  foreign key references PaperRule(RuleID) ,
	BookID int not  null  foreign key references TextBook(BookID) ,
	ChapterID int   null  foreign key references Chapter(ChapterID) ,--
	QuestionCount int not null,
	QuestionLevel int not null check(QuestionLevel in (1,2,3))
)
create table PaperType
(
	TypeID int not  null primary key identity(1,1),
	TypeName varchar(20) not null unique
)

create table Paper
(
	PaperID int not  null primary key identity(1,1),
	PaperName varchar(20) not null unique, --名称
	GradeID int not null foreign key references Grade(GradeID), --所属年级
	typeID int not null  foreign key references PaperType(TypeID), --类型
	Duration int not null, --时间
	IsOpen bit not null,--0关闭,1开放
	ClassList varchar(100) not null , --   1-2-3-4
	RuleID int not null foreign key references PaperRule(RuleID), --组卷策略编号引用
	QuestionCount int not null,--题目数量
	CreateTime datetime not  null default getdate(),--创建时间
	CreatorID int not null foreign key references Teacher(TeacherID), --创建人编号
)
select * from Teacher
create table PaperDetail
(
	PaperID int not null foreign key references Paper(PaperID),
	QuestionID int not null foreign key references Question(QuestionID),
	SortCode int not null
)
--alter table PaperDetail--联合主键
--add constraint PK_paperdetail primary key (PaperID,QuestionID)
select * from Paper
create table StuQueRecord--学生做题表 未使用
(--编号--学生编号-试卷编号-做题时间
	RecordID int not null primary key identity(1,1),
	StudetnID int not null foreign key references Student(StudentID),
	PaperID int not null foreign key references Paper(PaperID),
	RecordTime datetime not null default getdate()--交卷时间
)

create table StuQueRecordDetail--学生做题明细表 未使用
(--做题明细编号-引用做题编号-试题编号-答案编号
	RecordDetailID int not null primary key identity(1,1),
	RecordID int foreign key references StuQueRecord(RecordID),
	QuestionID int not null foreign key references Question(QuestionID),
	AnswerID int not null foreign key references Answer(AnswerID),
)
create table Result--成绩表 未使用
(
	ResultID int not null primary key identity(1,1),
	RecordID int not null foreign key references StuQueRecord(RecordID),
	Score int not null  check(Score>=0),
)
create table PaperRecord
(
	RecordID int not null primary key identity(1,1),
	StudetnID int not null foreign key references Student(StudentID),
	PaperID int not null foreign key references Paper(PaperID),
	QuestionID int not null foreign key references Question(QuestionID),
	AnswerID int not null foreign key references Answer(AnswerID),
	RecordTime datetime not null default getdate()
)


create table Module
(
	ModuleID int not null primary key identity(1,1),
	ModuleName varchar(50) not null,
	SortCode int not null default 0
)

create table Menu
(
	MenuID int not null primary key identity(1,1),
	MenuName varchar(50) not null,
	SortCode int not null default 0,
	[Service] varchar(50) not null default '',
	ModuleID int not null foreign key references Module(ModuleID),
	Roles varchar(50) not null default ''
)

--create table MenuItem
--(
--	ItemID int not null primary key identity(1,1),
--	ItemName varchar(50) not null,
--	SortCode int not null default 0,
--	Method varchar(50) not null default '',
--	MenuID int not null foreign key references Menu(MenuID),
--	Roles varchar(50) not null default ''
--)
--A代表C#   B代表Java
--insert into Grade values
--('S1'),('S2A'),('S2B'),('S2'),('Y2A'),('Y2B'),('Y2')

----S1
--insert into TextBook values ('走进Java编程世界',1)
--insert into TextBook values ('HTML 和CSS网页技术',1)
--insert into TextBook values ('C#语言和数据库技术',1)
--insert into TextBook values ('Winform',1)
----S2
--insert into TextBook values ('使用JQuery快速高效制作网页交互特效',4)
----S2B
--insert into TextBook values ('使用Java实现面向对象编程',3)
--insert into TextBook values ('使用Javs实现数据库编程',3)
--insert into TextBook values ('使用JSP/Servlet技术开发新闻发布系统',3)
----S2A
--insert into TextBook values ('优化MySchool',2)
--insert into TextBook values ('深入.NET平台和C#编程 -- OOP',2)
--insert into TextBook values ('深入.NET平台的软件系统分层开发',2)
--insert into TextBook values ('Asp WebForm开发企业级应用',2)
----Y2
--insert into TextBook values ('Web前端框架--BookStrap',7)
----Y2B
--insert into TextBook values ('使用SSM框架开发企业级应用',6)
--insert into TextBook values ('基于SSH框架的企业级应用开发',6)
--insert into TextBook values ('基于Hadoop生态系统的大数据解决方案',6)
----Y2A
--insert into TextBook values ('ASP.NET MVC开发企业级应用',5)
--insert into TextBook values ('ASP.NET WebApi',5)
--insert into TextBook values ('前端AngularJS',5)

--select * from Chapter

----Java
--insert into Chapter values
--('初始Java',1),('变量，数据类型和运算符',1),('选择结构(一)',1),('选择结构(二)',1),('循环结构(一)',1),('循环结构(二)',1),('数组',1),('循环结构进阶',1),('类和对象',1),('类的无参方法',1),('带参数的方法',1),('字符串',1)

----html
--insert into Chapter values
--('HTML5基础',2),('列表、表格、媒体元素和iframe',2),('表单',2),('样式表和盒子模型',2),('浮动和定位网页元素',2)

----C#
--insert into Chapter values
--('第一个C#程序',3),('C#语法快速热身',3),('使用属性升级MyBank',3),('深入C#的String类',3),('程序数据集散地:数据库',3),('用表组织数据',3),('用SQL语句操作数据',3),('数据查询基础',3),('模糊查询和聚合函数',3),('连接查询和分组查询',3),('使用ADO.NET访问数据库',3),('使用ADO.NET查询和操作数据',3)

----WinForm
--insert into Chapter values
--('初识Windows程序',4),('构建布局良好的Windows程序',4),('使用ListView控件展示数据',4),('实现Windows程序的数据更新',4),('实现Windows程序的数据绑定',4),('数据筛选和排序',4)

----使用JQuery快速高速制作网页交互特效
--insert into Chapter values
--('JavaScript基础',5),('JavaScript操作BOM对象',5),('JavaScript操作DOM对象',5),('JavaScript对象及初识面向对象',5),('初识jQuery',5),('jQuery选择器',5),('jQuery中的事件与动画',5),('使用jQuery操作DOM',5),('表单校验',5)

----使用Java实现面向对象编程
--insert into Chapter values
--('对象和封装',6),('继承',6),('多态',6),('接口',6),('异常',6),('集合框架',6),('多线程',6),('File I/O',6)

----使用Javs实现数据库编程
--insert into Chapter values
--('Java数据库的设计',7),('初识MySQL',7),('Java高级查询',7),('事务、视图、索引、备份和恢复',7),('JDBC',7),('DAO模式',7),('XML文件',7),('反射技术',7),('Java存储过程',7),('用户管理、权限管理、触发器',7)

----使用JSP/Servlet技术开发新闻发布系统
--insert into Chapter values
--('动态网页开发基础',8),('JSP数据交互',8),('使用分层实现业务处理',8),('JSP开发业务应用',8),('Servlet基础',8),('JSTL和EL',8),('自定义标签',8),('Ajax与jQuery',8),('Ajax交互扩展',8),('S2项目进阶训练',8)

----优化MySchool
--insert into Chapter values
--('.NET数据库的设计',9),('数据库的实现',9),('SQL编程',9),('.NET高级查询',9),('事务、视图和索引',9),('.NET存储过程',9)

----深入.NET平台和C#编程 -- OOP
--insert into Chapter values
--('深入.NET框架',10),('深入C#数据类型',10),('使用集合组织相关数据',10),('深入类的方法',10),('初识继承和多态',10),('深入理解多态',10),('可扩展标记语言XML',10),('文件操作',10)

----深入.NET平台的软件系统分层开发
--insert into Chapter values
--('软件系统的分层开发',11),('OOP典型应用：实体类',11),('提高系统性能：从数据访问开发',11),('业务的扩展：三层架构',11),('实体类在Windows程序中的高级应用',11)

----Asp WebForm开发企业级应用
--insert into Chapter values
--('Hello,Asp.net',12),('页面访问控制',12),('表单和数据验证',12),('搭建风格统一的web站点',12),('网上书店的系统架构',12),('使用jQuery和Ajax',12),('一般处理程序',12),('常见js库的使用',12),('数据缓存',12),('webservice',12),('网站配置和部署',12)

----Web前端框架--BootStrap
--insert into Chapter values
--('响应式布局',13),('Bootstrap样式',13),('Bootstrap组件',13),('JavaScript插件',13),('移动Web页面开发',13),('移动Web特效开发',13)

----使用SSM框架开发企业级应用
--insert into Chapter values
--('初始MyBatis',14),('SQL映射文件',14),('动态SQL',14),('Spring核心概念',14),('IoC和AOP使用扩展',14),('MyBatis与Spring的整合',14),('Spring配置补充',14),('Spring MVC体系结构和处理请求控制器',14),('使用Spring MVC框架改造超市订单系统',14),('Spring MVC扩展和SSM框架整合',14)

----基于SSH框架的企业级应用开发
--insert into Chapter values
--('Oracle数据库基础',15),('Oracle数据库应用',15),('PL/SQL编程',15),('Hibernate入门',15),('HQL实用技术',15),('Hibernate关系映射',15),('HQL连接查询和注解',15),('Struts2入门',15),('Struts2配置详解',15),('OGNL',15),('拦截器',15),('搭建SSH框架',15)

----基于Hadoop生态系统的大数据解决方案
--insert into Chapter values
--('Hadoop入门',16),('HDFS实现分布式存储',16),('MapReduce实现分布式运算',16),('HBase数据库',16),('Hadoop综合应用',16)

----ASP.NET MVC开发企业级应用
--insert into Chapter values
--('进入 ASP.NET MVC 世界',17)

----ASP.NET WebApi
--insert into Chapter values
--('认识Web API',18)

--insert into role values 
--('管理员',default),('教员',default),('班主任',default)

--insert into Teacher
--values
-- ('管理员','admin','123123',1,'2010-1-1'),
--('张三','zhangsan','111222',2,'2012-1-1'),
--('李四','lisi','000000',3,'2012-1-13'),
--('录题人','lutiren','111111',2,'2010-2-2'),
--('审核人','shenheren','222222',2,'2010-3-2')

--insert into Class values
--('T191',3,2,1,'2018-4-20'),('T192',3,2,3,'2018-4-30'),('T189',3,2,2,'2018-4-30'),('T194',3,2,1,'2018-4-30'),('T195',3,2,3,'2018-4-30')

--select * from Class

--insert into Student values
--('商科','924566',1,'15595499692','13042319980122281x',default,'924566@qq.com','1998-1-22','2018-4-1',1),
--('闫继阳','24526699',1,'15158069534','130429199901015423',default,'24526699@qq.com','1999-1-1','2018-4-1',2),
--('张红杰','129790',0,'15532069962','130481199910106622',default,'129790@qq.com','1999-10-10','2018-3-31',3),
--('薛雄楠','165088',1,'15230092670','13042920000504521x',default,'165088@qq.com','2000-05-04','2018-3-21',4)

----insert into Question values
----('A题',0,1,1,0,4,'2018-8-20',5,'2018-8-21','本题中C为正确答案'),
----('B题',0,2,1,0,4,'2018-8-20',5,'2018-8-21','本题中C为正确答案'),
----('C题',1,3,1,1,4,'2018-8-20',5,'2018-8-21','本题中C为正确答案'),
----('D题',0,3,1,1,4,'2018-8-20',5,'2018-8-21','本题中C为正确答案'),
----('E题',1,3,1,1,4,'2018-8-20',5,'2018-8-21','本题中C为正确答案')



--insert into Question values
----WinForm 1
--('在C#程序中已经创建了DataSet ds和DataAdapter da ，现要将数据库中Users表的数据放在ds中的MyUsers数据表中，下面语句正确的是（  ）。  (选择一项)',0,2,4,34,0,2,'2018-9-26',null,null,'正确答案：B 答案解析: Fill(DataSet ds，String tbl_name) 第二个参数为自定义的临时数据库中的表名'),
----WinForm 2
--('以下关于C#中DataGridView控件的说法中正确的是（ ）。  (选择一项)',0,2,4,35,0,2,'2018-9-26',null,null,'正确答案：B 答案解析: 因为主键会作为更改条件，因此，没有主键列则不能对数据执行更新操作'),
----WinForm 3
--('在C#中，关于DataGridView的使用，说法正确的是（）。  (选择二项)',1,2,4,34,0,2,'2018-9-26',null,null,'正确答案：C,D 答案解析: A选项错误：DataGridView控件的DataSource可以是某个DataTable对象或者DataView对象等。 B选项错误：ReadOnly属性是boo类型'),
----WinForm 4
--('在C#中，用SqlDataAdapter和DataSet从teacher表中读取数据，假定conn是一个可用的数据库连接，阅读以下代码：

--DataSet dss = new DataSet( );     //①

--SqlDataAdapter dap = new SqlDataAdapter("select * fromteacher", conn);// ②

--conn.Open();//③

--dap.Fill(dss，"myTeacher");//④

--则关于这段代码，说法正确的是（）。  (选择一项)
--',0,2,4,33,0,2,'2018-9-26',null,null,'正确答案：C

--答案解析:

--DataAdapter可以自己管理连接的开关，所以③不是必须的

--填充数据时，表名可以自定义，不需要和数据源保持一致'),
----WinForm 5
--('在WinForms中，编写代码为ComboBox控件绑定数据时不需要（ ）。 (选择一项)',0,2,4,31,0,2,'2018-9-26',null,null,'正确答案：D

--答案解析:

--DataSource属性设置数据源

--DisplayMember属性设置显示列

--ValueMember属性设置值列

--'),
----WinForm 6
--('在WinForms中，tv为TreeView控件，则通过（ ）属性可以获取TreeView中当前选中节点的文本。  (选择二项)',1,2,4,34,0,2,'2018-9-26',null,null,'正确答案：B,C

--答案解析:

--获取选中节点为：SelectedNode属性

--获取节点文本为：Text属性
--'),
----WinForm 7
--('在TreeView控件的每个节点前添加一个图标，应该设置（）属性。',0,2,4,34,0,4,'2018-9-26',null,null,'正确答案：A

--答案解析:

--只要给树控件绑定图片列表集合，树控件前的节点就默认显示第一个小图标了
--'),
----WinForm 8
--('在WinForms中,一下代码实现了使用DataView对象删选学生信息,并根据学生姓名牲畜排列.其中,"Student"为学生信息表,"StudentName"为 学生姓名.则存在错误的代码行是( ).

--DataSet ds = new DataSet(); //1

--DataView dv = new DataView(ds.Tables["Student"]); //2

--dv.Filter = "StudentName like "王%""; //3

--dv.Sort = "order by StudentName desc"; //4(选择一项)',0,2,4,34,0,4,'2018-9-26',null,null,'正确答案：C

--答案解析:

--过滤条件属性为：RowFilter

--排序属性设置时不用写 order by'),
----WinForm 9
--('在WinForms应用程序中,如果CheckBox控件的Checked属性值设置为True,则程序运行后().(选择一项)',0,2,4,33,0,4,'2018-9-26',null,null,'正确答案：C

--答案解析:

--CheckBox中的Checked属性为设置或获取多选按钮的选中状态,设置为True时则是选中的状态
--'),
----WinForm 10
--('MenuStrip控件中显示为一个按钮选择项的是()类型的.(选择一项)',0,2,4,31,0,4,'2018-9-26',null,null,'正确答案：A

--答案解析:

--MenuStrip中的按钮选择项为ToolStripMenuItem,'),
----WinForm 11
--('private void btnOK_Click(object sender, EventArgs e)

--{

--      FrmList frmList =new FrmList ();

--      frmList.MdiParent =this;

--      frmList.ShowDialog();

--}

--则可能（） (选择一项)
--',0,2,4,31,0,4,'2018-9-26',null,null,'正确答案：B

--答案解析:

--在使用MDI窗体时,可以以普通的窗口形式进行显示,设置为模式化窗口时会引发异常
--'),
----WinForm 12

--('在WinForms中，下列关于菜单栏控件MenuStrip的属性和事件说法错误的是（ ）  (选择一项)',0,2,4,31,0,4,'2018-9-26',null,null,'正确答案：D

--答案解析:

--Modifiers属性为设置控件的访问作用域,

--'),
----WinForm 13
--('在WinForms中，运行如下代码能够实现点击“大图片”按钮（Name属性值为btnLarge）和“小图片”按钮（Name属性值为btnSmall），大小图片切换显示，其中lvImage为ListView的Name属性值，那么横线处依次正确填写的代码是（ ）。
--private void btnLarge_Click(object sender, EventArgs e)
--{
--    lvImage.View = _____________;
--}
--private void btnSmall_Click(object sender, EventArgs e)
--{
--    lvImage.View = _____________;
--}',0,2,4,31,0,2,'2018-10-5',null,null,'正确答案：A

--答案解析: 根据按钮名称来确定填写的代码,btnLarge_Click对应View.LargeIcon而btnSmall_Click对应View.SmallIcon'),
----WinForm 14
--('以下（）不是WinForm中ListView控件View属性的有效值。（选择一项）',0,2,4,32,0,2,'2018-10-5',null,null,'正确答案：D

--答案解析: ListView中具有LargeIcon,SmallIcon,List,Details,Tile五中,分别是大图标,小图标,列表,详细与平铺'),
----WinForm 15
--('下面关于ListView控件的描述，正确的是（）。',0,2,4,32,0,2,'2018-10-5',null,null,'正确答案：A

--答案解析: 在ListView中添加数据需要使用Items属性对应添加ListViewItem对象'),
----WinForm 16
--('下列关于控件ListView 的属性的描述错误的是()。(选择一项)',0,2,4,32,0,2,'2018-10-5',null,null,'正确答案：A

--答案解析:

--Columns属性为设置在详细信息视图中显示的列'),
----WinForm 17
--('在WinForms中，关于Timer（计时器）控件的属性和事件，说法错误的是（ ）。  (选择一项)',0,2,4,31,0,2,'2018-10-5',null,null,'正确答案：D

--答案解析:

--Stop()方法可以停止计时器,但是并不会使其无法在次启动'),
----WinForm 18
--('在C#中，关于枚举的正确描述是（      ）。  (选择二项)',1,2,4,32,0,2,'2018-10-5',null,null,'正确答案：A,B

--答案解析: Enum为枚举的关键字,其作用为为一组有限的数字添加明确的定义'),
----WinForm 19
--('在WinForms中，执行TextBox控件的（）方法能使其获得焦点。  (选择一项)',0,2,4,30,0,2,'2018-10-5',null,null,'正确答案：A

--答案解析: 在WinForms中，执行TextBox控件的 Focus() 方法能使其获得焦点'),
----WinForm 20
--('Timer控件的Interval属性可以设置定时发生事件的间隔，它的单位是（）。',0,2,4,32,0,2,'2018-10-5',null,null,'正确答案：B

--答案解析: Timer控件的Interval属性可以设置定时发生事件的间隔，它的单位是 毫秒')

----C# 1
--insert into Question values
--('在SQL Server中，有一张新闻表news，新闻发布时间为字段begintime，现要查询最近一个月内发表的新闻的信息，则以下SQL语句正确的是（ ）。',0,1,3,25,0,4,'2018-10-5',null,null,'正确答案：B

--答案解析:

--dateAdd（类型，值，日期）  类型可取：dd、mm、yy、day、month、year

--daatediff（） 用于计算日期之间的差'),
----C# 2
--('在SQL Server  中，通配符通常与LIKE关键字一起配合使用，以下通配符中(  )表示在括号中指定范围内的一个字符。',0,1,3,24,0,5,'2018-10-6',null,null,'正确答案：C

--答案解析:

--[ ] 中括号表示在一定范围内,[^ ] 表示不在某个范围内'),
----C# 3
--('在T-SQL中，关于通配符“%”的说法正确的是（）。',0,1,3,24,0,5,'2018-10-6',null,null,'正确答案：A

--答案解析:

--该题属于基本概念，记住就可以了！ 没有为什么'),
----C# 4
--('在SQL Server中，可以用于统计表中记录之和的函数是（）。',0,1,3,26,0,5,'2018-10-6',null,null,'正确答案：A

--答案解析:

--五个聚合函数：  sum 求和  ，count 行数， avg 平均  ， max  最大值， min 最小值'),
----C# 5
--('在C#中，要使如下代码正确运行，则①②上应该分别填写（）。

--_①__static int getResult(int left, ref int right)

--{

--    right = left +right;  

--    return right;

--}

--static void Main(string[] args)

--{

--    int para = 6;

--    int result =getResult(5, _②__);

--}  (选择二项)',1,2,3,20,0,2,'2018-10-6',null,null,'正确答案：B,D

--答案解析:

--引用传参，形参和实参前都必须加ref关键字')

----insert into Question values


--select * from TextBook
--select * from Question
--select * from Answer
--select * from Chapter

--insert into PaperType
-- values('内测'),('模拟'),('结业'),('结课')

-- select * from Teacher

-- insert into PaperRule
-- values('第一学期',1,4,'2018-8-8'),
-- ('第二学期',2,4,'2018-8-10'),
-- ('第三学期',3,4,'2018-8-12')

-- select * from Paper

-- insert into Paper
--  values('a卷',1,1,60,1,'191-192-193-194',1,50,'2018-8-4',4),
--  ('b卷',2,1,60,0,'181-182-183-184',2,50,'2018-8-5',4),
--  ('c卷',2,1,60,1,'171-177-172-174',2,50,'2018-8-5',4),
--  ('d卷',1,1,60,0,'195-199',1,50,'2018-8-4',4)

--    select * from Paper
--  insert into RuleDetail 
--  values(1,1,1,15,3),
--  (1,2,4,10,3),
--  (1,3,3,15,3)
--  select * from RuleDetail

--select * from Answer

--insert into Answer values
----WinForm 1
--('A.da.Fill(ds, "Users");',1,0),
--('B.da.Fill(ds, "MyUsers");',1,1),
--('C.da.Fill(ds.Tables["MyUsers"],"Users");',1,0),
--('D.da.Fill(ds);',1,0),
----WinForm 2
--('A. DataSet可以作为DataGirdView的数据源，而DataTable不可以',2,0),
--('B. 要将DataGridView中的数据更新到对应的数据表中，则该对应表必须要有主键',2,1),
--('C. DataGridView每列的HeaderText属性用于设置该列绑定的数据列的名称',2,0),
--('D. DataGridView每列的Frozen属性用于设置当DataGridView垂直滚动时，该列是否移动',2,0),
----WinForm 3
--('A.DataGridView控件的DataSource可以是某个DataSet对象。',3,0),
--('B.将DataGridView的ReadOnly属性设置为0，则DataGridView的单元格不可编辑',3,0),
--('C.DataPropertyName表示绑定的数据列的名称',3,1),
--('D.更新DataGridView中的数据，可以借助DataAdapter的Update( )方法',3,1),
----WinForm 4
--('A.③是必须的',4,0),
--('B.④中的第二个参数错误，只能是"teacher"',4,0),
--('C.SqlDataAdapter相当于数据库和DataSet间的数据运输车',4,1),
--('D.上面的说法都不对',4,0),
----WinForm 5
--('A.设置ValueMember属性',5,0),
--('B.设置DisplayMember属性',5,0),
--('C.设置DataSource属性',5,0),
--('D.调用DataBind()方法',5,1),
----WinForm 6
--('A.tv.SelectedNode',6,0),
--('B.tv.Nodes[tv.SelectedNode.Index].Text',6,1),
--('C.tv.SelectedNode.Text',6,1),
--('D.v.SelectedNode.Name',6,0),
----WinForm 7
--('A.ImageList',7,1),
--('B.ImageIndex',7,0),
--('C.SelectedImageIndex',7,0),
--('D.SelectedImage',7,0),
----WinForm 8
--('A.1 和 2',8,0),
--('B.2 和 3',8,0),
--('C.3 和 4',8,1),
--('D.1 和 4 ',8,0),
----WinForm 9
--('A.此CheckBox可见',9,0),
--('B.此CheckBox不被选中',9,0),
--('C.此CheckBox被选中',9,1),
--('D.此CheckBox不被加载',9,0),
----WinForm 10
--('A.ToolStripMenuItem',10,1),
--('B.Item',10,0),
--('C.ToolItem',10,0),
--('D.StripItem',10,0),
----WinForm 11
--('A.编译出错',11,0),
--('B.运行时发生异常',11,1),
--('C.FrmList窗体以FrmMain窗体为MDI父窗体打开',11,0),
--('D.FrmList窗体以模式化窗口打开',11,0),
----WinForm 12
--('A.Name表示代码中菜单对象的名称',12,0),
--('B.Items表示在菜单中显示的项的集合',12,0),
--('C.Text表示与菜单相关联的文本',12,0),
--('D.Modifiers表示在父菜单中显示的项的集合',12,1),
----WinForm 13
--('A.View.LargeIcon
--View.SmallIcon',13,1),
--('B.View.Details
--View.List',13,0),
--('C.View.SmallIcon
--View.LargeIcon',13,0),
--('D.View.Tile
--View.List',13,0),
----WinForm 14
--('A.LargeIcon',14,0),
--('B.List',14,0),
--('C.SmallIcon',14,0),
--('D.ListDetails',14,1),
----WinForm 15
--('A.Items的Add()方法用于将项添加到项的集合中',15,1),
--('B.AddRange()方法用于向列表子项集合中添加新的子项',15,0),
--('C.SubItems对应于列表视图项ListViewItem',15,0),
--('D.可以使用DataSource绑定数据源',15,0),
----WinForm 16
--('A.Columns 属性表示" 详细信息"视图中显示的行',16,1),
--('B.MultiSelect 属性表示是否允许选择多项',16,0),
--('C.View 属性用于设置ListVíew 的视图模式',16,0),
--('D.FullRowSelect 属性表示当选中一项时，它的子项是否同该项一起突出显示 ',16,0),
----WinForm 17
--('A.将Interval属性设置为1000，如果该计时器可用，则事件每隔1秒发生一次',17,0),
--('B.将Enabled属性设置为false，则事件不会发生',17,0),
--('C.Timer控件一般用于需要每隔一段时间重复执行代码的情况',17,0),
--('D.Stop()表示停止计时器，停止后无法再启动',17,1),
----WinForm 18
--('A.枚举使用enum关键字定义',18,1),
--('B.枚举表示了一组有限的数值',18,1),
--('C.枚举是引用类型',18,0),
--('D.枚举中可以定义属性和方法',18,0),
----WinForm 19
--('A. Focus();',19,1),
--('B. GetFocus();',19,0),
--('C. In();',19,0),
--('D.MouseIn();',19,0),
----WinForm 20
--('A.秒',20,0),
--('B.毫秒',20,1),
--('C.微秒',20,0),
--('D.分',20,0)

----C# 1
--insert into Answer values
--('A.select * from news where dateadd(1,mm,begintime)>=GETDATE()',21,0),
--('B.select * from news where dateadd(mm,1,begintime)>=GETDATE()',21,1),
--('C.select * from news where dateadd(begintime ,mm,1)>=GETDATE()',21,0),
--('D.select * from news where datediff(1,mm, begintime)>=GETDATE()',21,0),
----C# 2
--('A.(^) ',22,0),
--('B.( ) ',22,0),
--('C.[ ]',22,1),
--('D.[^]',22,0),
----C# 3
--('A.可以代替任意长度的字符串',23,1),
--('B.可以代替一个字符',23,0),
--('C.可以代替一个字符以上的任意字符串',23,0),
--('D.用于代替一个表名或列名',23,0),
----C# 4
--('A.SUM( )',24,1),
--('B.TOTAL( )',24,0),
--('C.ADD( )',24,0),
--('D.COUNT( )',24,0),
----C# 5
--('A.private,int para',25,0),
--('B.private,ref para',25,1),
--('C.public,para ref',25,0),
--('D.public,ref para',25,1)

----insert into Answer values


--select * from Question

--  insert into PaperRecord
--  values(1,1,1,3,'2018-8-8'),
--  (1,1,2,6,'2018-8-8'),
--  (1,1,3,9,'2018-8-8'),
--  (1,1,4,15,'2018-8-8')
--insert into Module values
-- ('基础信息管理',1),
-- ('试题管理',2),
-- ('考试管理',3),
-- ('学生信息管理',4),
-- ('成绩查询统计',5),
-- ('系统设置',6)


--select * from Module
--select * from Menu
--select * from MenuItem

--insert into Menu values
--('年级管理',1,'GradeService',1), --完
--('教材管理',2,'BookService',1),--完
--('章节管理',3,'ChapterService',1),--完
--('试题类别',1,'QuestionService',2), --有Bug
--('题库管理',2,'ShowQuextionService',2),--完
--('我的录题',3,'CreatorService',2),--完
--('试题审核',4,'CheckService',2), --完，
--('录题统计',5,'CreatorCountService',2),--完
--('试题审核统计',6,'CheckCountService',2),--完
--('考试类型管理',1,'PaperTypeService',3), --完
--('考卷管理',2,'PaperService',3),--完
--('班级管理',1,'ClassService',4),--完
--('学生管理',2,'StudentService',4),--完
--('考试成绩查询',1,'ResultService',5),
--('用户管理',1,'TeacherService',6),--完
--('角色管理',2,'RoleService',6),--完
--('权限管理',3,'',6),
--('抽题策略管理',4,'PaperRuleService',6),--半
--('抽题策略明细管理',5,'RuleDetailService',6)



--insert into MenuItem values
--('年级信息列表',1,'ShowGrade',1,'1,2,3'),
--('添加年级信息',1,'AddGrade',1,'1,2,3'),
--('修改年级信息',1,'EditGrade',1,'1,2,3'),
--('删除年级信息',1,'DeleteGrade',1,'1,2,3'),
--('查询年级信息',1,'SearchGrades',1,'1,2,3'),

--('教材信息列表',1,'ShowBook',2,'1,2,3'),
--('添加教材信息',1,'AddBook',2,'1,2,3'),
--('修改教材信息',1,'EditBook',2,'1,2,3'),
--('删除教材信息',1,'DeleteBook',2,'1,2,3'),
--('查询教材信息',1,'SearchBook',2,'1,2,3'),

--('章节信息列表',1,'ShowChapter',3,'1,2,3'),
--('添加章节信息',1,'AddChapter',3,'1,2,3'),
--('修改章节信息',1,'EditChapter',3,'1,2,3'),
--('删除章节信息',1,'DeleteChapter',3,'1,2,3'),
--('查询章节信息',1,'SearchChapter',3,'1,2,3'),

--('试题类别列表',1,'ShowQuestion',4,'1,2,3'),
--('添加试题类别',1,'AddQuestion',4,'1,2,3'),
--('修改试题类别',1,'EditQuestion',4,'1,2,3'),
--('删除试题类别',1,'DeleteQuestion',4,'1,2,3'),
--('查询试题类别',1,'SearchQuestion',4,'1,2,3'),


--('试题列表',1,'ShowQuestion',5,'1,2,3'),
--('查询试题',1,'SearchQuestion',5,'1,2,3'),

--('我的录题列表',1,'MyCreator',6,'1,2,3'),
--('试题录入',1,'AddCreator',6,'1,2,3'),
--('修改试题',1,'EditCreator',6,'1,2,3'),
--('删除试题',1,'DeleteCreator',6,'1,2,3'),
--('查询试题',1,'SearchCreator',6,'1,2,3'),

--('试题审核列表',1,'ShowCheck',7,'1,2,3'),
--('试题审核',1,'QuestionCheck',7,'1,2,3'),
--('查询审核',1,'SearchCheck',7,'1,2,3'),

--('试题录入统计',1,'CreatorCount',8,'1,2,3'),
--('查询录入记录',1,'LookCreator',8,'1,2,3'),

--('试题审核统计',1,'CheckCount',9,'1,2,3'),
--('查询审核记录',1,'LookCheck',9,'1,2,3'),

--('试卷类型列表',1,'ShowPaperType',10,'1,2,3'),
--('添加试卷类型',1,'AddPaperType',10,'1,2,3'),
--('修改试卷类型',1,'EditPaperType',10,'1,2,3'),
--('删除试卷类型',1,'DeletePaperType',10,'1,2,3'),
--('查询试卷类型',1,'SearchPaperType',10,'1,2,3'),

--('试卷列表',1,'ShowPaper',11,'1,2,3'),
--('添加试卷',1,'AddPaper',11,'1,2,3'),
--('修改试卷',1,'EditPaper',11,'1,2,3'),
--('删除试卷',1,'DeletePaper',11,'1,2,3'),
--('查询试卷',1,'SearchPaper',11,'1,2,3'),

--('班级列表',1,'ShowClass',12,'1,2,3'),
--('添加班级',1,'AddClass',12,'1,2,3'),
--('修改班级',1,'EditClass',12,'1,2,3'),
--('删除班级',1,'DeleteClass',12,'1,2,3'),
--('查询班级',1,'SearchClass',12,'1,2,3'),

--('学生列表',1,'ShowStudent',13,'1,2,3'),
--('添加学生',1,'AddStudent',13,'1,2,3'),
--('修改学生',1,'EditStudent',13,'1,2,3'),
--('删除学生',1,'DeleteStudent',13,'1,2,3'),
--('查询学生',1,'SearchStudent',13,'1,2,3'),

--('查询成绩',1,'Result',14,'1,2,3'),

--('用户列表',1,'ShowTeacher',15,'1,2,3'),
--('添加用户',1,'AddTeacher',15,'1,2,3'),
--('修改用户',1,'EidtTeacher',15,'1,2,3'),
--('删除用户',1,'DeleteTeacher',15,'1,2,3'),
--('查询用户',1,'SearchTeacher',15,'1,2,3'),

--('角色列表',1,'ShowRole',16,'1,2,3'),
--('添加角色',1,'AddRole',16,'1,2,3'),
--('修改角色',1,'EidtRole',16,'1,2,3'),
--('删除角色',1,'DeleteRole',16,'1,2,3'),
--('查询角色',1,'SearchRole',16,'1,2,3'),

--('抽题策略列表',1,'ShowPaperRule',18,'1,2,3'),
--('添加抽题策略',1,'AddPaperRule',18,'1,2,3'),
--('修改抽题策略',1,'EditPaperRule',18,'1,2,3'),
--('删除抽题策略',1,'DeletePaperRule',18,'1,2,3'),
--('查询抽题策略',1,'SearchPaperRule',18,'1,2,3'),

--('策略明细列表',1,'ShowRuleDetail',19,'1,2,3'),
--('添加策略明细',1,'AddRuleDetail',19,'1,2,3'),
--('修改策略明细',1,'EditRuleDetail',19,'1,2,3'),
--('删除策略明细',1,'DeleteRuleDetail',19,'1,2,3'),
--('查询策略明细',1,'SearchRuleDetail',19,'1,2,3')


