using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models.ViewModels
{
    public class QuestionS
    {

        public int QuestionID { get; set; }//题干编号
        public string QuestionTitle { get; set; }//试题标题
        public string QuestionType { get; set; }//试题类型
        public int QuestionLevel { get; set; }//试题难度
        public string GradeName { get; set; }//所属年级
        public string BookIDName { get; set; }//教材名称
        public string ChapterIDName { get; set; }//章节名称
        public string CreatorName { get; set; }//创建人
        public string CheckTime { get; set; }//审核时间
        public DateTime CreateTime { get; set; }
        public string Description { get; set; }

    }
}