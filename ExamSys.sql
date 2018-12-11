

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
	[Description] varchar(200) not null default 'û����'
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
	StudentName varchar(20) not null, --����
	[Password] varchar(20) not null,--����
	Gender bit not null, -- �Ա�
	Phone varchar(11) not null, --�绰
	CardID varchar(18) not null unique, -- ���֤��
	[Address] varchar(100) not null default '��', -- סַ
	Email varchar(50) null, -- ����
	Borndate date not null, -- ��������
	CreateTime date null, -- ��ѧʱ��
	ClassID int foreign key references Class(ClassID) --�༶���
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
	PaperName varchar(20) not null unique, --����
	GradeID int not null foreign key references Grade(GradeID), --�����꼶
	typeID int not null  foreign key references PaperType(TypeID), --����
	Duration int not null, --ʱ��
	IsOpen bit not null,--0�ر�,1����
	ClassList varchar(100) not null , --   1-2-3-4
	RuleID int not null foreign key references PaperRule(RuleID), --�����Ա������
	QuestionCount int not null,--��Ŀ����
	CreateTime datetime not  null default getdate(),--����ʱ��
	CreatorID int not null foreign key references Teacher(TeacherID), --�����˱��
)
select * from Teacher
create table PaperDetail
(
	PaperID int not null foreign key references Paper(PaperID),
	QuestionID int not null foreign key references Question(QuestionID),
	SortCode int not null
)
--alter table PaperDetail--��������
--add constraint PK_paperdetail primary key (PaperID,QuestionID)
select * from Paper
create table StuQueRecord--ѧ������� δʹ��
(--���--ѧ�����-�Ծ���-����ʱ��
	RecordID int not null primary key identity(1,1),
	StudetnID int not null foreign key references Student(StudentID),
	PaperID int not null foreign key references Paper(PaperID),
	RecordTime datetime not null default getdate()--����ʱ��
)

create table StuQueRecordDetail--ѧ��������ϸ�� δʹ��
(--������ϸ���-����������-������-�𰸱��
	RecordDetailID int not null primary key identity(1,1),
	RecordID int foreign key references StuQueRecord(RecordID),
	QuestionID int not null foreign key references Question(QuestionID),
	AnswerID int not null foreign key references Answer(AnswerID),
)
create table Result--�ɼ��� δʹ��
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
--A����C#   B����Java
--insert into Grade values
--('S1'),('S2A'),('S2B'),('S2'),('Y2A'),('Y2B'),('Y2')

----S1
--insert into TextBook values ('�߽�Java�������',1)
--insert into TextBook values ('HTML ��CSS��ҳ����',1)
--insert into TextBook values ('C#���Ժ����ݿ⼼��',1)
--insert into TextBook values ('Winform',1)
----S2
--insert into TextBook values ('ʹ��JQuery���ٸ�Ч������ҳ������Ч',4)
----S2B
--insert into TextBook values ('ʹ��Javaʵ�����������',3)
--insert into TextBook values ('ʹ��Javsʵ�����ݿ���',3)
--insert into TextBook values ('ʹ��JSP/Servlet�����������ŷ���ϵͳ',3)
----S2A
--insert into TextBook values ('�Ż�MySchool',2)
--insert into TextBook values ('����.NETƽ̨��C#��� -- OOP',2)
--insert into TextBook values ('����.NETƽ̨�����ϵͳ�ֲ㿪��',2)
--insert into TextBook values ('Asp WebForm������ҵ��Ӧ��',2)
----Y2
--insert into TextBook values ('Webǰ�˿��--BookStrap',7)
----Y2B
--insert into TextBook values ('ʹ��SSM��ܿ�����ҵ��Ӧ��',6)
--insert into TextBook values ('����SSH��ܵ���ҵ��Ӧ�ÿ���',6)
--insert into TextBook values ('����Hadoop��̬ϵͳ�Ĵ����ݽ������',6)
----Y2A
--insert into TextBook values ('ASP.NET MVC������ҵ��Ӧ��',5)
--insert into TextBook values ('ASP.NET WebApi',5)
--insert into TextBook values ('ǰ��AngularJS',5)

--select * from Chapter

----Java
--insert into Chapter values
--('��ʼJava',1),('�������������ͺ������',1),('ѡ��ṹ(һ)',1),('ѡ��ṹ(��)',1),('ѭ���ṹ(һ)',1),('ѭ���ṹ(��)',1),('����',1),('ѭ���ṹ����',1),('��Ͷ���',1),('����޲η���',1),('�������ķ���',1),('�ַ���',1)

