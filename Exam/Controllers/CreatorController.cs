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
            List<CountTeacher> li = shou();
            return Json(li, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Select(string DateQian,string DateHou)
        {
            try
            {
                List<CountTeacher> li = new List<CountTeacher>();
                foreach (var item in ef.Teachers.Where(x =>x.Shan==false))
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
                        te.Count = ef.Questions.Where(x => x.CreatorID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && a.Shan==false).TeacherID && x.CreateTime >= de1 && x.CreateTime <= de2 && x.Shan == false).Count();
                    }
                    else if (string.IsNullOrEmpty(DateQian) && !string.IsNullOrEmpty(DateHou))
                    {
                        te.Count = ef.Questions.Where(x => x.CreatorID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && a.Shan == false).TeacherID && x.CreateTime <= de2 && x.Shan == false).Count();
                    }
                    else if (!string.IsNullOrEmpty(DateQian) && string.IsNullOrEmpty(DateHou))
                    {
                        te.Count = ef.Questions.Where(x => x.CreatorID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && a.Shan == false).TeacherID && x.CreateTime >= de1 && x.Shan == false).Count();
                    }
                    else
                    {
                        te.Count = ef.Questions.Where(x => x.CreatorID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && a.Shan == false).TeacherID && x.Shan == false).Count();
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
            foreach (var item in ef.Teachers.Where(x=>x.Shan==false))
            {
                li.Add(new CountTeacher()
                {
                    Name = item.TeacherName,
                    Count = ef.Questions.Where(x => x.CreatorID == ef.Teachers.FirstOrDefault(a => a.TeacherName == item.TeacherName && a.Shan==false).TeacherID && x.Shan==false).Count()
                });
            }
            return li;
        }
    }
}