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
    /// 抽题测略明细
    /// </summary>
    public class RuleDetailController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: RuleDetail
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult List(string page)
        {
            List<PaperRule> li1 = new List<PaperRule>();
            foreach (var item in ef.PaperRules.ToList())
            {
                li1.Add(new PaperRule()
                {
                    RuleName = item.RuleName
                });
            }
            li1.Insert(0, new PaperRule() { RuleName = "全部" });
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<RuleDetailS> li = Show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page,list1=li1};
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 返回集合对象
        /// </summary>
        /// <returns></returns>
        public List<RuleDetailS> Show()
        {
            List<RuleDetailS> li = new List<RuleDetailS>();
            foreach (var item in ef.RuleDetails.ToList())
            {
                li.Add(new RuleDetailS()
                {
                    BookIDName=ef.TextBooks.FirstOrDefault(x=>x.BookID==item.BookID).BookName,
                    DetailID=item.DetailID,
                    QuestionCount=item.QuestionCount,
                    QuestionLevel=item.QuestionLevel,
                    RuleIDName=ef.PaperRules.FirstOrDefault(x=>x.RuleID==item.RuleID).RuleName
                });
            }
            return li;
        }

        [HttpPost]
        public ActionResult Select(string page, string Name)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<RuleDetailS> pagedList = null;
            if (Name == "全部")
            {
               pagedList=Show().ToList();
            }
            else
            {
                pagedList=Show().Where(x => x.RuleIDName.Contains(Name)).ToList();
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Update(RuleDetailS te)
        {
            RuleDetail ta = new RuleDetail()
            {
                BookID=ef.TextBooks.FirstOrDefault(x=>x.BookName==te.BookIDName).BookID,
                DetailID=te.DetailID,
                QuestionCount=te.QuestionCount,
                QuestionLevel=te.QuestionLevel,
                RuleID=ef.PaperRules.FirstOrDefault(x=>x.RuleName==te.RuleIDName).RuleID,
            };
            ef.Entry(ta).State = EntityState.Modified;
            if (ef.SaveChanges() > 0)
            {
                return Content("成功");
            }
            else
            {
                return Content("失败");
            }
        }
    }
}