----html
--insert into Chapter values
--('HTML5����',2),('�б����ý��Ԫ�غ�iframe',2),('��',2),('��ʽ��ͺ���ģ��',2),('�����Ͷ�λ��ҳԪ��',2)

----C#
--insert into Chapter values
--('��һ��C#����',3),('C#�﷨��������',3),('ʹ����������MyBank',3),('����C#��String��',3),('�������ݼ�ɢ��:���ݿ�',3),('�ñ���֯����',3),('��SQL����������',3),('���ݲ�ѯ����',3),('ģ����ѯ�;ۺϺ���',3),('���Ӳ�ѯ�ͷ����ѯ',3),('ʹ��ADO.NET�������ݿ�',3),('ʹ��ADO.NET��ѯ�Ͳ�������',3)

----WinForm
--insert into Chapter values
--('��ʶWindows����',4),('�����������õ�Windows����',4),('ʹ��ListView�ؼ�չʾ����',4),('ʵ��Windows��������ݸ���',4),('ʵ��Windows��������ݰ�',4),('����ɸѡ������',4)

----ʹ��JQuery���ٸ���������ҳ������Ч
--insert into Chapter values
--('JavaScript����',5),('JavaScript����BOM����',5),('JavaScript����DOM����',5),('JavaScript���󼰳�ʶ�������',5),('��ʶjQuery',5),('jQueryѡ����',5),('jQuery�е��¼��붯��',5),('ʹ��jQuery����DOM',5),('��У��',5)

----ʹ��Javaʵ�����������
--insert into Chapter values
--('����ͷ�װ',6),('�̳�',6),('��̬',6),('�ӿ�',6),('�쳣',6),('���Ͽ��',6),('���߳�',6),('File I/O',6)

----ʹ��Javsʵ�����ݿ���
--insert into Chapter values
--('Java���ݿ�����',7),('��ʶMySQL',7),('Java�߼���ѯ',7),('������ͼ�����������ݺͻָ�',7),('JDBC',7),('DAOģʽ',7),('XML�ļ�',7),('���似��',7),('Java�洢����',7),('�û�����Ȩ�޹���������',7)

----ʹ��JSP/Servlet�����������ŷ���ϵͳ
--insert into Chapter values
--('��̬��ҳ��������',8),('JSP���ݽ���',8),('ʹ�÷ֲ�ʵ��ҵ����',8),('JSP����ҵ��Ӧ��',8),('Servlet����',8),('JSTL��EL',8),('�Զ����ǩ',8),('Ajax��jQuery',8),('Ajax������չ',8),('S2��Ŀ����ѵ��',8)

----�Ż�MySchool
--insert into Chapter values
--('.NET���ݿ�����',9),('���ݿ��ʵ��',9),('SQL���',9),('.NET�߼���ѯ',9),('������ͼ������',9),('.NET�洢����',9)

----����.NETƽ̨��C#��� -- OOP
--insert into Chapter values
--('����.NET���',10),('����C#��������',10),('ʹ�ü�����֯�������',10),('������ķ���',10),('��ʶ�̳кͶ�̬',10),('��������̬',10),('����չ�������XML',10),('�ļ�����',10)

----����.NETƽ̨�����ϵͳ�ֲ㿪��
--insert into Chapter values
--('���ϵͳ�ķֲ㿪��',11),('OOP����Ӧ�ã�ʵ����',11),('���ϵͳ���ܣ������ݷ��ʿ���',11),('ҵ�����չ������ܹ�',11),('ʵ������Windows�����еĸ߼�Ӧ��',11)

----Asp WebForm������ҵ��Ӧ��
--insert into Chapter values
--('Hello,Asp.net',12),('ҳ����ʿ���',12),('����������֤',12),('����ͳһ��webվ��',12),('��������ϵͳ�ܹ�',12),('ʹ��jQuery��Ajax',12),('һ�㴦�����',12),('����js���ʹ��',12),('���ݻ���',12),('webservice',12),('��վ���úͲ���',12)

----Webǰ�˿��--BootStrap
--insert into Chapter values
--('��Ӧʽ����',13),('Bootstrap��ʽ',13),('Bootstrap���',13),('JavaScript���',13),('�ƶ�Webҳ�濪��',13),('�ƶ�Web��Ч����',13)

----ʹ��SSM��ܿ�����ҵ��Ӧ��
--insert into Chapter values
--('��ʼMyBatis',14),('SQLӳ���ļ�',14),('��̬SQL',14),('Spring���ĸ���',14),('IoC��AOPʹ����չ',14),('MyBatis��Spring������',14),('Spring���ò���',14),('Spring MVC��ϵ�ṹ�ʹ������������',14),('ʹ��Spring MVC��ܸ��쳬�ж���ϵͳ',14),('Spring MVC��չ��SSM�������',14)

