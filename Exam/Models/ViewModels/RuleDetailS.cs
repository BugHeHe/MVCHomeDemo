using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models.ViewModels
{
    public class RuleDetailS
    {
        public int DetailID { get; set; }
        public string RuleIDName { get; set; }
        public string BookIDName { get; set; }
        public int QuestionCount { get; set; }
        public int QuestionLevel { get; set; }

    }
}