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

        public ActionResult Yu(string bian)
        {
            ViewData["Bian"] = bian;
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

        [HttpPost]
        public ActionResult Select(string page, string GradeID)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<PaperS> li = Show();
            List<PaperS> pagedList = null;
            if (!string.IsNullOrEmpty(GradeID))
            {
                pagedList = li.Where(x => x.GradeIDName == GradeID).ToList();
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = ye };
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

        [HttpPost]
        public ActionResult Update(string id,string Shi)
        {
            int ID = Convert.ToInt32(id);
            bool flag = Shi == "0" ? true : false;
            Paper te = ef.Papers.FirstOrDefault(x => x.PaperID == ID);
            te.IsOpen = flag;
            ef.Entry(te).State = EntityState.Modified;
            if (ef.SaveChanges() > 0)
            {
                return Content("成功");
            }
            return Content("失败");
        }

        [HttpPost]
        public ActionResult Delete(string id)
        {
            int ID = Convert.ToInt32(id);
            ef.Papers.Remove(ef.Papers.FirstOrDefault(x => x.PaperID == ID));
            if (ef.SaveChanges() > 0)
            {
                return Content("删除成功");
            }
            return Content("失败！");
        }
    }
}