----����SSH��ܵ���ҵ��Ӧ�ÿ���
--insert into Chapter values
--('Oracle���ݿ����',15),('Oracle���ݿ�Ӧ��',15),('PL/SQL���',15),('Hibernate����',15),('HQLʵ�ü���',15),('Hibernate��ϵӳ��',15),('HQL���Ӳ�ѯ��ע��',15),('Struts2����',15),('Struts2�������',15),('OGNL',15),('������',15),('�SSH���',15)

----����Hadoop��̬ϵͳ�Ĵ����ݽ������
--insert into Chapter values
--('Hadoop����',16),('HDFSʵ�ֲַ�ʽ�洢',16),('MapReduceʵ�ֲַ�ʽ����',16),('HBase���ݿ�',16),('Hadoop�ۺ�Ӧ��',16)

----ASP.NET MVC������ҵ��Ӧ��
--insert into Chapter values
--('���� ASP.NET MVC ����',17)

----ASP.NET WebApi
--insert into Chapter values
--('��ʶWeb API',18)

--insert into role values 
--('����Ա',default),('��Ա',default),('������',default)

--insert into Teacher
--values
-- ('����Ա','admin','123123',1,'2010-1-1'),
--('����','zhangsan','111222',2,'2012-1-1'),
--('����','lisi','000000',3,'2012-1-13'),
--('¼����','lutiren','111111',2,'2010-2-2'),
--('�����','shenheren','222222',2,'2010-3-2')

--insert into Class values
--('T191',3,2,1,'2018-4-20'),('T192',3,2,3,'2018-4-30'),('T189',3,2,2,'2018-4-30'),('T194',3,2,1,'2018-4-30'),('T195',3,2,3,'2018-4-30')

--select * from Class

--insert into Student values
--('�̿�','924566',1,'15595499692','13042319980122281x',default,'924566@qq.com','1998-1-22','2018-4-1',1),
--('�Ƽ���','24526699',1,'15158069534','130429199901015423',default,'24526699@qq.com','1999-1-1','2018-4-1',2),
--('�ź��','129790',0,'15532069962','130481199910106622',default,'129790@qq.com','1999-10-10','2018-3-31',3),
--('Ѧ���','165088',1,'15230092670','13042920000504521x',default,'165088@qq.com','2000-05-04','2018-3-21',4)

----insert into Question values
----('A��',0,1,1,0,4,'2018-8-20',5,'2018-8-21','������CΪ��ȷ��'),
----('B��',0,2,1,0,4,'2018-8-20',5,'2018-8-21','������CΪ��ȷ��'),
----('C��',1,3,1,1,4,'2018-8-20',5,'2018-8-21','������CΪ��ȷ��'),
----('D��',0,3,1,1,4,'2018-8-20',5,'2018-8-21','������CΪ��ȷ��'),
----('E��',1,3,1,1,4,'2018-8-20',5,'2018-8-21','������CΪ��ȷ��')



