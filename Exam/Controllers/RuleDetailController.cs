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
            foreach (var item in ef.PaperRules.Where(x=>x.Shan==false).ToList())
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
            foreach (var item in ef.RuleDetails.Where(x=>x.RuleID==ef.PaperRules.FirstOrDefault(a=>a.RuleName==jie && a.Shan == false).RuleID && x.Shan == false ).ToList())
            {
                li.Add(new RuleDetailS()
                {
                    BookIDName=ef.TextBooks.FirstOrDefault(x=>x.BookID==item.BookID && x.Shan==false).BookName,
                    DetailID=item.DetailID,
                    QuestionCount=item.QuestionCount,
                    QuestionLevel=item.QuestionLevel,
                    RuleIDName=ef.PaperRules.FirstOrDefault(x=>x.RuleID==item.RuleID && x.Shan == false).RuleName
                });
            }
            return Json(li,JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult ListShow(string jie)
        {
            List<string> li1 = new List<string>();
            foreach (var item in ef.TextBooks.Where(a=>a.GradeID==ef.TextBooks.FirstOrDefault(x=>x.BookName==jie && x.Shan==false).GradeID && a.Shan==false).ToList())
            {
                li1.Add(item.BookName);
            }
            return Json(li1, JsonRequestBehavior.AllowGet);
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
                BookID=ef.TextBooks.FirstOrDefault(x=>x.BookName==te.BookIDName && x.Shan==false).BookID,
                DetailID=te.DetailID,
                QuestionCount=te.QuestionCount,
                QuestionLevel=te.QuestionLevel,
                RuleID=ef.PaperRules.FirstOrDefault(x=>x.RuleName==te.RuleIDName && x.Shan==false).RuleID,
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
            foreach (var item in ef.PaperRules.Where(x=>x.Shan==false))
            {
                PaperSS te = new PaperSS() { ID = item.RuleID, Name = item.RuleName };
                foreach (var item1 in ef.RuleDetails.Where(x=>x.RuleID==item.RuleID && x.Shan==false))
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
        //删除章节
        public ActionResult Delete(string ID1)
        {
            try
            {
                int sum=int.Parse(ID1);
                ef.RuleDetails.Remove(ef.RuleDetails.FirstOrDefault(x=>x.DetailID==sum));
                if (ef.SaveChanges() > 0)
                {
                    return Content("删除成功");
                }
                else
                {
                    return Content("删除失败");
                }
            }
            catch(Exception ex)
            {
                return Content(ex.ToString());
            }
        }
        //添加章节时所属策略的年级的所有课程
        [HttpPost]
        public ActionResult TeacherBook(string jie)
        {
            try
            {
                List<string> li1 = new List<string>();
                List<TextBook> li= ef.TextBooks.Where(s=>s.GradeID==ef.PaperRules.FirstOrDefault(x => x.RuleName == jie && x.Shan==false).GradeID && s.Shan==false).ToList();
                foreach (var item in li)
                {
                    li1.Add(item.BookName);
                }
                return Json(li1,JsonRequestBehavior.AllowGet);
            }catch(Exception ex)
            {
                return Content(ex.ToString());
            }
         
        }

        //添加章节
        [HttpPost]
        public ActionResult ZhangADD(RuleDetailS te)
        {
            try
            {
                if(ef.RuleDetails.Any(x=>x.BookID== ef.TextBooks.FirstOrDefault(a => a.BookName == te.BookIDName && a.Shan==false).BookID && x.QuestionCount==te.QuestionCount && x.QuestionLevel==te.QuestionLevel && x.Shan==false &&x.RuleID== ef.PaperRules.FirstOrDefault(b => b.RuleName == te.RuleIDName && b.Shan==false).RuleID))
                {
                    return Content("已经存在了，请重新添加");
                }
                else
                {
                    RuleDetail ta = new RuleDetail()
                    {
                        BookID = ef.TextBooks.FirstOrDefault(x => x.BookName == te.BookIDName).BookID,
                        RuleID = ef.PaperRules.FirstOrDefault(x => x.RuleName == te.RuleIDName).RuleID,
                        QuestionCount = te.QuestionCount,
                        QuestionLevel = te.QuestionLevel
                    };
                    ef.Entry(ta).State = EntityState.Added;
                    if (ef.SaveChanges() > 0)
                    {
                        return Content("添加成功");
                    }
                    else
                    {
                        return Content("添加失败");
                    }
                }
            }
            catch (Exception ex)
            {
                return Content(ex.ToString());
            }
        }






    }
}