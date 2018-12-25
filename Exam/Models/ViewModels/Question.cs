using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models.ViewModels
{
    public class Question
    {
        //     QuestionID int not  null primary key identity(1,1),--试题编号
        // QuestionTitle varchar(1000) not null ,--试题标题(题目)

        // QuestionType bit not null,--试题类型 1多选 0单选
        // QuestionLevel int not null check(QuestionLevel in (1,2,3)),--试题难度 1简单 2中等 3困难
        //BookID int not null foreign key references TextBook(BookID),--教材编号
        //ChapterID int not null foreign key references Chapter(ChapterID) ,--章节编号
        //IsCheck bit not null,--是否审核
        //CreatorID int not null foreign key references Teacher(TeacherID) ,--创建人编号

        //CreateTime datetime not null default getdate(),--创建时间
        //CheckID int null foreign key references Teacher(TeacherID) ,--审核人编号

        //CheckTime datetime  null default getdate(),--审核时间
        ////[Description] varchar(500) not null--试题解析

        //public int QuestionID { get; set; }
        //public string QuestionTitle { get; set; }
        //public bool QuestionType { get; set; }
        //public int QuestionLevel { get; set; }
        //public string BookIDName { get; set; }
        //public string ChapterIDName { get; set; }
        //public bool IsCheck { get; set; }
        //public int CreatorName { get; set; }
        //public DateTime CreateTime { get; set; }
        //public int CheckIDName { get; set; }

    }
}