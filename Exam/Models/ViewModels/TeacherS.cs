using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models.ViewModels
{
    public class TeacherS
    {
        public int TeacherID     { get; set; }
        public string TeacherName { get; set; }
        public string TeacherImg { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string RoleName { get; set; }
        public string JoinTime { get; set; }

    }
}