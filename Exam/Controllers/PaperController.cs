using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using Exam.Models.ViewModels;
using System.Data.Entity;

namespace Exam.Controllers
{
    /// <summary>
    /// 考卷管理
    /// </summary>
    public class PaperController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Paper
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Yu()
        {
            return View();
        }

        [HttpPost]
        public ActionResult List(string page)
        {
            List<Grade> Gradli = new List<Grade>();
            foreach (var item in ef.Grades.ToList())
            {
                Gradli.Add(new Grade()
                {
                    GradeName=item.GradeName
                });
            }
            Gradli.Insert(0, new Grade() { GradeName = "全部" });
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<PaperS> li = Show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page, list1 = Gradli };
            return Json(Tili, JsonRequestBehavior.AllowGet);

        }
        public List<PaperS> Show()
        {
            List<PaperS> li = new List<PaperS>();
            foreach (var item in ef.Papers.ToList())
            {
                li.Add(new PaperS()
                {
                    CreateTime=item.CreateTime.ToString(),
                    CreatorID=item.CreatorID,
                    Duration=item.Duration,
                    IsOpen=item.IsOpen==false?1:0,
                    PaperID=item.PaperID,
                    PaperName=item.PaperName,
                    QuestionCount=item.QuestionCount,
                    RuleID=item.RuleID,
                    typeID=item.typeID,
                    GradeIDName=ef.Grades.FirstOrDefault(x=>x.GradeID==item.GradeID).GradeName,
                    ClassList=item.ClassList,
                });
            }
            return li;
        }
    }
}