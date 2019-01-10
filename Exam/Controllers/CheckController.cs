using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using System.Data.Entity;
using Exam.Models.ViewModels;

namespace Exam.Controllers
{
    public class CheckController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Check
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Desc(string bian)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            ViewData["bian"] = bian;
            return View();
        }

        [HttpPost]
        public ActionResult ListDe(string Bian)
        {
            ef.Configuration.LazyLoadingEnabled = false;
            ef.Configuration.ProxyCreationEnabled = false;
            int bian = Convert.ToInt32(Bian);
            try
            {
                QuestionS te = Show().FirstOrDefault(x => x.QuestionID == bian);
                return Json(te, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Content("失败出现错误");
            }

        }

        [HttpPost]
        public ActionResult AnList(string Bian)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            ef.Configuration.LazyLoadingEnabled = false;
            int bian = Convert.ToInt32(Bian);
            return Json(ef.Answers.Where(x => x.QuestionID == bian).ToList(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 页面加载集合
        /// </summary>
        /// <param name="page"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult List(string page)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<QuestionS> li = Show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Select(string page, string DateQian, string DateHou)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<QuestionS> li = Show();
            List<QuestionS> pagedList = new List<QuestionS>();
            //条件判断
            DateTime de1 = DateTime.Now;
            DateTime de2 = DateTime.Now;
            if (!string.IsNullOrEmpty(DateQian))
                de1 = DateTime.Parse(DateQian);
            else if (!string.IsNullOrEmpty(DateHou))
                de2 = DateTime.Parse(DateHou);


            if (!string.IsNullOrEmpty(DateQian) && !string.IsNullOrEmpty(DateHou))
            {
                pagedList = li.Where(x =>  x.CreateTime >= de1 && x.CreateTime <= de2).ToList();
            }
            else if (string.IsNullOrEmpty(DateQian) && !string.IsNullOrEmpty(DateHou))
            {
                pagedList = li.Where(x => x.CreateTime <= de2).ToList();
            }
            else if (!string.IsNullOrEmpty(DateQian) && string.IsNullOrEmpty(DateHou))
            {
                pagedList = li.Where(x=> x.CreateTime >= de1).ToList();
            }
            else
            {
                pagedList = li;
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        public List<QuestionS> Show()
        {
            List<QuestionS> li = new List<QuestionS>();
            foreach (var item in ef.Questions.Where(x=>x.IsCheck==false && x.Shan==false).ToList())
            {
                Session["he"] = item.QuestionTitle;
                li.Add(new QuestionS()
                {
                    BookIDName = ef.TextBooks.FirstOrDefault(x => x.BookID == item.BookID && x.Shan == false).BookName,
                    ChapterIDName = ef.Chapters.FirstOrDefault(x => x.ChapterID == item.ChapterID && x.Shan == false).ChapterName,
                    CreatorName = ef.Teachers.FirstOrDefault(x => x.TeacherID == item.CreatorID && x.Shan == false).UserName,
                    QuestionID = item.QuestionID,
                    QuestionLevel = item.QuestionLevel,
                    QuestionTitle = item.QuestionTitle,
                    QuestionType = item.QuestionType == false ? "单选题" : "双选题",
                    GradeName = ef.Grades.FirstOrDefault(a => a.GradeID == ef.TextBooks.FirstOrDefault(x => x.BookID == item.BookID && x.Shan == false).GradeID && a.Shan == false).GradeName,
                    Description = item.Description,
                    CreateTime = item.CreateTime
                });
            }
            return li;
        }

        [HttpPost]
        public ActionResult QuestionADD(QuestionS te)
        {
            Question queBin = ef.Questions.FirstOrDefault(x => x.QuestionID == te.QuestionID && x.Shan == false);
            Teacher dong = Session["User"] as Teacher;
            queBin.BookID = ef.TextBooks.FirstOrDefault(x => x.BookName == te.BookIDName && x.Shan == false).BookID;
            queBin.QuestionTitle = te.QuestionTitle;
            queBin.QuestionType = te.QuestionType == "单选题" ? false : true;
            queBin.QuestionLevel = te.QuestionLevel;
            queBin.ChapterID = ef.Chapters.FirstOrDefault(x => x.ChapterName == te.ChapterIDName && x.Shan == false).ChapterID;
            queBin.IsCheck =true;
            queBin.CheckTime = DateTime.Now;
            queBin.CheckID = 2;
            ef.Entry(queBin).State = EntityState.Modified;
            if (ef.SaveChanges() > 0)
                return Content("成功");
            return Content("失败");
        }

        [HttpPost]
        public ActionResult Anser(string xia,string ID, string an, string b)
        {
            try
            {
                int list = Convert.ToInt32(ID);
                if (Convert.ToInt32(xia) == 0)
                {
                    int QuestionID = list;
                    foreach (var item in ef.Answers.Where(x => x.QuestionID == list && x.Shan == false).ToList())
                    {
                        ef.Answers.Remove(item);
                        ef.SaveChanges();
                    }
                    Answer tae = new Answer() { Shan = false, AnswerContent = an, IsResult = b == "0" ? false : true };
                    tae.QuestionID =list;
                    ef.Entry(tae).State = EntityState.Added;
                    ef.SaveChanges();
                }
                else
                {

                    Answer tae = new Answer() { Shan = false, AnswerContent = an, IsResult = b == "0" ? false : true };
                    tae.QuestionID = list;
                    ef.Entry(tae).State = EntityState.Added;
                    ef.SaveChanges();

                }
                return Content("");
            }
            catch (Exception ex)
            {
                return Content(ex.ToString());
            }

        }

    }
}