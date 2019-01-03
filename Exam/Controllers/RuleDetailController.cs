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
        public ActionResult List()
        {
            List<PaperRule> li = new List<PaperRule>();
            foreach (var item in ef.PaperRules.ToList())
            {
                li.Add(new PaperRule()
                {
                    RuleName=item.RuleName
                });
            }
            li.Insert(0, new PaperRule() { RuleName = "全部"});
            return Json(li, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult List(string page)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<RuleDetailS> li = Show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

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
    }
}