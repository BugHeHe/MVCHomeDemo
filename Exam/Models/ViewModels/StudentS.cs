using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models.ViewModels
{
    public class StudentS
    {
        public int StudentID { get; set; }
        public string StudentName { get; set; }
        public string Password { get; set; }
        public string Gender { get; set; }
        public string Phone { get; set; }
        public string CardID { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public string Borndate { get; set; }
        public string CreateTime { get; set; }
        public string ClassName { get; set; }
    }
}