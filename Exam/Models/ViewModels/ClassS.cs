using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models.ViewModels
{
    public class ClassS
    {
        public int ClassID { get; set; }
        public string ClassName { get; set; }//班级编号
        public string MasterName { get; set; }//班主任
        public string TeacharName{ get; set; }//教员
        public string GradeName { get; set; }//年级编号  采用年级
        public DateTime CreateTime { get; set; }//班级创建时间
    }
}