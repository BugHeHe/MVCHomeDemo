using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models.ViewModels
{
    public class PaperS
    {
        public int PaperID { get; set; }
        public string PaperName { get; set; }
        public string GradeIDName { get; set; }
        public string typeID { get; set; }
        public int Duration { get; set; }
        public int IsOpen { get; set; }
        public string ClassList { get; set; }
        public string RuleID { get; set; }
        public int QuestionCount { get; set; }
        public string CreateTime { get; set; }
        public int CreatorID { get; set; }
    }
}