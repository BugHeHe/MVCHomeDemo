using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using Exam.Models;
using Exam.Models.ViewModels;

namespace Exam.Controllers
{
    /// <summary>
    /// 录题统计表
    /// </summary>
    public class CreatorController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Creator
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List()
        {
            return Json(shou(), JsonRequestBehavior.AllowGet);
        }
        public List<CountTeacher> shou()
        {
            List<CountTeacher> li = new List<CountTeacher>();
            foreach (var item in ef.Teachers.Where(x=>x.RoleID==2))
            {
                li.Add(new CountTeacher()
                {
                    Name = item.TeacherName,
                    Count = ef.Questions.Where(x => x.CreatorID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName).TeacherID).Count()
                });
            }
            return li;
        }
    }
}