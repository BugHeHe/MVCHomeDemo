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
            List<PaperSS> li = Shou();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page,list1=li1};
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 返回集合对象
        /// </summary>
        /// <returns></returns>
        public ActionResult Show(string jie)
        {
            List<RuleDetailS> li = new List<RuleDetailS>();
            foreach (var item in ef.RuleDetails.Where(x=>x.RuleID==ef.PaperRules.FirstOrDefault(a=>a.RuleName==jie).RuleID).ToList())
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
            List<TextBook> li1 = new List<TextBook>();
            foreach (var item in ef.RuleDetails.Where(x => x.RuleID == ef.PaperRules.FirstOrDefault(a => a.RuleName == jie).RuleID).ToList())
            {
                li1.Add(ef.TextBooks.FirstOrDefault(x => x.BookID == item.BookID));
            }
            return Json(li,JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Select(string page, string Name)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<PaperSS> pagedList = null;
            if (Name == "全部")
            {
               pagedList=Shou().ToList();
            }
            else
            {
                pagedList=Shou().Where(x => x.Name.Contains(Name)).ToList();
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

        /// <summary>
        /// 返回对象的策略明细的名称以及题个数
        /// </summary>
        /// <returns></returns>
        public List<PaperSS> Shou()
        {
            List<PaperSS> li = new List<PaperSS>();
            foreach (var item in ef.PaperRules)
            {
                PaperSS te = new PaperSS() { ID = item.RuleID, Name = item.RuleName };
                foreach (var item1 in ef.RuleDetails.Where(x=>x.RuleID==item.RuleID))
                {
                    te.Count+=item1.QuestionCount;
                }
                li.Add(te);
            }
            return li;
        }

        /// <summary>
        /// 返回每个策略名称的具体的内容
        /// </summary>
        /// <returns></returns>
        //public List<PaperSSS> ListShow(string jie)
        //{
        //    List<PaperSSS> li = new List<PaperSSS>();
        //    foreach (var item in ef.RuleDetails.ToList())
        //    {
        //        PaperSSS te = new PaperSSS();
        //        te.Name=ef.PaperRules.FirstOrDefault(x=>x.)
        //    }
        //}
    }
}