--insert into Question values
----WinForm 1
--('��C#�������Ѿ�������DataSet ds��DataAdapter da ����Ҫ�����ݿ���Users������ݷ���ds�е�MyUsers���ݱ��У����������ȷ���ǣ�  ����  (ѡ��һ��)',0,2,4,34,0,2,'2018-9-26',null,null,'��ȷ�𰸣�B �𰸽���: Fill(DataSet ds��String tbl_name) �ڶ�������Ϊ�Զ������ʱ���ݿ��еı���'),
----WinForm 2
--('���¹���C#��DataGridView�ؼ���˵������ȷ���ǣ� ����  (ѡ��һ��)',0,2,4,35,0,2,'2018-9-26',null,null,'��ȷ�𰸣�B �𰸽���: ��Ϊ��������Ϊ������������ˣ�û�����������ܶ�����ִ�и��²���'),
----WinForm 3
--('��C#�У�����DataGridView��ʹ�ã�˵����ȷ���ǣ�����  (ѡ�����)',1,2,4,34,0,2,'2018-9-26',null,null,'��ȷ�𰸣�C,D �𰸽���: Aѡ�����DataGridView�ؼ���DataSource������ĳ��DataTable�������DataView����ȡ� Bѡ�����ReadOnly������boo����'),
----WinForm 4
--('��C#�У���SqlDataAdapter��DataSet��teacher���ж�ȡ���ݣ��ٶ�conn��һ�����õ����ݿ����ӣ��Ķ����´��룺

--DataSet dss = new DataSet( );     //��

--SqlDataAdapter dap = new SqlDataAdapter("select * fromteacher", conn);// ��

--conn.Open();//��

--dap.Fill(dss��"myTeacher");//��

--�������δ��룬˵����ȷ���ǣ�����  (ѡ��һ��)
--',0,2,4,33,0,2,'2018-9-26',null,null,'��ȷ�𰸣�C

--�𰸽���:

--DataAdapter�����Լ��������ӵĿ��أ����Ԣ۲��Ǳ����

--�������ʱ�����������Զ��壬����Ҫ������Դ����һ��'),
----WinForm 5
--('��WinForms�У���д����ΪComboBox�ؼ�������ʱ����Ҫ�� ���� (ѡ��һ��)',0,2,4,31,0,2,'2018-9-26',null,null,'��ȷ�𰸣�D

--�𰸽���:

--DataSource������������Դ

--DisplayMember����������ʾ��

--ValueMember��������ֵ��

--'),
----WinForm 6
--('��WinForms�У�tvΪTreeView�ؼ�����ͨ���� �����Կ��Ի�ȡTreeView�е�ǰѡ�нڵ���ı���  (ѡ�����)',1,2,4,34,0,2,'2018-9-26',null,null,'��ȷ�𰸣�B,C

--�𰸽���:

--��ȡѡ�нڵ�Ϊ��SelectedNode����

--��ȡ�ڵ��ı�Ϊ��Text����
--'),
----WinForm 7
--('��TreeView�ؼ���ÿ���ڵ�ǰ���һ��ͼ�꣬Ӧ�����ã������ԡ�',0,2,4,34,0,4,'2018-9-26',null,null,'��ȷ�𰸣�A

--�𰸽���:

--ֻҪ�����ؼ���ͼƬ�б��ϣ����ؼ�ǰ�Ľڵ��Ĭ����ʾ��һ��Сͼ����
--'),
----WinForm 8
--('��WinForms��,һ�´���ʵ����ʹ��DataView����ɾѡѧ����Ϣ,������ѧ��������������.����,"Student"Ϊѧ����Ϣ��,"StudentName"Ϊ ѧ������.����ڴ���Ĵ�������( ).

--DataSet ds = new DataSet(); //1

--DataView dv = new DataView(ds.Tables["Student"]); //2

--dv.Filter = "StudentName like "��%""; //3

--dv.Sort = "order by StudentName desc"; //4(ѡ��һ��)',0,2,4,34,0,4,'2018-9-26',null,null,'��ȷ�𰸣�C

--�𰸽���:

--������������Ϊ��RowFilter

--������������ʱ����д order by'),
----WinForm 9
--('��WinFormsӦ�ó�����,���CheckBox�ؼ���Checked����ֵ����ΪTrue,��������к�().(ѡ��һ��)',0,2,4,33,0,4,'2018-9-26',null,null,'��ȷ�𰸣�C

--�𰸽���:

--CheckBox�е�Checked����Ϊ���û��ȡ��ѡ��ť��ѡ��״̬,����ΪTrueʱ����ѡ�е�״̬
--'),
----WinForm 10
--('MenuStrip�ؼ�����ʾΪһ����ťѡ�������()���͵�.(ѡ��һ��)',0,2,4,31,0,4,'2018-9-26',null,null,'��ȷ�𰸣�A

--�𰸽���:

--MenuStrip�еİ�ťѡ����ΪToolStripMenuItem,'),
----WinForm 11
--('private void btnOK_Click(object sender, EventArgs e)

--{

--      FrmList frmList =new FrmList ();

--      frmList.MdiParent =this;

--      frmList.ShowDialog();

--}

--����ܣ��� (ѡ��һ��)
--',0,2,4,31,0,4,'2018-9-26',null,null,'��ȷ�𰸣�B

--�𰸽���:

--��ʹ��MDI����ʱ,��������ͨ�Ĵ�����ʽ������ʾ,����Ϊģʽ������ʱ�������쳣
--'),
----WinForm 12

--('��WinForms�У����й��ڲ˵����ؼ�MenuStrip�����Ժ��¼�˵��������ǣ� ��  (ѡ��һ��)',0,2,4,31,0,4,'2018-9-26',null,null,'��ȷ�𰸣�D

--�𰸽���:

--Modifiers����Ϊ���ÿؼ��ķ���������,

--'),
----WinForm 13
--('��WinForms�У��������´����ܹ�ʵ�ֵ������ͼƬ����ť��Name����ֵΪbtnLarge���͡�СͼƬ����ť��Name����ֵΪbtnSmall������СͼƬ�л���ʾ������lvImageΪListView��Name����ֵ����ô���ߴ�������ȷ��д�Ĵ����ǣ� ����
--private void btnLarge_Click(object sender, EventArgs e)
--{
--    lvImage.View = _____________;
--}
--private void btnSmall_Click(object sender, EventArgs e)
--{
--    lvImage.View = _____________;
--}',0,2,4,31,0,2,'2018-10-5',null,null,'��ȷ�𰸣�A

--�𰸽���: ���ݰ�ť������ȷ����д�Ĵ���,btnLarge_Click��ӦView.LargeIcon��btnSmall_Click��ӦView.SmallIcon'),
----WinForm 14
--('���£�������WinForm��ListView�ؼ�View���Ե���Чֵ����ѡ��һ�',0,2,4,32,0,2,'2018-10-5',null,null,'��ȷ�𰸣�D

--�𰸽���: ListView�о���LargeIcon,SmallIcon,List,Details,Tile����,�ֱ��Ǵ�ͼ��,Сͼ��,�б�,��ϸ��ƽ��'),
----WinForm 15
--('�������ListView�ؼ�����������ȷ���ǣ�����',0,2,4,32,0,2,'2018-10-5',null,null,'��ȷ�𰸣�A

--�𰸽���: ��ListView�����������Ҫʹ��Items���Զ�Ӧ���ListViewItem����'),
----WinForm 16
--('���й��ڿؼ�ListView �����Ե������������()��(ѡ��һ��)',0,2,4,32,0,2,'2018-10-5',null,null,'��ȷ�𰸣�A

--�𰸽���:

--Columns����Ϊ��������ϸ��Ϣ��ͼ����ʾ����'),
----WinForm 17
--('��WinForms�У�����Timer����ʱ�����ؼ������Ժ��¼���˵��������ǣ� ����  (ѡ��һ��)',0,2,4,31,0,2,'2018-10-5',null,null,'��ȷ�𰸣�D

--�𰸽���:

--Stop()��������ֹͣ��ʱ��,���ǲ�����ʹ���޷��ڴ�����'),
----WinForm 18
--('��C#�У�����ö�ٵ���ȷ�����ǣ�      ����  (ѡ�����)',1,2,4,32,0,2,'2018-10-5',null,null,'��ȷ�𰸣�A,B

--�𰸽���: EnumΪö�ٵĹؼ���,������ΪΪһ�����޵����������ȷ�Ķ���'),
----WinForm 19
--('��WinForms�У�ִ��TextBox�ؼ��ģ���������ʹ���ý��㡣  (ѡ��һ��)',0,2,4,30,0,2,'2018-10-5',null,null,'��ȷ�𰸣�A

--�𰸽���: ��WinForms�У�ִ��TextBox�ؼ��� Focus() ������ʹ���ý���'),
----WinForm 20
--('Timer�ؼ���Interval���Կ������ö�ʱ�����¼��ļ�������ĵ�λ�ǣ�����',0,2,4,32,0,2,'2018-10-5',null,null,'��ȷ�𰸣�B

--�𰸽���: Timer�ؼ���Interval���Կ������ö�ʱ�����¼��ļ�������ĵ�λ�� ����')

----C# 1
--insert into Question values
--('��SQL Server�У���һ�����ű�news�����ŷ���ʱ��Ϊ�ֶ�begintime����Ҫ��ѯ���һ�����ڷ�������ŵ���Ϣ��������SQL�����ȷ���ǣ� ����',0,1,3,25,0,4,'2018-10-5',null,null,'��ȷ�𰸣�B

--�𰸽���:

--dateAdd�����ͣ�ֵ�����ڣ�  ���Ϳ�ȡ��dd��mm��yy��day��month��year

--daatediff���� ���ڼ�������֮��Ĳ�'),
----C# 2
--('��SQL Server  �У�ͨ���ͨ����LIKE�ؼ���һ�����ʹ�ã�����ͨ�����(  )��ʾ��������ָ����Χ�ڵ�һ���ַ���',0,1,3,24,0,5,'2018-10-6',null,null,'��ȷ�𰸣�C

--�𰸽���:

--[ ] �����ű�ʾ��һ����Χ��,[^ ] ��ʾ����ĳ����Χ��'),
----C# 3
--('��T-SQL�У�����ͨ�����%����˵����ȷ���ǣ�����',0,1,3,24,0,5,'2018-10-6',null,null,'��ȷ�𰸣�A

--�𰸽���:

--�������ڻ��������ס�Ϳ����ˣ� û��Ϊʲô'),
----C# 4
--('��SQL Server�У���������ͳ�Ʊ��м�¼֮�͵ĺ����ǣ�����',0,1,3,26,0,5,'2018-10-6',null,null,'��ȷ�𰸣�A

--�𰸽���:

--����ۺϺ�����  sum ���  ��count ������ avg ƽ��  �� max  ���ֵ�� min ��Сֵ'),
----C# 5
--('��C#�У�Ҫʹ���´�����ȷ���У���٢���Ӧ�÷ֱ���д������

--_��__static int getResult(int left, ref int right)

--{

--    right = left +right;  

--    return right;

--}

--static void Main(string[] args)

--{

--    int para = 6;

--    int result =getResult(5, _��__);

--}  (ѡ�����)',1,2,3,20,0,2,'2018-10-6',null,null,'��ȷ�𰸣�B,D

--�𰸽���:

--���ô��Σ��βκ�ʵ��ǰ�������ref�ؼ���')

----insert into Question values


--select * from TextBook
--select * from Question
--select * from Answer
--select * from Chapter

--insert into PaperType
-- values('�ڲ�'),('ģ��'),('��ҵ'),('���')

-- select * from Teacher

-- insert into PaperRule
-- values('��һѧ��',1,4,'2018-8-8'),
-- ('�ڶ�ѧ��',2,4,'2018-8-10'),
-- ('����ѧ��',3,4,'2018-8-12')

-- select * from Paper

-- insert into Paper
--  values('a��',1,1,60,1,'191-192-193-194',1,50,'2018-8-4',4),
--  ('b��',2,1,60,0,'181-182-183-184',2,50,'2018-8-5',4),
--  ('c��',2,1,60,1,'171-177-172-174',2,50,'2018-8-5',4),
--  ('d��',1,1,60,0,'195-199',1,50,'2018-8-4',4)

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
--('A. DataSet������ΪDataGirdView������Դ����DataTable������',2,0),
--('B. Ҫ��DataGridView�е����ݸ��µ���Ӧ�����ݱ��У���ö�Ӧ�����Ҫ������',2,1),
--('C. DataGridViewÿ�е�HeaderText�����������ø��а󶨵������е�����',2,0),
--('D. DataGridViewÿ�е�Frozen�����������õ�DataGridView��ֱ����ʱ�������Ƿ��ƶ�',2,0),
----WinForm 3
--('A.DataGridView�ؼ���DataSource������ĳ��DataSet����',3,0),
--('B.��DataGridView��ReadOnly��������Ϊ0����DataGridView�ĵ�Ԫ�񲻿ɱ༭',3,0),
--('C.DataPropertyName��ʾ�󶨵������е�����',3,1),
--('D.����DataGridView�е����ݣ����Խ���DataAdapter��Update( )����',3,1),
----WinForm 4
--('A.���Ǳ����',4,0),
--('B.���еĵڶ�����������ֻ����"teacher"',4,0),
--('C.SqlDataAdapter�൱�����ݿ��DataSet����������䳵',4,1),
--('D.�����˵��������',4,0),
----WinForm 5
--('A.����ValueMember����',5,0),
--('B.����DisplayMember����',5,0),
--('C.����DataSource����',5,0),
--('D.����DataBind()����',5,1),
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
--('A.1 �� 2',8,0),
--('B.2 �� 3',8,0),
--('C.3 �� 4',8,1),
--('D.1 �� 4 ',8,0),
----WinForm 9
--('A.��CheckBox�ɼ�',9,0),
--('B.��CheckBox����ѡ��',9,0),
--('C.��CheckBox��ѡ��',9,1),
--('D.��CheckBox��������',9,0),
----WinForm 10
--('A.ToolStripMenuItem',10,1),
--('B.Item',10,0),
--('C.ToolItem',10,0),
--('D.StripItem',10,0),
----WinForm 11
--('A.�������',11,0),
--('B.����ʱ�����쳣',11,1),
--('C.FrmList������FrmMain����ΪMDI�������',11,0),
--('D.FrmList������ģʽ�����ڴ�',11,0),
----WinForm 12
--('A.Name��ʾ�����в˵����������',12,0),
--('B.Items��ʾ�ڲ˵�����ʾ����ļ���',12,0),
--('C.Text��ʾ��˵���������ı�',12,0),
--('D.Modifiers��ʾ�ڸ��˵�����ʾ����ļ���',12,1),
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
--('A.Items��Add()�������ڽ�����ӵ���ļ�����',15,1),
--('B.AddRange()�����������б������������µ�����',15,0),
--('C.SubItems��Ӧ���б���ͼ��ListViewItem',15,0),
--('D.����ʹ��DataSource������Դ',15,0),
----WinForm 16
--('A.Columns ���Ա�ʾ" ��ϸ��Ϣ"��ͼ����ʾ����',16,1),
--('B.MultiSelect ���Ա�ʾ�Ƿ�����ѡ�����',16,0),
--('C.View ������������ListV��ew ����ͼģʽ',16,0),
--('D.FullRowSelect ���Ա�ʾ��ѡ��һ��ʱ�����������Ƿ�ͬ����һ��ͻ����ʾ ',16,0),
----WinForm 17
--('A.��Interval��������Ϊ1000������ü�ʱ�����ã����¼�ÿ��1�뷢��һ��',17,0),
--('B.��Enabled��������Ϊfalse�����¼����ᷢ��',17,0),
--('C.Timer�ؼ�һ��������Ҫÿ��һ��ʱ���ظ�ִ�д�������',17,0),
--('D.Stop()��ʾֹͣ��ʱ����ֹͣ���޷�������',17,1),
----WinForm 18
--('A.ö��ʹ��enum�ؼ��ֶ���',18,1),
--('B.ö�ٱ�ʾ��һ�����޵���ֵ',18,1),
--('C.ö������������',18,0),
--('D.ö���п��Զ������Ժͷ���',18,0),
----WinForm 19
--('A. Focus();',19,1),
--('B. GetFocus();',19,0),
--('C. In();',19,0),
--('D.MouseIn();',19,0),
----WinForm 20
--('A.��',20,0),
--('B.����',20,1),
--('C.΢��',20,0),
--('D.��',20,0)

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
--('A.���Դ������ⳤ�ȵ��ַ���',23,1),
--('B.���Դ���һ���ַ�',23,0),
--('C.���Դ���һ���ַ����ϵ������ַ���',23,0),
--('D.���ڴ���һ������������',23,0),
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
-- ('������Ϣ����',1),
-- ('�������',2),
-- ('���Թ���',3),
-- ('ѧ����Ϣ����',4),
-- ('�ɼ���ѯͳ��',5),
-- ('ϵͳ����',6)


--select * from Module
--select * from Menu
--select * from MenuItem

--insert into Menu values
--('�꼶����',1,'GradeService',1), --��
--('�̲Ĺ���',2,'BookService',1),--��
--('�½ڹ���',3,'ChapterService',1),--��
--('�������',1,'QuestionService',2), --��Bug
--('������',2,'ShowQuextionService',2),--��
--('�ҵ�¼��',3,'CreatorService',2),--��
--('�������',4,'CheckService',2), --�꣬
--('¼��ͳ��',5,'CreatorCountService',2),--��
--('�������ͳ��',6,'CheckCountService',2),--��
--('�������͹���',1,'PaperTypeService',3), --��
--('�������',2,'PaperService',3),--��
--('�༶����',1,'ClassService',4),--��
--('ѧ������',2,'StudentService',4),--��
--('���Գɼ���ѯ',1,'ResultService',5),
--('�û�����',1,'TeacherService',6),--��
--('��ɫ����',2,'RoleService',6),--��
--('Ȩ�޹���',3,'',6),
--('������Թ���',4,'PaperRuleService',6),--��
--('���������ϸ����',5,'RuleDetailService',6)



--insert into MenuItem values
--('�꼶��Ϣ�б�',1,'ShowGrade',1,'1,2,3'),
--('����꼶��Ϣ',1,'AddGrade',1,'1,2,3'),
--('�޸��꼶��Ϣ',1,'EditGrade',1,'1,2,3'),
--('ɾ���꼶��Ϣ',1,'DeleteGrade',1,'1,2,3'),
--('��ѯ�꼶��Ϣ',1,'SearchGrades',1,'1,2,3'),

--('�̲���Ϣ�б�',1,'ShowBook',2,'1,2,3'),
--('��ӽ̲���Ϣ',1,'AddBook',2,'1,2,3'),
--('�޸Ľ̲���Ϣ',1,'EditBook',2,'1,2,3'),
--('ɾ���̲���Ϣ',1,'DeleteBook',2,'1,2,3'),
--('��ѯ�̲���Ϣ',1,'SearchBook',2,'1,2,3'),

--('�½���Ϣ�б�',1,'ShowChapter',3,'1,2,3'),
--('����½���Ϣ',1,'AddChapter',3,'1,2,3'),
--('�޸��½���Ϣ',1,'EditChapter',3,'1,2,3'),
--('ɾ���½���Ϣ',1,'DeleteChapter',3,'1,2,3'),
--('��ѯ�½���Ϣ',1,'SearchChapter',3,'1,2,3'),

--('��������б�',1,'ShowQuestion',4,'1,2,3'),
--('����������',1,'AddQuestion',4,'1,2,3'),
--('�޸��������',1,'EditQuestion',4,'1,2,3'),
--('ɾ���������',1,'DeleteQuestion',4,'1,2,3'),
--('��ѯ�������',1,'SearchQuestion',4,'1,2,3'),


--('�����б�',1,'ShowQuestion',5,'1,2,3'),
--('��ѯ����',1,'SearchQuestion',5,'1,2,3'),

--('�ҵ�¼���б�',1,'MyCreator',6,'1,2,3'),
--('����¼��',1,'AddCreator',6,'1,2,3'),
--('�޸�����',1,'EditCreator',6,'1,2,3'),
--('ɾ������',1,'DeleteCreator',6,'1,2,3'),
--('��ѯ����',1,'SearchCreator',6,'1,2,3'),

--('��������б�',1,'ShowCheck',7,'1,2,3'),
--('�������',1,'QuestionCheck',7,'1,2,3'),
--('��ѯ���',1,'SearchCheck',7,'1,2,3'),

--('����¼��ͳ��',1,'CreatorCount',8,'1,2,3'),
--('��ѯ¼���¼',1,'LookCreator',8,'1,2,3'),

--('�������ͳ��',1,'CheckCount',9,'1,2,3'),
--('��ѯ��˼�¼',1,'LookCheck',9,'1,2,3'),

--('�Ծ������б�',1,'ShowPaperType',10,'1,2,3'),
--('����Ծ�����',1,'AddPaperType',10,'1,2,3'),
--('�޸��Ծ�����',1,'EditPaperType',10,'1,2,3'),
--('ɾ���Ծ�����',1,'DeletePaperType',10,'1,2,3'),
--('��ѯ�Ծ�����',1,'SearchPaperType',10,'1,2,3'),

--('�Ծ��б�',1,'ShowPaper',11,'1,2,3'),
--('����Ծ�',1,'AddPaper',11,'1,2,3'),
--('�޸��Ծ�',1,'EditPaper',11,'1,2,3'),
--('ɾ���Ծ�',1,'DeletePaper',11,'1,2,3'),
--('��ѯ�Ծ�',1,'SearchPaper',11,'1,2,3'),

--('�༶�б�',1,'ShowClass',12,'1,2,3'),
--('��Ӱ༶',1,'AddClass',12,'1,2,3'),
--('�޸İ༶',1,'EditClass',12,'1,2,3'),
--('ɾ���༶',1,'DeleteClass',12,'1,2,3'),
--('��ѯ�༶',1,'SearchClass',12,'1,2,3'),

--('ѧ���б�',1,'ShowStudent',13,'1,2,3'),
--('���ѧ��',1,'AddStudent',13,'1,2,3'),
--('�޸�ѧ��',1,'EditStudent',13,'1,2,3'),
--('ɾ��ѧ��',1,'DeleteStudent',13,'1,2,3'),
--('��ѯѧ��',1,'SearchStudent',13,'1,2,3'),

--('��ѯ�ɼ�',1,'Result',14,'1,2,3'),

--('�û��б�',1,'ShowTeacher',15,'1,2,3'),
--('����û�',1,'AddTeacher',15,'1,2,3'),
--('�޸��û�',1,'EidtTeacher',15,'1,2,3'),
--('ɾ���û�',1,'DeleteTeacher',15,'1,2,3'),
--('��ѯ�û�',1,'SearchTeacher',15,'1,2,3'),

--('��ɫ�б�',1,'ShowRole',16,'1,2,3'),
--('��ӽ�ɫ',1,'AddRole',16,'1,2,3'),
--('�޸Ľ�ɫ',1,'EidtRole',16,'1,2,3'),
--('ɾ����ɫ',1,'DeleteRole',16,'1,2,3'),
--('��ѯ��ɫ',1,'SearchRole',16,'1,2,3'),

--('��������б�',1,'ShowPaperRule',18,'1,2,3'),
--('��ӳ������',1,'AddPaperRule',18,'1,2,3'),
--('�޸ĳ������',1,'EditPaperRule',18,'1,2,3'),
--('ɾ���������',1,'DeletePaperRule',18,'1,2,3'),
--('��ѯ�������',1,'SearchPaperRule',18,'1,2,3'),

--('������ϸ�б�',1,'ShowRuleDetail',19,'1,2,3'),
--('��Ӳ�����ϸ',1,'AddRuleDetail',19,'1,2,3'),
--('�޸Ĳ�����ϸ',1,'EditRuleDetail',19,'1,2,3'),
--('ɾ��������ϸ',1,'DeleteRuleDetail',19,'1,2,3'),
--('��ѯ������ϸ',1,'SearchRuleDetail',19,'1,2,3')


