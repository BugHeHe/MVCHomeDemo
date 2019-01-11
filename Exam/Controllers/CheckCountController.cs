using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using Exam.Models.ViewModels;
using System.Data.Entity;
using Exam.Filter;

namespace Exam.Controllers
{
    public class CheckCountController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        //审核统计
        // GET: CheckCount
        [LoginHou]
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List()
        {
            List<CountTeacher> li = shou();
            return Json(li, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Select(string DateQian, string DateHou)
        {
            try
            {
                List<CountTeacher> li = new List<CountTeacher>();
                foreach (var item in ef.Teachers.Where(x=>x.Shan==false).ToList())
                {
                    CountTeacher te = new CountTeacher();
                    te.Name = item.TeacherName;
                    DateTime de1 = DateTime.Now;
                    DateTime de2 = DateTime.Now;
                    if (!string.IsNullOrEmpty(DateQian))
                        de1 = DateTime.Parse(DateQian);
                    else if (!string.IsNullOrEmpty(DateHou))
                        de2 = DateTime.Parse(DateHou);

                    if (!string.IsNullOrEmpty(DateQian) && !string.IsNullOrEmpty(DateHou))
                    {
                        te.Count = ef.Questions.Where(x => x.CheckID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && x.Shan == false).TeacherID && x.CheckTime >= de1 && x.CheckTime <= de2).Count();
                    }
                    else if (string.IsNullOrEmpty(DateQian) && !string.IsNullOrEmpty(DateHou))
                    {
                        te.Count = ef.Questions.Where(x => x.CheckID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && x.Shan == false ).TeacherID && x.CheckTime <= de2).Count();
                    }
                    else if (!string.IsNullOrEmpty(DateQian) && string.IsNullOrEmpty(DateHou))
                    {
                        te.Count = ef.Questions.Where(x => x.CheckID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && x.Shan == false ).TeacherID && x.CheckTime >= de1).Count();
                    }
                    else
                    {
                        te.Count = ef.Questions.Where(x => x.CreatorID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && x.Shan == false ).TeacherID).Count();
                    }
                    li.Add(te);
                }
                return Json(li, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Content("出现错误");
            }


        }
        public List<CountTeacher> shou()
        {
            List<CountTeacher> li = new List<CountTeacher>();
            foreach (var item in ef.Teachers.Where(x => x.Shan == false).ToList())
            {
                li.Add(new CountTeacher()
                {
                    Name = item.TeacherName,
                    Count = ef.Questions.Where(x => x.CheckID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && x.Shan==false).TeacherID && x.IsCheck==true).Count()
                });
            }
            return li;
        }
    }
}