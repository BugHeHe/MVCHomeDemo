using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using Exam.Models;
using Exam.Models.ViewModels;
using System.Web.Mvc;

namespace Exam.Controllers
{
    public class PaperRuleController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: PaperRule
        public ActionResult Index()
        {
            var li = new List<SelectListItem>();
            foreach (var item in ef.Grades.ToList())
            {
                li.Add(new SelectListItem() { Text = item.GradeName, Value = item.GradeID.ToString() });
            }
            SelectListItem lis = new SelectListItem() { Text = "全部", Value = "-1" };
            li.Insert(0, lis);
            ViewData["BookGrade"] = li;
            return View();
        }

        public ActionResult List(string page, string GradeID, string TiN)
        {

            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<PaperRuleS> li = Shou();

            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Select(string page, string GradeID, string TiN)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<PaperRuleS> li = Shou();
            List<PaperRuleS> pagedList = null;
            int GradID = Convert.ToInt32(GradeID);
            Grade GrNa = ef.Grades.FirstOrDefault(x => x.GradeID == GradID);
            if (!string.IsNullOrEmpty(TiN) && !string.IsNullOrEmpty(GradeID))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x => x.RuleName.Contains(TiN) && x.GradeIDName == GrNa.GradeName).Skip((ye - 1) * 10).Take(10).ToList();
                }
                else
                    pagedList = li.Where(x => x.RuleName.Contains(TiN)).ToList();

            }
            else if (string.IsNullOrEmpty(TiN) && GradID >= 1)
            {
                pagedList = li.Where(x => x.GradeIDName == GrNa.GradeName).ToList();
            }
            else if (string.IsNullOrEmpty(GradeID))
            {
                pagedList = li.Where(x => x.RuleName.Contains(TiN)).ToList();
            }
            else
            {
                pagedList = li.ToList();
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        public List<PaperRuleS> Shou()
        {
            List<PaperRuleS> li = new List<PaperRuleS>();
            foreach (var item in ef.PaperRules.ToList())
            {
                li.Add(new PaperRuleS()
                {
                    CreateTime=item.CreateTime.ToString(),
                    CreatorIDName=ef.Teachers.FirstOrDefault(x=>x.TeacherID==item.CreatorID).TeacherName,
                    GradeIDName=ef.Grades.FirstOrDefault(x=>x.GradeID==item.GradeID).GradeName,
                    RuleID=item.RuleID,
                    RuleName=item.RuleName
                });
            }
            return li;
        }

        [HttpPost]
        public ActionResult ADD(PaperRuleS te)
        {
            try
            {
                ef.Configuration.LazyLoadingEnabled = false;
                ef.Configuration.ProxyCreationEnabled = false;
                Teacher tea = Session["User"] as Teacher;
                PaperRule ta = new PaperRule()
                {
                    GradeID = Convert.ToInt32(te.GradeIDName),
                    CreateTime = DateTime.Now,
                    RuleName = te.RuleName,
                    CreatorID =1
                };
                ef.Entry(ta).State = EntityState.Added;
                ef.SaveChanges();
                Grade gr = ef.Grades.FirstOrDefault(x => x.GradeID == ta.GradeID);
                List<TextBook> li = ef.TextBooks.Where(x => x.GradeID == gr.GradeID).ToList();
                int chu = 50 % li.Count;
                List<PaperRule> listPa = ef.PaperRules.ToList();
                for (int i = 0; i < li.Count; i++)
                {
                    RuleDetail Ru = new RuleDetail();
                    Ru.RuleID = listPa[listPa.Count-1].RuleID;
                    Ru.BookID = li[i].BookID;
                    Ru.QuestionCount = i == 0 ? ((50 - chu) / li.Count) + chu : (50 - chu) / li.Count;
                    Ru.QuestionLevel = 1;
                    ef.Entry(Ru).State = EntityState.Added;
                    ef.SaveChanges();
                }
                
                return Content("添加成功");
            }
            catch(Exception ex)
            {
                return Content("添加失败");
            }
            
        }
        [HttpPost]
        public ActionResult Clear(PaperRuleS  te)
        {
            string name = te.RuleName;
            ef.PaperRules.Remove(ef.PaperRules.FirstOrDefault(x=>x.RuleName==name));
            if (ef.SaveChanges() > 0)
            {
                return Json(Shou(), JsonRequestBehavior.AllowGet);
            }
            else
                return Content("失败");
        }

        [HttpPost]
        public ActionResult Update(PaperRuleS te)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            ef.Configuration.LazyLoadingEnabled = false;
            try
            {
                PaperRule a = new PaperRule()
                {
                    CreateTime = DateTime.Parse(te.CreateTime),
                    CreatorID = ef.Teachers.FirstOrDefault(x => x.TeacherName == te.CreatorIDName).TeacherID,
                    GradeID = Convert.ToInt32(te.GradeIDName),
                    RuleID = te.RuleID,
                    RuleName = te.RuleName
                };
                ef.Entry(a).State = EntityState.Modified;
                if (ef.SaveChanges() > 0)
                {
                    return Content("修改成功");
                }
                return Content("添加失败");
            }
            catch
            {
                return Content("请输入正确的姓名");
            }
            
        }
    }
}