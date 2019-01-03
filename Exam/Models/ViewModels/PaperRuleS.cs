using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models.ViewModels
{
    public class PaperRuleS
    {
        public int RuleID { get; set; }
        public string RuleName { get; set; }
        public string GradeIDName { get; set; }
        public string CreatorIDName { get; set; }
        public string CreateTime { get; set; }
    }
}