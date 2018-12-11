use ExamSys
go
--A代表C#   B代表Java
insert into Grade values
('S1'),('S2A'),('S2B'),('Y2A'),('Y2B')

--S1
insert into TextBook values ('走进Java编程世界',1)
insert into TextBook values ('HTML 和CSS网页技术',1)
insert into TextBook values ('C#语言和数据库技术',1)
insert into TextBook values ('Winform',1)
--S2
--S2B
insert into TextBook values ('java使用JQuery快速高效制作网页交互特效',3)
insert into TextBook values ('使用Java实现面向对象编程',3)
insert into TextBook values ('使用Javs实现数据库编程',3)
insert into TextBook values ('使用JSP/Servlet技术开发新闻发布系统',3)
--S2A
insert into TextBook values ('.net使用JQuery快速高效制作网页交互特效',2)
insert into TextBook values ('优化MySchool',2)
insert into TextBook values ('深入.NET平台和C#编程 -- OOP',2)
insert into TextBook values ('深入.NET平台的软件系统分层开发',2)
insert into TextBook values ('Asp WebForm开发企业级应用',2)
--Y2

--Y2B
insert into TextBook values ('java-Web前端框架--BookStrap',5)
insert into TextBook values ('使用SSM框架开发企业级应用',5)
insert into TextBook values ('基于SSH框架的企业级应用开发',5)
insert into TextBook values ('基于Hadoop生态系统的大数据解决方案',5)
--Y2A
insert into TextBook values ('.net-Web前端框架--BookStrap',4)
insert into TextBook values ('ASP.NET MVC开发企业级应用',4)
insert into TextBook values ('ASP.NET WebApi',4)
insert into TextBook values ('前端AngularJS',4)
--insert into TextBook values ('ASP.NET SignalR',5)

select * from TextBook
select * from Student
--Java
insert into Chapter values
('初始Java',1),('变量，数据类型和运算符',1),('选择结构(一)',1),('选择结构(二)',1),('循环结构(一)',1),('循环结构(二)',1),('数组',1),('循环结构进阶',1),('类和对象',1),('类的无参方法',1),('带参数的方法',1),('字符串',1)

--html
insert into Chapter values
('HTML5基础',2),('列表、表格、媒体元素和iframe',2),('表单',2),('样式表和盒子模型',2),('浮动和定位网页元素',2)

--C#
insert into Chapter values
('第一个C#程序',3),('C#语法快速热身',3),('使用属性升级MyBank',3),('深入C#的String类',3),('程序数据集散地:数据库',3),('用表组织数据',3),('用SQL语句操作数据',3),('数据查询基础',3),('模糊查询和聚合函数',3),('连接查询和分组查询',3),('使用ADO.NET访问数据库',3),('使用ADO.NET查询和操作数据',3)

--WinForm
insert into Chapter values
('初识Windows程序',4),('构建布局良好的Windows程序',4),('使用ListView控件展示数据',4),('实现Windows程序的数据更新',4),('实现Windows程序的数据绑定',4),('数据筛选和排序',4)

--java使用JQuery快速高速制作网页交互特效
insert into Chapter values
('java-JavaScript基础',5),('java-JavaScript操作BOM对象',5),('java-JavaScript操作DOM对象',5),('java-JavaScript对象及初识面向对象',5),('java-初识jQuery',5),('java-jQuery选择器',5),('java-jQuery中的事件与动画',5),('java-使用jQuery操作DOM',5),('java-表单校验',5)
select * from Chapter
--使用Java实现面向对象编程
insert into Chapter values
('对象和封装',6),('继承',6),('多态',6),('接口',6),('异常',6),('集合框架',6),('多线程',6),('File I/O',6)

--使用Javs实现数据库编程
insert into Chapter values
('Java数据库的设计',7),('初识MySQL',7),('Java高级查询',7),('事务、视图、索引、备份和恢复',7),('JDBC',7),('DAO模式',7),('XML文件',7),('反射技术',7),('Java存储过程',7),('用户管理、权限管理、触发器',7)

--使用JSP/Servlet技术开发新闻发布系统
insert into Chapter values
('动态网页开发基础',8),('JSP数据交互',8),('使用分层实现业务处理',8),('JSP开发业务应用',8),('Servlet基础',8),('JSTL和EL',8),('自定义标签',8),('Ajax与jQuery',8),('Ajax交互扩展',8),('S2项目进阶训练',8)

--.net使用JQuery快速高速制作网页交互特效
insert into Chapter values
('.net-JavaScript基础',9),('.net-JavaScript操作BOM对象',9),('.net-JavaScript操作DOM对象',9),('.net-JavaScript对象及初识面向对象',9),('.net-初识jQuery',9),('.net-jQuery选择器',9),('.net-jQuery中的事件与动画',9),('.net-使用jQuery操作DOM',9),('.net-表单校验',9)
--优化MySchool
insert into Chapter values
('.NET数据库的设计',10),('数据库的实现',10),('SQL编程',10),('.NET高级查询',10),('事务、视图和索引',10),('.NET存储过程',10)
--深入.NET平台和C#编程 -- OOP
insert into Chapter values
('深入.NET框架',11),('深入C#数据类型',11),('使用集合组织相关数据',11),('深入类的方法',11),('初识继承和多态',11),('深入理解多态',11),('可扩展标记语言XML',11),('文件操作',11)

--深入.NET平台的软件系统分层开发
insert into Chapter values
('软件系统的分层开发',12),('OOP典型应用：实体类',12),('提高系统性能：从数据访问开发',12),('业务的扩展：三层架构',12),('实体类在Windows程序中的高级应用',12)

--Asp WebForm开发企业级应用
insert into Chapter values
('Hello,Asp.net',13),('页面访问控制',13),('表单和数据验证',13),('搭建风格统一的web站点',13),('网上书店的系统架构',13),('使用jQuery和Ajax',13),('一般处理程序',13),('常见js库的使用',13),('数据缓存',13),('webservice',13),('网站配置和部署',13)

--Y2B Web前端框架--BootStrap
insert into Chapter values
('java-响应式布局',14),('java-Bootstrap样式',14),('java-Bootstrap组件',14),('java-JavaScript插件',14),('java-移动Web页面开发',14),('java-移动Web特效开发',14)

--使用SSM框架开发企业级应用
insert into Chapter values
('初始MyBatis',15),('SQL映射文件',15),('动态SQL',15),('Spring核心概念',15),('IoC和AOP使用扩展',15),('MyBatis与Spring的整合',15),('Spring配置补充',15),('Spring MVC体系结构和处理请求控制器',15),('使用Spring MVC框架改造超市订单系统',15),('Spring MVC扩展和SSM框架整合',15)

--基于SSH框架的企业级应用开发
insert into Chapter values
('Oracle数据库基础',16),('Oracle数据库应用',16),('PL/SQL编程',16),('Hibernate入门',16),('HQL实用技术',16),('Hibernate关系映射',16),('HQL连接查询和注解',16),('Struts2入门',16),('Struts2配置详解',16),('OGNL',16),('拦截器',16),('搭建SSH框架',16)

--基于Hadoop生态系统的大数据解决方案
insert into Chapter values
('Hadoop入门',17),('HDFS实现分布式存储',17),('MapReduce实现分布式运算',17),('HBase数据库',17),('Hadoop综合应用',17)


--Y2A Web前端框架--BootStrap
insert into Chapter values
('.net-响应式布局',18),('.net-Bootstrap样式',18),('.net-Bootstrap组件',18),('.net-JavaScript插件',18),('.net-移动Web页面开发',18),('.net-移动Web特效开发',18)

--ASP.NET MVC开发企业级应用
insert into Chapter values
('进入 ASP.NET MVC 世界',19)

--ASP.NET WebApi
insert into Chapter values
('认识Web API',20)
--选择结构(一)-选择结构(二)-循环结构(一)-循环结构(二)-数组-循环结构进阶-类和对象-类的无参方法-类的有参方法-字符串

insert into role values 
('管理员',default),('教员',default),('班主任',default)
select * from PaperDetail
insert into Teacher
values
 ('管理员','admin','123123',1,'2010-1-1'),
('张三','zhangsan','111222',2,'2012-1-1'),
('李四','lisi','000000',3,'2012-1-13'),
('录题人','lutiren','111111',2,'2010-2-2'),
('审核人','shenheren','222222',2,'2010-3-2')
--班级编号-班级名称-教员-班主任-年级编号-开学时间('S1'),('S2A'),('S2B'),('Y2A'),('Y2B')
insert into Class values
('T191',2,3,1,'2018-4-20'),
('T192',2,3,1,'2018-5-30'),
('T174',2,3,3,'2018-1-1'),
('T180',2,3,2,'2018-1-1')
insert into Student values
('商科','924566',1,'15595499692','13042319980122281x',default,'924566@qq.com','1998-1-22','2018-4-1',1),
('闫继阳','123456',1,'15158069534','130429199901015423',default,'24526699@qq.com','1999-1-1','2018-4-1',1),
('张红杰','123456',0,'15532069962','130481199910106622',default,'129790@qq.com','1999-10-10','2018-3-31',1),
('薛雄楠','123456',1,'15230092670','13042920000504521x',default,'165088@qq.com','2000-05-04','2018-3-21',1),
('老A','123456',1,'15555555555','130111111111111111','河北','123456@qq.com','1999-9-9','2018-1-1',3),
('老B','123456',1,'15555555555','130111111111111112','河北','1234567@qq.com','1999-9-9','2018-1-1',4),
('老C','123456',1,'15555555555','130111111111111113','河北','12345678@qq.com','1999-9-9','2018-1-1',4),
('老D','123456',1,'15555555555','130111111111111114','河北','12345678@qq.com','1999-9-9','2018-1-1',4),
('老E','123456',1,'15555555555','130111111111111115','河北','12345678@qq.com','1999-9-9','2018-1-1',4)
--主键ID-试题标题-试题类型--试卷难度-教材编号-章节编号-是否审核-录题人编号-录题时间-审核人编号-审核时间-解析


insert into Question values
--java1
('在Java中，运行下列语句，则程序的输出结果是（ ）。public class Hello{

public static void main(String a[]) {

System.out.println("Hello");

System.out.print("欢迎来到\n");

System.out.println("北大青鸟!");

}

}
',0,1,1,1,1,4,'2018-9-20',5,'2018-9-22','这个题考查的是java中的转义字符的用法，\n代表换行符，\t代表是是制表符。'),
--java2
('在Java中，已有StringBuffer str=new StringBuffer(),使str的内容为”hello”的语句是（ ）。  (选择一项)',0,1,1,12,1,4,'2018-9-20',5,'2018-9-22','StringBuffer是字符串增强类,在结尾处追加字符串使用append()方法'),
--java3
('给定如下Java代码片段，编译运行后，输出结果是（ ）。（ 选择一项）

Strings="ABCDE";

System.out.print(s.substring(3).concat("FGH"));',0,1,1,12,1,4,'2018-8-20',5,'2018-9-22','substring(int startIndex)参数代表起始下标,截取到字符串末尾 concat()作用是字符串拼接'),

--java4
('在Java中，如下代码的输出结果是（）。

public static void main(String[] args) {

      String str1 = new String("Java");

      String str2 = new String("java ");

      System.out.println(str1== str2);

      System.out.println(str1.equals(str2));

      System.out.println(str1.equalsIgnoreCase(str2));

      System.out.println(str1.equalsIgnoreCase(str2.trim()));

}  (选择一项)
',0,1,1,12,1,4,'2018-9-20',5,'2018-9-22','str2字符串值中包含字符串,==比较两字符串内存地址,.equals()方法比较字符串内容,equalsIgnoreCase()方法忽略大小写比较字符串内容'),
--java5
('在Java中，以下程序的运行结果是（）。（选择一项）


public class Main {

       public static void main(String[] args) {

              String str="test";

              chang(str);

              System.out.println(str);

       }

       public static void chang(String str){

              str+="<<";

              str+=">>";

       }

}',0,1,1,10,1,4,'2018-8-20',5,'2018-9-22','在方法中修改的字符串对于输出结果不受影响'),
--java6
('在Java中，使用MyElipse开发简单的Java程序的步骤是（）。
1、运行.class文件  2、编写.java源文件  3、编译.java源文件为.class文件  4、新建项目  (选择一项)',0,1,1,1,1,4,'2018-8-20',5,'2018-9-22','
在Java中，使用MyElipse开发简单的Java程序的步骤是:
新建项目->编写.java源文件->编译.java源文件为.class文件->运行.class文件'),
--java7
('运行以下Java代码程序后，变量str2的内容是（）。

String str1 = new String("Accp");

String str2 = new String("Benet");

str2 = str1.toUpperCase().concat(str2);

str2 = str2.substring(2,5);  (选择一项)',0,1,1,12,1,4,'2018-9-20',5,'2018-9-22','toUpperCase()字符串转换成大写concat(()在字符串结尾追加字符串
substring(int startIndex,int length)截取字符串,从startIndex下标开始,截取到length长度'),
--java8
('在Java中，使用StringBuffer可以实现字符串的追加，则下面代码片段的运行结果是（）。
StringBuffer strBuffer=new StringBuffer();
strBuffer.append("中国");
strBuffer.insert(0,"你好");
System.out.println(strBuffer);(选择一项)',0,1,1,12,1,4,'2018-9-20',5,'2018-9-22','append()在字符串结尾处追加

insert()在指定下标处追加字符串,之后字符串向后移动一位
'),
--java9
('分析以下Java代码程序，该段代码程序的运行结果是（）。
public class HelloAccp {
      public static void main(String[] args){
            String HELLO;
            System.out.print(HELLO);
            System.out.print("ACCP!");
      }
}  (选择一项)',0,1,1,2,1,4,'2018-9-20',5,'2018-9-22','变量都必须声明和赋值后才能使用，代码中变量HELLO没有赋值'),

--java10
('在JAVA中，以下正确的变量名是（）。（选择一项）',0,1,1,2,1,4,'2018-9-20',5,'2018-9-22','变量名的命名规则：可以包含字母、数字、下划线、$ ；并且不能以数字开头；不能使用Java关键字

A.int是Java关键字 B.以数字开头  D包含了除下划线、$符号之外的符号.'),

--java11
('在Java中，Arrays类中的（）方法是将数组中的元素按照从小到大的顺序进行排序。  (选择一项)',0,1,1,7,1,4,'2018-9-20',5,'2018-9-22','对数组进行顺序排列使用的是Arrays类的sort()方法'),

--java12
('下面Java程序的运行结果是（）。

int[]arr=new int[]{0,1,2,3};

for(int i=arr[0];i<=arr[3];i++){

   System.out.print(arr[i]);

}  (选择一项)',0,1,1,7,1,4,'2018-9-20',5,'2018-9-22','arr[0]的值为0，arr[3]的值为3，所以循环是从0开始，到3结束，正好遍历数组中的全部数据'),

--java13
('表达式(11+3*8)/4%3的值是()(选择一项)',0,1,1,2,1,4,'2018-9-20',5,'2018-9-22','()的优先级最高，(11+3*8)/4%3=35/4%3=8%3 取余=2'),

--java14
('阅读下面Java代码片段，正确的输出结果是（ ）。
int score=178;
if(score>160)
System.out.println("送20积分");
else
System.out.println("送一只小熊");
if(score>170)
System.out.println("送30积分");
if(score>180)
System.out.println("送50积分");',0,1,1,3,1,4,'2018-9-20',5,'2018-9-22','if选择结构，当if（条件）为true时，则执行大括号{}里的代码，score=178，满足以下两个条件
 if(score>160)
System.out.println("送20积分");
if(score>170)
System.out.println("送30积分");'),

--java15
('分析下面的Java代码，则程序运行输出显示正确的是（）。（选择一项）

int i = 10/3;

switch(i){

      case1: System.out.print("case1");

            break;

      case2: System.out.print("case2");

      case3: System.out.print("case3");

      case4: System.out.print("case4");

            break;

      case5: System.out.print("case5");

      default:System.out.print("default");

}  (选择一项)',0,1,1,4,1,4,'2018-9-20',5,'2018-9-22','int i = 10/3;求商为：3

执行case3：输出case3，没有break，继续执行case4后的代码，输出case4'),
  --java16
(' 下列关于多重if选择结构的说法正确的是（）。',0,1,1,3,1,4,'2018-9-20',5,'2018-9-22','多个else if块之间的顺序可以改变，改变之后可能对程序的执行结果有影响。'),
  --java17
('下列关于if选择结构和switch选择结构的说法正确的是（）。',1,1,1,4,1,4,'2018-9-20',5,'2018-9-22','多重if选择结构中的else语句可选，switch选择结构中default语句可选'),
--WinForm 1
('在C#程序中已经创建了DataSet ds和DataAdapter da ，现要将数据库中Users表的数据放在ds中的MyUsers数据表中，下面语句正确的是（  ）。  (选择一项)',0,2,4,34,1,2,'2018-9-26',5,'2018-9-28','Fill(DataSet ds，String tbl_name) 第二个参数为自定义的临时数据库中的表名'),
--WinForm 2
('以下关于C#中DataGridView控件的说法中正确的是（ ）。  (选择一项)',0,2,4,35,1,2,'2018-9-26',5,'2018-9-28',' 因为主键会作为更改条件，因此，没有主键列则不能对数据执行更新操作'),
--WinForm 3
('在C#中，关于DataGridView的使用，说法正确的是（）。  (选择二项)',1,2,4,34,1,2,'2018-9-26',5,'2018-9-28',' A选项错误：DataGridView控件的DataSource可以是某个DataTable对象或者DataView对象等。 B选项错误：ReadOnly属性是boo类型'),
--WinForm 4
('在C#中，用SqlDataAdapter和DataSet从teacher表中读取数据，假定conn是一个可用的数据库连接，阅读以下代码：

DataSet dss = new DataSet( );     //①

SqlDataAdapter dap = new SqlDataAdapter("select * fromteacher", conn);// ②

conn.Open();//③

dap.Fill(dss，"myTeacher");//④

则关于这段代码，说法正确的是（）。  (选择一项)
',0,2,4,33,1,2,'2018-9-26',5,'2018-9-28','DataAdapter可以自己管理连接的开关，所以③不是必须的

填充数据时，表名可以自定义，不需要和数据源保持一致'),
--WinForm 5
('在WinForms中，编写代码为ComboBox控件绑定数据时不需要（ ）。 (选择一项)',0,2,4,31,1,2,'2018-9-26',5,'2018-9-28','DataSource属性设置数据源

DisplayMember属性设置显示列

ValueMember属性设置值列'),
--WinForm 6
('在WinForms中，tv为TreeView控件，则通过（ ）属性可以获取TreeView中当前选中节点的文本。  (选择二项)',1,2,4,34,1,2,'2018-9-26',5,'2018-9-28','获取选中节点为：SelectedNode属性

获取节点文本为：Text属性
'),
--WinForm 7
('在TreeView控件的每个节点前添加一个图标，应该设置（）属性。',0,2,4,34,1,4,'2018-9-26',5,'2018-9-28','只要给树控件绑定图片列表集合，树控件前的节点就默认显示第一个小图标了'),
--WinForm 8
('在WinForms中,一下代码实现了使用DataView对象删选学生信息,并根据学生姓名牲畜排列.其中,"Student"为学生信息表,"StudentName"为 学生姓名.则存在错误的代码行是( ).

DataSet ds = new DataSet(); //1

DataView dv = new DataView(ds.Tables["Student"]); //2

dv.Filter = "StudentName like "王%""; //3

dv.Sort = "order by StudentName desc"; //4(选择一项)',0,2,4,34,1,4,'2018-9-26',5,'2018-9-28','过滤条件属性为：RowFilter

排序属性设置时不用写 order by'),
--WinForm 9
('在WinForms应用程序中,如果CheckBox控件的Checked属性值设置为True,则程序运行后().(选择一项)',0,2,4,33,1,4,'2018-9-26',5,'2018-9-28','CheckBox中的Checked属性为设置或获取多选按钮的选中状态,设置为True时则是选中的状态'),
--WinForm 10
('MenuStrip控件中显示为一个按钮选择项的是()类型的.(选择一项)',0,2,4,31,1,4,'2018-9-26',5,'2018-9-28','MenuStrip中的按钮选择项为ToolStripMenuItem,'),
--WinForm 11
('private void btnOK_Click(object sender, EventArgs e)

{

      FrmList frmList =new FrmList ();

      frmList.MdiParent =this;

      frmList.ShowDialog();

}

则可能（） (选择一项)
',0,2,4,31,1,4,'2018-9-26',5,'2018-9-28','在使用MDI窗体时,可以以普通的窗口形式进行显示,设置为模式化窗口时会引发异常'),
--WinForm 12

('在WinForms中，下列关于菜单栏控件MenuStrip的属性和事件说法错误的是（ ）  (选择一项)',0,2,4,31,1,4,'2018-9-26',5,'2018-9-28','Modifiers属性为设置控件的访问作用域,'),
--WinForm 13
('在WinForms中，运行如下代码能够实现点击“大图片”按钮（Name属性值为btnLarge）和“小图片”按钮（Name属性值为btnSmall），大小图片切换显示，其中lvImage为ListView的Name属性值，那么横线处依次正确填写的代码是（ ）。
private void btnLarge_Click(object sender, EventArgs e)
{
    lvImage.View = _____________;
}
private void btnSmall_Click(object sender, EventArgs e)
{
    lvImage.View = _____________;
}',0,2,4,31,1,2,'2018-10-5',5,'2018-9-28','根据按钮名称来确定填写的代码,btnLarge_Click对应View.LargeIcon而btnSmall_Click对应View.SmallIcon'),
--WinForm 14
('以下（）不是WinForm中ListView控件View属性的有效值。（选择一项）',0,2,4,32,1,2,'2018-10-5',5,'2018-9-28','ListView中具有LargeIcon,SmallIcon,List,Details,Tile五中,分别是大图标,小图标,列表,详细与平铺'),
--WinForm 15
('下面关于ListView控件的描述，正确的是（）。',0,2,4,32,1,2,'2018-10-5',5,'2018-9-28','在ListView中添加数据需要使用Items属性对应添加ListViewItem对象'),
--WinForm 16
('下列关于控件ListView 的属性的描述错误的是()。(选择一项)',0,2,4,32,1,2,'2018-10-5',5,'2018-9-28','Columns属性为设置在详细信息视图中显示的列'),
--WinForm 17
('在WinForms中，关于Timer（计时器）控件的属性和事件，说法错误的是（ ）。  (选择一项)',0,2,4,31,1,2,'2018-10-5',5,'2018-9-28','Stop()方法可以停止计时器,但是并不会使其无法在次启动'),
--WinForm 18
('在C#中，关于枚举的正确描述是（      ）。  (选择二项)',1,2,4,32,1,2,'2018-10-5',5,'2018-9-28','Enum为枚举的关键字,其作用为为一组有限的数字添加明确的定义'),
--WinForm 19
('在WinForms中，执行TextBox控件的（）方法能使其获得焦点。  (选择一项)',0,2,4,30,1,2,'2018-10-5',5,'2018-9-28',' 在WinForms中，执行TextBox控件的 Focus() 方法能使其获得焦点'),
--WinForm 20
('Timer控件的Interval属性可以设置定时发生事件的间隔，它的单位是（）。',0,2,4,32,1,2,'2018-10-5',5,'2018-9-28',' Timer控件的Interval属性可以设置定时发生事件的间隔，它的单位是 毫秒'),

--java 18
('以下说法中正确的是（）。（选择两项）',1,1,1,5,1,5,'2018-10-13',2,'2018-10-14','错误分析

A.当while循环结构的循环条件始终为true，循环体内有break，则会跳出循环

B.程序调试时加入断点不会改变程序的执行流程'),
--java 19
('public class Test {
    public static void main(String[] args) {
        int sum = 0;
        for (int i = 1; i <= 10; i++) {
            sum += i;
            if (i % 2 == 0)
                break;
        }
        System.out.println(sum);
    }
}',0,1,1,6,1,5,'2018-10-13',2,'2018-10-14','for循环

i=1 

sum+=i;//sum值为1

i++ 为2 进入循环体，sum+=i;//sum=3

if (i % 2 == 0)
    break;//跳出循环

最后输出的sum值为 3
'),
--java 20
('在Java 中，关于程序调试说法正确的是（）。(选择一项)',0,1,1,5,1,5,'2018-10-13',2,'2018-10-14','使用Eclipse调试的步骤顺序为:设置断点、启动调试、单步执行、分析错误

设置断点不会自动修改错误'),
--java 21
('在Java中，（）关键字用来退出循环，将控制权转给程序的其他部分。',0,1,1,6,1,5,'2018-10-13',2,'2018-10-14','在Java中，break 关键字用来退出循环'),
--java 22
('在使用MyEclipse进行代码调试时，在调试视图中，按F5和F6键都是单步执行，它们的区别是（ ）。',0,1,1,5,1,5,'2018-10-13',2,'2018-10-14','F5是“单步跳入”，会进入本行代码内部执行;F6是“单步跳过”，仅执行本行代码'),
--java 23
('（）表达式不可以作为循环条件。',0,1,1,5,1,5,'2018-10-13',2,'2018-10-14','循环条件，是一个表达式，并且表达式的值必须为true或false

等值判断，用双等号=='),
--java 24
('阅读下列Java代码片段，则输出结果是（ ）。
int sum = 0;
for (int i = 10, j = ++i; i < j; i -= 2, j += 2) {
sum += i + j;
}
System.out.println(sum);',0,1,1,6,1,5,'2018-10-13',2,'2018-10-14','for (int i = 10, j = ++i; i < j; i -= 2, j += 2) 

j=++i,则 i=11 j=11

不满足i'),
--java 25
('以下Java代码的输出结果为（ ）。
int num=1;
while(num<10){
System.out.print(num);
if(num>5)
break;
num+=2;
}
',0,1,1,5,1,5,'2018-10-13',2,'2018-10-14','第一次输出1，num+=2，

第2次循环输出3，num+=2

第3次循环输出5，num+=2

第4次循环输出7，if（7>5）break,跳出循环

所以最终输出的结尾为：1357'),
--java 26
('下面Java代码的输出结果是（ ）。
int sum = 0;
for (int i = 1; i < 30; i++) {
if (i % 3 == 0) {
sum += i;
} else if (sum > 30) {
break;
}
}
System.out.println(sum);',0,1,1,6,1,5,'2018-10-13',2,'2018-10-14','i的值为3的倍数时，执行sum += i;

i分别为：3、6、 9、 12 、15

此时sum值为45，满足sum>30 break退出循环，输出45'),
--java 27
('运行如下Java代码片段，则输出结果为（ ）。

public static void main(String[] args) {
        int k = 10;
        int j = 0;
        for (int i = 9; i > 0; --i) {
            if (i % 3 == 0) {
                k--;
                continue;
            }
            j++;
        }
        System.out.println(k + "," + j);
    }',0,1,1,6,1,5,'2018-10-13',2,'2018-10-14','分析：

       i=9    第1次循环：执行k--     //k=9
--i    i=8    第2次循环：执行j++    //j=1 
--i    i=7    第3次循环：执行j++    //j=2 
--i    i=6    第4次循环：执行k--     //k=8
--i    i=5    第5次循环：执行j++    //j=3
--i    i=4    第6次循环：执行j++    //j=4
--i    i=3    第7次循环：执行k--     //k=7
--i    i=2    第8次循环：执行j++    //j=5
--i    i=1    第9次循环：执行j++    //j=6
--i    i=0 不满足循环条件，退出循环，输出的结果为 7，6'),
--java 28
('关于定义数组定义不正确的是.(  )(选择一项)',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14','选线D的代码应该连贯书写，改为int[] numbers = {1,2,3,4,5,6};'),
--java 29
('下面代码的运行结果是（）(选择一项)

public class Test{

    public static void main(String[] args){

        int[] a = new int[3];

        int[]  b = new int[]{1,2,3,4,5};   

        a= b;

        for(int i=0;i

            System.out.print(a[i] + " ");

        }

    }
}',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14','a= b; 句代码，a引用了数组b的地址，所以这句代码之后a数组中的值为1,2,3,4,5'),
--java 30
('阅读下列Java代码，其输出结果为（ ）。
int rows=4;
for(int i=1;i<=rows;i++){
for(int j=1;j<=rows+1-i;j++){
System.out.print("*");
}
System.out.println();
}',0,1,1,8,1,5,'2018-10-13',2,'2018-10-14','利用二重循环打印三角形，外层循环控制行数，内层循环控制列数。'),
--java 31
('若想打印如下图案，下面代码规划处应依次填入（）。

*

**

***

****
int  j =0;
for(int i=1;i<=__ ;i++){
    j=1;
    while(j<=__){
        System.out.print("*");
        j++;
    }
   System.out.print("\n");
}',0,1,1,8,1,5,'2018-10-13',2,'2018-10-14','利用二重循环打印三角形，外层循环控制行数，内层循环控制列数'),
--java 32
('下列选项中关于Java类的理解错误的是（ ）。  (选择一项)',0,1,1,9,1,5,'2018-10-13',2,'2018-10-14','类中的属性和方法是从共性中抽象出来的，所以类的属性可以被赋初始值，类的方法可以有具体实现'),
--java 33
('在Java中，面向对象的优点说法错误的是（ ）。  (选择一项)',0,1,1,9,1,5,'2018-10-13',2,'2018-10-14','面向对象的优点：与人类的思维习惯一致；提高了程序的可重用性；信息隐藏，提高了程序的可维护性和安全性。'),
--java 34
('Java 类可以作为（）（选择一项）',0,1,1,9,1,5,'2018-10-13',2,'2018-10-14','java中对类的理解包含类型的定义和数据的封装'),
--java 35
('在Java中,下列关于参数的方法说法正确的是( ).   (选择一项)',0,1,1,11,1,5,'2018-10-13',2,'2018-10-14','方法返回值的数据类型不一定要和参数的数据类型一致， 当方法有多个参数时,没有要求多个参数的数据类型必须一致，方法的参数可以为引用数据类型'),
--java 36
('声明方法时，如果有参数，则必须写在方法名后面的小括号内，并且必须指明它的类型和名称，若有多个参数，需要用()隔开.(选择一项)',0,1,1,11,1,5,'2018-10-13',2,'2018-10-14','定义有参方法的语法，定义多个参数必须要用逗号隔开。'),
--java 37
('阅读下列Java代码片段，输出结果正确的是（ ）。
String str="I`m very happy.";
System.out.println("这条语句的长度是："+str.length());',0,1,1,12,1,5,'2018-10-13',2,'2018-10-14','标点符号和特殊符号也会占位置，所以长度为15'),
--java 38
('下列选项中的Java代码错误的是（ ）。  (选择一项)',0,1,1,12,1,5,'2018-10-13',2,'2018-10-14','创建StringBuffer对象必须使用new关键字 例：StringBuffer sb = new StringBuffer("初始字符串的值");'),
--java 39
('阅读下面代码，它完成的功能是（）。
String [] a={"我们","你好","小河边","我们","读书"};
        for(int i=0;i<a.length;i++){
            if(a[i].equals("我们")){
                a[i]="他们";
            }
        }',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14','循环数组，if(a[i].equals("我们")) 查找数组元素中，值为“我们”，a[i]="他们" 替换值'),
--java 40
('以下代码的执行结果是（）。
String [] words = {"Sun","Moon","Earth","Star","Super"};
         Arrays.sort(words);
         for (int i = 0; i < words.length; i++) {
         System.out.print(words[i]+"\t");
         }',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14','Arrays.sort(words);String类型的数组升序排序'),
--java 41
('下列数组的初始化正确的是（）。（选择两项）',1,1,1,7,1,5,'2018-10-13',2,'2018-10-14','B.声明数组并分配空间  D.声明数组并赋值,则不能规定长度'),
--java 42
('定义一个数组 String [] cities={"北京","上海","天津","重庆","武汉","广州","香港"},数组中的cities[7]指的是（）。',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14','数组中的cities[7]指的是数组越界，数组长度是7，最后一个元素下标为6'),
--java 43
('下列选项说法正确的是：（）（请选择一项）。
                int [] numbers = new int[5];
                numbers[0]=80;
		numbers[1]=70;
		numbers[2]=90;
		numbers[3]=80;
		numbers[4]=100;
                numbers[5]=80; 
                System.out.println(numbers[5]);',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14','int [] numbers = new int[5];声明并分配空间，数组长度为5，下标从0-4

  numbers[5]=80; 数组越界：java.lang.ArrayIndexOutOfBoundsException:'),
  --java 44
 ('数组的使用步骤是（）。选择一项',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14','数组的使用步骤是：声明数组-->分配空间-->赋值-->处理数据'),
   --java 45
 ('想要打印出以下代码，横线处应依次填入（）。

1  

1  2  

1  2  3  

1  2  3  4  

1  2  3  4  5



for(int i=1;i<=5;i++){

	for(int j=1;j<=___;j++){

	System.out.print(___ +"  ");

	}

	System.out.println();

}',0,1,1,8,1,5,'2018-10-13',2,'2018-10-14','内层循环中，每行j的值不大于i   j<=i '),
   --java 46
 ('二重循环中 continue 和 break 语句的对比，当 continue 和break 语句用在内层循环，下列说法不正确的是（）。',0,1,1,8,1,5,'2018-10-13',2,'2018-10-14','当break用在内层循环时，是跳出本层循环，即 提前结束本层循环。'),
   --java 47
 ('下面关于类和对象的说法正确的是（）。',0,1,1,9,1,5,'2018-10-13',2,'2018-10-14','创建类的对象：使用关键字new;   使用类的属性和方法：使用“.”操作符'),
   --java 48
 ('关于类和对象的说法错误的是（）。',0,1,1,9,1,5,'2018-10-13',2,'2018-10-14',' 选项C错误：因为一个类的对象可以有一个或多个'),
   --java 49
 ('关于类和对象的关系，说法错误的是（）。',0,1,1,9,1,5,'2018-10-13',2,'2018-10-14','选项D 类是对象抽取而成，对象是类的具体表现'),
   --java 50
 ('使用类的步骤，说法错误的是（）。',0,1,1,9,1,5,'2018-10-13',2,'2018-10-14','D选项：定义类：使用关键字class
定义类名-->编写类的属性-->编写类的方法'),
   --java 51
 ('在Java中，关于在类中导入包的理解错误的是（ ）。',0,1,1,11,1,5,'2018-10-13',2,'2018-10-14','D选项错误：导入包的语句要卸载类定义之前'),
   --java 52
 ('在Java中，包有多种用途，但不包含（）。',0,1,1,11,1,5,'2018-10-13',2,'2018-10-14','选项C：有助于提高运行效率，不是包的用途'),
   --java 53
 ('关于类的描述正确的是（）。选择两项',1,1,1,9,1,5,'2018-10-13',2,'2018-10-14','选项A 成员变量，其他类要先new对象，然后使用"."操作符来使用变量；
选项C 不同类的方法，首先创建对象，然后通过 对象名.方法名() 来调用'),
   --java 54
 ('以下关于Java的包说法错误的是（）。',0,1,1,11,1,5,'2018-10-13',2,'2018-10-14','选项C错误：不同的包中可以出现类名相同的类'),
   --java 55
 ('在Java中，以下程序的输出结果是（）。

int num1=9;

double num2=1;

num1=num2;
System.out.println(num1);  (选择一项)',0,1,1,2,1,5,'2018-10-13',2,'2018-10-14','num1=num2; 从double类型转换为int类型，需要强制类型转换'),
   --java 56
 ('在Java中，以下赋值语句正确的是（ ）。',1,1,1,2,1,5,'2018-10-13',2,'2018-10-14','A.字符串类型不可以转换成int类型 B.double类型需要强制类型转换再赋值给int类型的变量'),
   --java 57
 ('下列语句中,()正确完成了整型变量的声明和赋值(选择二项)',1,1,1,2,1,5,'2018-10-13',2,'2018-10-14','A.变量不可以同名 C变量的声明：数据类型 变量名'),
   --java 58
 ('下面的代码段中，执行之后i 和j 的值是什么? (    ) （选择一项）
 int i = 1;
 int j; 
 j = i++ * 2 + 3 * --i;',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14',' i++表示先参与表达式运算后自增1，--i表示先自减1后再参与表达式运算'),
   --java 59
 ('在Java中，对于带参数的方法描述不正确的是（ ）',0,1,1,11,1,5,'2018-10-13',2,'2018-10-14',' 在Java中，对于带参数的方法，除了基本数据类型，其他类型也可以作为参数'),
   --java 60
 ('编译一个Java源文件后，会产生字节码文件，其扩展名是（）',0,1,1,1,1,5,'2018-10-13',2,'2018-10-14','Java源文件的扩展名是.java，编译后的节字码文件的扩展名是.class'),
   --java 61
 ('下列有关Java语言的叙述中，正确的是（）（选择一项）',0,1,1,1,1,5,'2018-10-13',2,'2018-10-14','Java中public类型的类型名必须与Java源文件的文件名完全相同'),
   --java 62
 ('下列赋值语句中错误的是（）（选择一项）',0,1,1,10,1,5,'2018-10-13',2,'2018-10-14','byte类型的数据，取值范围是-128到127之间'),
   --java 63
 ('在Java中，如果运行下列代码，则运行结果为（   ）
public class Test{
      public static void swap(int num1,int num2){
              int temp=num1;
             num1=num2;
             num2=temp;
    }
     public static void main(String[] args){
          int n1=20,n2=30;
         swap(n1,n2)
          System.out.println(n1+","+n2);
    }
}',0,1,1,11,1,5,'2018-10-13',2,'2018-10-14','调用 swap(int num1,int num2)进行值传递，并不会改变n1、n2的值'),
   --java 64
 ('在Java中，下列代码输出结果为（  ）
public class Test{
    public String method (int i, String[] s){
         return s[i];
   }
   public static void main(String[] args){
       String[ ] s=new String[ ]{ "奔驰","奥迪","大众","夏利"};
      Test   test=new Test( );
       System.out.println(test.method(3,s));
   }
}',0,1,1,11,1,5,'2018-10-13',2,'2018-10-14','调用method (int i, String[] s) 输出数组  String[ ] s=new String[ ]{ "奔驰","奥迪","大众","夏利"}; 下标为3的元素，即：夏利'),
   --java 65
 ('阅读下面Java代码片段，则正确的输出结果是（）。
public static void main(String[] args){
  char ch=’A’;
  switch(ch+1){
     case 65:
       System.out.println(“A”);
     case 66:
       System.out.println(“B”);
     case 67:
       System.out.println(“C”);
       break:
     default:
       System.out.println(“无匹配”);
       Break;
}
}（选择一项）',0,1,1,4,1,5,'2018-10-13',2,'2018-10-14','答案解析: ch+1=66  找到匹配，输出B，没有break，接着输出C '),
   --java 66
 ('在Java 中,下列说法错误的是() 。(选择一项)',0,1,1,2,1,5,'2018-10-13',2,'2018-10-14','Java 基本数据类型有int 、char  等 ，、String是引用数据类型'),
   --java 67
 ('执行以下代码执行结果是（）

        public class Test {

                public static void main(String[] args) {

                        String s = "abc";

                        s.substring(1);

                        s.replace("bc", "xyz");

                       System.out.println(s); 

                       String value = new String ("abc");

                       System.out.println(s == value);

                }

       }

（选择一项）',0,1,1,12,1,5,'2018-10-13',2,'2018-10-14','String类的substring()方法和replace()方法都需要返回值接收，所以输出的字符串不会变化。

使用new String()方式创建的字符串与原字符串不是同一个对象，所以用"=="判断结果为false'),
   --java 68
 ('以下说法正确的是：（）（选择一项）',0,1,1,1,1,5,'2018-10-13',2,'2018-10-14','package声明包的语句必须放在java源文件中代码的第一行。Java源文件中的类名必须与源文件的文件名相同'),
   --java 69
 ('在Java中，使用StringBuffer可以实现字符串的追加，则下面代码片段的运行结果是（）。

StringBuffer strBuffer=new StringBuffer();

strBuffer.append(“中国”);

strBuffer.insert(0,“你好”);

System.out.println(strBuffer);(选择一项)',0,1,1,12,1,5,'2018-10-13',2,'2018-10-14','StringBuffer的append()为追加，insert是插入'),
   --java 70
 ('在Java程序中，以下初始化数组的语句中错误的是（）。（选择一项）',0,1,1,7,1,5,'2018-10-13',2,'2018-10-14','错误的是A，数组在声明的同时赋值，不可以同时制定元素的值和长度'),
 --C# 1
('在SQL Server中，有一张新闻表news，新闻发布时间为字段begintime，现要查询最近一个月内发表的新闻的信息，则以下SQL语句正确的是（ ）。',0,2,3,25,1,4,'2018-10-5',2,'2018-10-14','

dateAdd（类型，值，日期）  类型可取：dd、mm、yy、day、month、year

daatediff（） 用于计算日期之间的差'),
--C# 2
('在SQL Server  中，通配符通常与LIKE关键字一起配合使用，以下通配符中(  )表示在括号中指定范围内的一个字符。',0,2,3,24,1,5,'2018-10-6',2,'2018-10-14','

[ ] 中括号表示在一定范围内,[^ ] 表示不在某个范围内'),
--C# 3
('在T-SQL中，关于通配符“%”的说法正确的是（）。',0,2,3,24,1,5,'2018-10-6',2,'2018-10-14','
该题属于基本概念，记住就可以了！ 没有为什么'),
--C# 4
('在SQL Server中，可以用于统计表中记录之和的函数是（）。',0,2,3,26,1,5,'2018-10-6',2,'2018-10-14','

五个聚合函数：  sum 求和  ，count 行数， avg 平均  ， max  最大值， min 最小值'),
--C# 5
('在C#中，要使如下代码正确运行，则①②上应该分别填写（）。

_①__static int getResult(int left, ref int right)

{

    right = left +right;  

    return right;

}

static void Main(string[] args)

{

    int para = 6;

    int result =getResult(5, _②__);

}  (选择二项)',1,2,3,20,1,2,'2018-10-6',2,'2018-10-14','

引用传参，形参和实参前都必须加ref关键字'),
--C# 6
('在以下T-SQL语句中，Students 是学生表，该表中SGrade是年级字段，执行以下T-SQL语句则（ ）。
SELECT COUNT(*),SGrade FROM Students
GROUP BY  SGrade
HAVING  COUNT(*)>100',0,2,3,25,1,2,'2018-10-7',2,'2018-10-14','SELECT COUNT(*),SGrade FROM Students
GROUP BY  SGrade

可以得到 各年级的人数

而 having语句则是在上面运行结果基础上再筛选人数大于100的记录'),
--C# 7
('在WinForm应用程序开发中，在MySchool数据库中，假设年级表Grade中有3条记录，编译并执行下面的代码后将得到的结果是（）。

private void ExecuteScalar()

{

    string connString="Data Source=.;Initial Catalog=MySchool;User ID=sa;pwd=bdqn";

    SqlConnection conn =new SqlConnection(connString);

    string sql = "SELECT COUNT(*) FROM Grade ";

    SqlCommand command =new SqlCommand(sql, conn);

   command.Connection.Open();

    int num =command.ExecuteScalar();

   Console.WriteLine(num);

}',0,2,3,26,1,5,'2018-10-7',2,'2018-10-14','command.ExecuteScalar()的返回结果是object类型，需要类型转换才能得到相应的整型结果'),
--C# 8
('下面是一段ADO.NET 操作数据的代码，下列说法正确的是（ ）。

//…省略代码

SqlDataReaderreader = cmd.ExecuteReader();//cmd为有效的SqlCommand对象

while(reader.Read())

{

    string name =(string)reader["name"];

}

cmd.CommandText= newSql;              // newSql 为定义好的SQL 语句

SqlDataReadernewReader = cmd.ExecuteReader(); 

//…省略代码',1,2,3,29,1,5,'2018-10-7',2,'2018-10-14','SqlDataReader对象是独占链接的，在关闭之前不允许再执行其他数据库操作，所以会在运行的二次ExecuteReader（）时报错，应该在执行第二处cmd.ExecuteReader()之前先关闭reader对象'),
--C# 9
('在SQL Server 中，执行如下SQL语句：

SELECT * FROM Item As a Left join OrderDetails As b On a.Icode=b.ItemCode,将返回（              ）。',0,2,3,27,1,5,'2018-10-7',2,'2018-10-14','这属于外连接的基本用法，如果不明确请当面咨询老师'),
--C# 10
('在SQL Server中，可以得到和以下语句相同查询结果的查询语句是（  ）

Select Students.SName,Score.CourseId,Score.Score

From  Students, Score

where Students.Scode=Score.StudentId',1,2,3,29,1,5,'2018-10-7',2,'2018-10-14','内链接查询的结果是两张表的相关数据，而外连接不符合'),
--HTML 1
('在HTML中，下面（ ）可以设置有序列表的排列顺序为数字。（选择二项）',1,1,2,16,1,2,'2018-10-10',4,'2018-10-14','有序列表默认显示就是使用数字编号,手动指定则设置type="1"'),
--HTML 2
('下列对列表的分类正确的是（ ）。  (选择一项)',0,1,2,14,1,2,'2018-10-10',4,'2018-10-14','ul是无序列表

ol是有序列表

dl是定义列表

'),
--HTML 3
('在HTML中，以下设置复选框默认为选中状态的是（ ）。  (选择一项)',0,1,2,15,1,2,'2018-10-10',4,'2018-10-14','单选框和复选框的默认选中状态都是checked="checked"'),
--HTML 4
('在html中，要实现点击"男"，选中下列代码的单选按钮, 男， 下列做法正确的是（ ）。  (选择一项)',0,1,2,15,1,2,'2018-10-10',4,'2018-10-14','通过for属性添加表单元素的注释性文字,点击文字可以实现单选按钮的选中'),
--HTML 5
('以下关于DIV+CSS布局的说法正确的是（）。(选择一项)',0,1,2,13,1,2,'2018-10-10',4,'2018-10-14','DIV+CSS布局,具有简洁高效、内容样式分离并且利于改版等特点,这是使用CSS的优势'),
--HTML 6
('以下关于标准文档流的说法正确的是（ ）。',0,1,2,15,1,2,'2018-10-10',4,'2018-10-14','A.标签是内联元素

B.
...
是块级元素
C.
是块级元素，是内联元素，块级元素不能包含在内联元素里
,'),
--HTML 7
('在CSS中，为页面中的某个DIV标签设置以下样式，则该标签的实际宽度为（    ）。

div { width:200px;padding:0 20px; border:6px; }',0,1,2,16,1,2,'2018-10-10',4,'2018-10-14','盒子模型计算公式:margin+padding+border-width+content,其中外边距盒内边距需要分别计算左右'),
--HTML 8
('在CSS中,下面()能够用来设置一个<div>的边框',0,1,2,16,1,2,'2018-10-10',4,'2018-10-14','width(元素宽度),border(边框),margin(外边距),padding(内边距)'),
--HTML 9
('在CSS3中，关于transition-duration 和 transition-delay属性的说法错误的是（）。',0,1,2,17,1,2,'2018-10-10',4,'2018-10-14','AB两项对属性作用的描述是正确的，所以D不正确'),
--HTML 10
('在CSS中，声明关键帧让不同浏览器兼容的写法中错误的是（）',0,1,2,17,1,2,'2018-10-10',4,'2018-10-14','写兼容的时候浏览器前缀是放在@keyframes中间，例如，@-webkit-keyframes、@-moz-keyframes等。

千万不要以为前缀是放在@keyframes前面的')
  insert into Answer
  values
--java1
  ('Hello
欢迎来到北大青鸟!',1,0),
  ('Hello

欢迎来到

北大青鸟!',1,1),
  ('Hello

欢迎来到\n北大青鸟!',1,0),
  ('编译时出错',1,0),
--java2
  ('str.append("hello");',2,1),
  ('str = "hello";',2,0),
  ('str=str.concat("hello")',2,0),
  ('str.concat("hello")',2,0),
  --java3
  ('CDEFGH',3,0),
  ('DEFGH',3,1),
  ('FGH',3,0),
  ('ABCDE',3,0),
  --java4
  ('false

false

false

true',4,1),
  ('true

false

false

true',4,0),
  ('false

false

false

false',4,0),
  ('false

false

true

true',4,0),
  --java5
('<< test>>',5,0),
('test<<>>',5,0),
('test',5,1),
('str',5,0),
  --java6
('1、2、3、4',6,0),
('2、3、4、1',6,0),
('1、2、4、3',6,0),
('4、2、3、1',6,1),
  --java7
('ccp',7,0),
('cCP',7,0),
('CPB',7,1),
('cpB',7,0),
  --java8
('中国',8,0),
('你好',8,0),
('你好中国',8,1),
('中国你好',8,0),
  --java9
('HELLO!
ACCP!',9,0),
('变量使用前未赋值，存在编译错误',9,1),
('main()方法修饰符错误，无法通过编译',9,0),
('HELLO! ACCP!',9,0),
  --java10
('int',10,0),
('3number',10,0),
('a_b',10,1),
('a.b',10,0),
  --java11
('length()',11,0),
('sort()',11,1),
('max()',11,0),
('reverse()',11,0),
  --java12
('0123',12,1),
('1234',12,0),
('索引越界',12,0),
('死循环',12,0),
  --java13
('31',13,0),
('0',13,0),
('1',13,0),
('2',13,1),
  --java14
('送20积分',14,0),
('送20积分
送30积分',14,1),
('送20积分
送一只小熊',14,0),
('送50积分',14,0),
  --java15
('case2 case3 case4',15,0),
('case3',15,0),
('case3 case4',15,1),
('case4',15,0),
  --java16
('多个else if块之间的顺序可以改变，改变之后对程序的执行结果没有影响。',16,0),
('多个else if块之间的顺序可以改变，改变之后可能对程序的执行结果有影响。',16,1),
('多个else if块之间的顺序不可以改变，改变后程序编译不通过。',16,0),
('多个else if块之间的顺序不可以改变，改变后程序编译可以通过。',16,0),
  --java17
('if-else选择结构中else语句是必须有的',17,0),
('多重if选择结构中的else语句可选',17,1),
('嵌套if选择结构中不能包含else语句',17,0),
('switch选择结构中default语句可选',17,1),
--WinForm 1
('da.Fill(ds, "Users");',18,0),
('da.Fill(ds, "MyUsers");',18,1),
('da.Fill(ds.Tables["MyUsers"],"Users");',18,0),
('da.Fill(ds);',18,0),
--WinForm 2
('DataSet可以作为DataGirdView的数据源，而DataTable不可以',19,0),
('要将DataGridView中的数据更新到对应的数据表中，则该对应表必须要有主键',19,1),
('DataGridView每列的HeaderText属性用于设置该列绑定的数据列的名称',19,0),
('DataGridView每列的Frozen属性用于设置当DataGridView垂直滚动时，该列是否移动',19,0),
--WinForm 3
('DataGridView控件的DataSource可以是某个DataSet对象。',20,0),
('将DataGridView的ReadOnly属性设置为0，则DataGridView的单元格不可编辑',20,0),
('DataPropertyName表示绑定的数据列的名称',20,1),
('更新DataGridView中的数据，可以借助DataAdapter的Update( )方法',20,1),
--WinForm 4
('③是必须的',21,0),
('④中的第二个参数错误，只能是"teacher"',21,0),
('SqlDataAdapter相当于数据库和DataSet间的数据运输车',21,1),
('上面的说法都不对',21,0),
--WinForm 5
('设置ValueMember属性',22,0),
('设置DisplayMember属性',22,0),
('设置DataSource属性',22,0),
('调用DataBind()方法',22,1),
--WinForm 6
('tv.SelectedNode',23,0),
('tv.Nodes[tv.SelectedNode.Index].Text',23,1),
('tv.SelectedNode.Text',23,1),
('v.SelectedNode.Name',23,0),
--WinForm 7
('ImageList',24,1),
('ImageIndex',24,0),
('SelectedImageIndex',24,0),
('SelectedImage',24,0),
--WinForm 8
('1 和 2',25,0),
('2 和 3',25,0),
('3 和 4',25,1),
('1 和 4 ',25,0),
--WinForm 9
('此CheckBox可见',26,0),
('此CheckBox不被选中',26,0),
('此CheckBox被选中',26,1),
('此CheckBox不被加载',26,0),
--WinForm 10
('ToolStripMenuItem',27,1),
('Item',27,0),
('ToolItem',27,0),
('StripItem',27,0),
--WinForm 11
('编译出错',28,0),
('运行时发生异常',28,1),
('FrmList窗体以FrmMain窗体为MDI父窗体打开',28,0),
('FrmList窗体以模式化窗口打开',28,0),
--WinForm 12
('Name表示代码中菜单对象的名称',29,0),
('Items表示在菜单中显示的项的集合',29,0),
('Text表示与菜单相关联的文本',29,0),
('Modifiers表示在父菜单中显示的项的集合',29,1),
--WinForm 13
('View.LargeIcon
View.SmallIcon',30,1),
('View.Details
View.List',30,0),
('View.SmallIcon
View.LargeIcon',30,0),
('View.Tile
View.List',30,0),
--WinForm 14
('LargeIcon',31,0),
('List',31,0),
('SmallIcon',31,0),
('ListDetails',31,1),
--WinForm 15
('Items的Add()方法用于将项添加到项的集合中',32,1),
('AddRange()方法用于向列表子项集合中添加新的子项',32,0),
('SubItems对应于列表视图项ListViewItem',32,0),
('可以使用DataSource绑定数据源',32,0),
--WinForm 16
('Columns 属性表示" 详细信息"视图中显示的行',33,1),
('MultiSelect 属性表示是否允许选择多项',33,0),
('View 属性用于设置ListVíew 的视图模式',33,0),
('FullRowSelect 属性表示当选中一项时，它的子项是否同该项一起突出显示 ',33,0),
--WinForm 17
('将Interval属性设置为1000，如果该计时器可用，则事件每隔1秒发生一次',34,0),
('将Enabled属性设置为false，则事件不会发生',34,0),
('Timer控件一般用于需要每隔一段时间重复执行代码的情况',34,0),
('Stop()表示停止计时器，停止后无法再启动',34,1),
--WinForm 18
('枚举使用enum关键字定义',35,1),
('枚举表示了一组有限的数值',35,1),
('枚举是引用类型',35,0),
('枚举中可以定义属性和方法',35,0),
--WinForm 19
('Focus();',36,1),
('GetFocus();',36,0),
('In();',36,0),
('MouseIn();',36,0),
--WinForm 20
('秒',37,0),
('毫秒',37,1),
('微秒',37,0),
('分',37,0),
--java 18
('如果while循环结构的循环条件始终为true，则一定会出现死循环',38,0),
('程序调试时加入断点会改变程序的执行流程',38,0),
('do-while循环结构的循环体至少无条件执行一次',38,1),
('while循环结构的循环体有可能一次都不执行',38,1),
--java 19
('1',39,0),
('3',39,1),
('25',39,0),
('55',39,0),
--java 20
('每个程序都必须进行调试工作',40,0),
('可以在程序中设置断点,在调试的时候方便程序停在某-处,以便发现程序错误',40,1),
('使用Eclipse调试的步骤顺序为:启动调试、设置断点、单步执行、分析错误',40,0),
('设置的断点在调试结束后会自动修改错误',40,0),
--java 21
('return',41,0),
('continue',41,0),
('break',41,1),
('exit',41,0),
--java 22
('F5是“单步跳过”，仅执行本行代码; F6是“单步跳入”，会进入本行代码内部执行',42,0),
('F5是“单步跳过”，仅执行本行代码;F6是“单步跳出”，会从代码内部跳出',42,0),
('F5是“单步跳入”，会进入本行代码内部执行;F6是“单步跳过”，仅执行本行代码',42,1),
('F5和F6都是单步执行，没有本质区别',42,0),
--java 23
('i=5',43,1),
('i<3',43,0),
('str.equals("q")',43,0),
('count==i',43,0),
--java 24
('0',44,1),
('12',44,0),
('16',44,0),
('21',44,0),
--java 25
('1357',45,1),
('13579',45,0),
('135',45,0),
('2468',45,0),
--java 26
('120',46,0),
('48',46,0),
('30',46,0),
('45',46,1),
--java 27
('6,7',47,0),
('5,6',47,0),
('7,4',47,0),
('7,6',47,1),
--java 28
('int[] numbers={1,2,3,4,5,6};',48,0),
('int[] numbers=new int[6];',48,0),
('int[] numbers;
numbers = new int[2];',48,0),
('int[] numbers;
numbers = {1,2,3,4,5,6}; ',48,1),
--java 29
('程序报错',49,0),
('1 2 3',49,0),
('1 2 3 4 5',49,1),
('0 0 0',49,0),
--java 30A.
('****
***
**
*',50,1),
('*
**
***
****',50,0),
('*
   **
  ***
****',50,0),
('*********
*********
*********
*********',50,0),
--java 31
('3   4',51,0),
('3   1',51,0),
('4   4',51,0),
('4   i',51,1),
--java 32
('类是具有相同属性和共同行为的一组对象的集合',52,0),
('在Java中使用class关键字定义类',52,0),
('因为类中的属性和方法是从共性中抽象出来的，所以类的属性不能被赋值，类的方法不能有具体实现',52,1),
('定义类就定义了一个自己的数据类型',52,0),
--java 33
('面向对象与人类的思维习惯一致',53,0),
('面向对象提高了程序的可维护性和安全性',53,0),
('面向对象提高了程序的可重用性',53,0),
('使用对象的时候，首先必须知道对象内部的实现细节',53,1),
--java 34
('类型定义机制',54,0),
('数据封装机制',54,0),
('类型定义机制和数据封装机制',54,1),
('上述都不对',54,0),
--java 35
('方法的参数可以为一个或多个',55,1),
('方法返回值的数据类型要和参数的数据类型一致',55,0),
('当方法有多个参数时,多个参数的数据类型必须一致',55,0),
('方法的参数必须为基本数据类型',55,0),
--java 36
('逗号',56,1),
('分号',56,0),
('冒号',56,0),
('不能定义多个参数',56,0),
--java 37
('这条语句的长度是：12',57,0),
('这条语句的长度是：13',57,0),
('这条语句的长度是：15   ',57,1),
('这条语句的长度是：16',57,0),
--java 38
('String s = "accp".toString() + new String("5.0");',58,0),
('String s = "accp5.0";

s = s.toString();',58,0),
('StringBuffer sb = "accp5.0";

sb.append("5.0\n");',58,1),
('StringBuffer sb = new StringBuffer("accp5.0");

String s = sb.toString();',58,0),
--java 39
('查找',59,0),
('查找并替换',59,1),
('增加',59,0),
('删除',59,0),
--java 40
('Earth    Moon    Star    Sun    Super',60,1),
('Sun    Moon   Earth    Star    Super',60,0),
('Super    Sun    Star    Moon    Earth',60,0),
('Super    Star   Earth   Moon   Sun',60,0),
--java 41
('int score = {90,12,34,77,56};',61,0),
('int [] score = new int[5];',61,1),
('int [] score = new [5]{90,12,34,77,56};',61,0),
('int score[] = new int[]{90,12,34,77,56};',61,1),
--java 42
('北京',62,0),
('广州',62,0),
('香港',62,0),
('数组越界',62,1),
--java 43
('会输出numbers[5]的值，80',63,0),
('数组的长度为6',63,0),
('数组最后一个元素的下标为5',63,0),
('数组越界：java.lang.ArrayIndexOutOfBoundsException:',63,1),
--java 44
('声明数组-->分配空间-->赋值-->处理数据',64,1),
('声明数组-->分配空间-->处理数据-->赋值',64,0),
('分配空间-->声明数组-->赋值-->处理数据',64,0),
('声明数组-->赋值-->处理数据-->分配空间',64,0),
--java 45
('5   i',65,0),
('i  j',65,1),
('5  j',65,0),
('i  5-i',65,0),
--java 46
('只会影响内层循环的执行，对外层没有影响。',66,0),
('它们的不同点在于执行该语句后，程序跳转的位置不同。',66,0),
('continue 语句是跳出本次循环，进入下一次循环',66,0),
('break 语句是跳出外层循环',66,1),
--java 47
('Car myCar = new Car;
myCar color="黑色";',67,0),
('Car myCar = new Car();
myCar.brand="宝马";',67,1),
('Car myCar;
myCar.brand="宝马";',67,0),
('Car myCar = new Car();
color="蓝色";',67,0),
--java 48
('类是对象的类型，它封装了数据和操作',68,0),
('类是对象的集合，对象是类的实例',68,0),
('一个类的对象只有一个',68,1),
('一个对象必须属于某个类',68,0),
--java 49
('类和对象的关系是抽象和具体 关系。',69,0),
('类是对象的类型，对象是类的实例。',69,0),
('类是有共同属性和方法的对象的集合',69,0),
('对象是由类抽取而成，对象是类的具体表现',69,1),
--java 50
('使用关键字class定义类',70,0),
('使用关键字new创建类的对象',70,0),
('使用“.”操作符来使用类的属性和方法',70,0),
('定义类的时候：编写类的属性-->编写类的方法-->定义类名',70,1),
--java 51
('导入包即声明在当前类中要使用到的别的类所处的位置',71,0),
('使用import关键字导入包',71,0),
('既可以导入系统提供的包又可以导入用户自定义的包',71,0),
('导入包的语句可以写在Java类定义的任何位置',71,1),
--java 52
('将类组合成较小的单元，便于使用',72,0),
('有助于避免命名冲突',72,0),
('有助于提高运行效率',72,1),
('允许在更广的范围内保护类、数据和方法',72,0),
--java 53
('在类中定义的变量称为类的成员变量，在别的类中可以直接使用',73,0),
('局部变量的作用范围仅仅在定义它的方法内，或者是在定义它的控制流块中',73,1),
('使用别的类的方法仅仅需要引用方法的名字即可',73,0),
('一个类的方法使用该类中的另一个方法时可以直接引用方法名',73,1),
--java 54
('包允许将类组合成较小的单元，便于找到和使用相应的类文件',74,0),
('Java中的包其实类似Windows中的目录，它是为了更好地保护类、数据和方法等',74,0),
('不同的包中不能出现类名相同的类',74,1),
('使用package声明包，使用import引入包',74,0),
--java 55
('9',75,0),
('1',75,0),
('false',75,0),
('编译错误',75,1),
--java 56 
('int num1=(int)"12";',76,0),
(' int num2=12.0;',76,0),
(' double num3=2d; ',76,1),
('double num4=5; ',76,1),
--java 57
(' int count,count = 0;',77,0),
('int count = 0;',77,1),
(' count = 0;',77,0),
('int count = 0,count2 = 1; ',77,1),
--java 58
('1，2',78,0),
('1，5',78,1),
('2，1',78,0),
('2，2',78,0),
--java 59
('定义带参数的方法时，必须要给出参数列表',79,0),
('只有基本数据类型可以作为参数进行传递，其他类型不可以 ',79,1),
('在给出的参数列表中，必须要同时定义参数的数据类型',79,0),
('引用类型的数据也可以作为参数进行传递',79,0),
--java 60
('.class',80,1),
('.java',80,0),
('.txt',80,0),
('.doc',80,0),
--java 61
('Java是不区分大小写的',81,0),
('源文件名与public类型的类名必须相同',81,1),
('源文件名其扩展名为.jar',81,0),
('源文件中public类的数目不限',81,0),
--java 62
('float=11.1f;',82,0),
('double=3.14;',82,0),
('char=`a`;',82,0),
('byte b=433;',82,1),
--java 63
('20,30',83,1),
('30,20',83,0),
('程序逻辑错误',83,0),
('程序编译错误',83,0),
--java 64
('奔驰',84,0),
('奥迪',84,0),
('大众',84,0),
('夏利',84,1),
--java 65
('C',85,0),
('B
C ',85,1),
('无匹配',85,0),
('A
B
C',85,0),
--java 66
('Java 基本数据类型有int 、char 、String 等',86,1),
('name__2是一个合法的变量名',86,0),
('name与 Name 表示不同变量',86,0),
('局部变量需要赋值后,才能使用',86,0),
--java 67
('bc

true',87,0),
('xyz

true',87,0),
('abc

false',87,1),
('abc

true',87,0),
--java 68
('如果Java源文件中有package语句，则该语句必须放在代码第一行',88,1),
('如果Java源文件中有import语句，则该语句必须放在代码第一行',88,0),
('如果Java源文件中有main()方法，则该方法必须放在代码第一行',88,0),
('如果Java源文件中定义了public的类，则该类的名字和文件的名字可以不同',88,0),
--java 69
('中国',89,0),
('你好',89,0),
('你好中国',89,1),
('中国你好',89,0),
--java 70
('int[] array = new int[5]{1,2,3,4,5}; ',90,1),
('int[] array = new int[]{1,2,3};',90,0),
('int[] array = {1,2,3,4};',90,0),
('int[] array = new int[5];',90,0),
--C# 1
('select * from news where dateadd(1,mm,begintime)>=GETDATE()',91,0),
('select * from news where dateadd(mm,1,begintime)>=GETDATE()',91,1),
('select * from news where dateadd(begintime ,mm,1)>=GETDATE()',91,0),
('select * from news where datediff(1,mm, begintime)>=GETDATE()',91,0),
--C# 2
('(^) ',92,0),
('( ) ',92,0),
('[ ]',92,1),
('[^]',92,0),
--C# 3
('可以代替任意长度的字符串',93,1),
('可以代替一个字符',93,0),
('可以代替一个字符以上的任意字符串',93,0),
('用于代替一个表名或列名',93,0),
--C# 4
('SUM( )',94,1),
('TOTAL( )',94,0),
('ADD( )',94,0),
('COUNT( )',94,0),
--C# 5
('private,int para',95,0),
('private,ref para',95,1),
('public,para ref',95,0),
('public,ref para',95,1),
--C# 6
('可以查询学生总人数大于100的年级的数量',96,0),
('可以查询学生总人数大于100的年级信息',96,1),
('可以查询每个年级的学生总人数',96,0),
('代码有错误，不会查询到任何信息',96,0),
--C# 7
('1',97,0),
('3',97,0),
('编译错误',97,1), 
('以上结果都不对',97,0),
--C# 8

('这段代码编译时出现异常',98,0),
('这段代码运行时出现异常',98,1),
('应在执行第二处cmd.ExecuteReader()之前关闭reader对象',98,1),
('应在执行第二处cmd.ExecuteReader()之后打开reader对象',98,0),
--C# 9
('Item和OrderDetails表中的相关记录以及OrderDetails表中其余的不相关记录',99,0),
('Item表和OrderDetails表中的相关记录',99,0),
('Item表和OrderDetails表中的相关记录以及Item表中其余的不相关记录',99,1),
('提示语法错误',99,0),
--C# 10
('Select s.SName,c.CourseId,c.Score

from Students as s inner join Score as c on s.scode=c.StudentId',100,1),
('Select s.SName,c.CourseId,c.Score

from Score as c inner join Students as s on s.scode=c.StudentId',100,1),
('Select s.SName,c.CourseId,c.Score

from Score as c right join Students as s on s.scode=c.StudentId',100,0),
('Select s.SName,c.CourseId,c.Score

from Students as s left join Score as c on s.scode=c.StudentId',100,0),

--HTML 1
('a',101,0),
('A',101,0),
('1',101,1),
('不设置type属性',101,1),
--HTML 2
('是无序列表',102,1),
('是有序列表',102,0),
('自定义列表',102,0),
('自定义列表',102,0),
--HTML 3
('type="checkbox"',103,0),
('value="true"',103,0),
('check="true"',103,0),
('checked="checked"',103,1),
--HTML 4
('在lable中加入for属性，值为gender',104,0),
('在lable中加入for属性，值为male',104,1),
('在lable中加入from属性，值为gender',104,0),
('在lable中加入from属性，值为male',104,0),
--HTML 5
('DIV+CSS布局,具有简洁高效、内容样式分离并且利于改版等特点',105,1),
('DIV+CSS布局这个概念说明布局过程中全部用<div>标签实现',105,0),
('DIV+CSS布局不能与表格布局同时使用',105,0),
('DIV+CSS布局出现以后，其它的布局方式就被淘汰了',105,0),
--HTML 6
('标题标签、段落标签、标签都是块级元素',106,0),
('… …',106,0),
('标签是内联元素 
标签可以包含于标签中 
,',106,0),
('display属性可以控制块级元素和内联元素的显示方式',106,1),
--HTML 7
('200px',107,0),
('220px',107,0),
('240px',107,0),
('252px',107,1),
--HTML 8
('width属性',108,0),
('border属性',108,1),
('margin属性',108,0),
('padding属性',108,0),
--HTML 9
('transition-duration是过渡完成所需的时间',109,0),
('transition-delay是过渡在什么时间之后触发',109,0),
('它们表示的都是时间，但有区别',109,0),
('他们表示的都是时间，没有区别',109,1),
--HTML 10
('@keyframes spread{……}',110,0),
('-webkit-@keyframes spread{……}',110,1),
('@-webkit-keyframes spread{……}',110,0),
('@-moz-keyframes spread{……}',110,0)


select * from Answer
insert into PaperType
 values('内测'),('模拟'),('结业'),('结课')

 --试卷编号-试卷名称-所属年级-试卷类型-考试时长-是否开放-可考班级-抽题策略-题数量-创建时间-创建人
  insert into PaperRule values
('S1结业',1,4,default),
('S2A.net结业',2,4,default),
('S2Bjava结业',2,4,default)
  --策略明细编号-抽题策略编号-教材-章节-试题数量-难度(章单选多选不限)
insert into RuleDetail values 
(1,1,null,20,1),
(1,2,null,10,1),
(1,3,null,10,2),
(1,4,null,10,2),
--net
(2,9,null,10,1),
(2,10,null,10,1),
(2,11,null,10,1),
(2,12,null,10,1),
(2,5,null,10,1),
--java
(3,5,null,10,1),
(3,6,null,20,1),
(3,7,null,10,1),
(3,8,null,10,1)
insert into Module values
 ('基础信息管理',1),
 ('试题管理',2),
 ('考试管理',3),
 ('学生信息管理',4),
 ('成绩查询统计',5),
 ('系统设置',6)
 select * from Menu
insert into Menu values
('年级管理',1,'GradeController',1,'1,2'),--
('教材管理',2,'BookController',1,'1,2'),--
('章节管理',3,'ChapterController',1,'1,2'),--
('题库管理',2,'ShowQuextionController',2,'1'),--
('我的录题',3,'CreatorController',2,'1,2'),--
('试题审核',4,'CheckController',2,'1,2'),
('录题统计',5,'CreatorController',2,'1,2'),--
('试题审核统计',6,'CheckCountController',2,'1,2'),--
('考试类型管理',1,'PaperTypeController',3,'1,2'),--
('考卷管理',2,'PaperController',3,'1,2'),--
('班级管理',1,'ClassController',4,'1,2,3'),--
('学生管理',2,'StudentController',4,'1,2,3'),--
('考试成绩查询',1,'ResultController',5,'1,2,3'),--
('用户管理',1,'TeacherController',6,'1'),--
('角色管理',2,'RoleController',6,'1'),--
('抽题策略管理',4,'PaperRuleController',6,'1,2'),--
('抽题策略明细管理',5,'RuleDetailController',6,'1,2')--

--('试题类别',1,'QuestionService',2,'1,2'),--

--insert into MenuItem values
--('年级信息列表',1,'ShowGrades',1,'1,2,3'),
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