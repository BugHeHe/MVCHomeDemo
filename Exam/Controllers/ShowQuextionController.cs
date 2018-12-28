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
    /// 考试题库管理
    /// </summary>
    public class ShowQuextionController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: ShowQuextion
        public ActionResult Index()
        {
          
            return View();
        }
        
        public ActionResult Dese(string bian)
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
            return Json(ef.Answers.Where(x => x.QuestionID ==bian).ToList(), JsonRequestBehavior.AllowGet);
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
        public ActionResult Select(string page,string Title,string GradeName,string BookName,string ChapterName)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<QuestionS> li = Show();
            List<QuestionS> pagedList = null;
            //条件判断
            if (!string.IsNullOrEmpty(Title))
            {
                if (GradeName == "全部")
                    pagedList = li.Where(x => x.QuestionTitle == Title).ToList();
                else if (BookName == "全部")
                    pagedList = li.Where(x => x.QuestionTitle == Title && x.GradeName==GradeName).ToList();
                else if(ChapterName == "全部")
                    pagedList = li.Where(x => x.QuestionTitle == Title && x.GradeName == GradeName && x.BookIDName==BookName).ToList();
                else
                    pagedList = li.Where(x => x.QuestionTitle == Title && x.GradeName == GradeName && x.BookIDName == BookName && x.ChapterIDName == ChapterName).ToList();
            }
            else
            {
                if (GradeName == "全部")
                    pagedList = li.ToList();
                else if (BookName == "全部")
                    pagedList = li.Where(x =>  x.GradeName == GradeName).ToList();
                else if (ChapterName == "全部")
                    pagedList = li.Where(x => x.GradeName == GradeName && x.BookIDName == BookName).ToList();
                else
                    pagedList = li.Where(x => x.GradeName == GradeName && x.BookIDName == BookName && x.ChapterIDName==ChapterName).ToList();
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        public List<QuestionS> Show()
        {
            List<QuestionS> li = new List<QuestionS>();
            foreach (var item in ef.Questions.ToList())
            {
                li.Add(new QuestionS()
                {
                    BookIDName = ef.TextBooks.FirstOrDefault(x => x.BookID == item.BookID).BookName,
                    ChapterIDName = ef.Chapters.FirstOrDefault(x => x.ChapterID == item.ChapterID).ChapterName,
                    CreatorName = ef.Teachers.FirstOrDefault(x => x.TeacherID == item.CreatorID).UserName,
                    QuestionID = item.QuestionID,
                    QuestionLevel = item.QuestionLevel,
                    QuestionTitle = item.QuestionTitle,
                    QuestionType = item.QuestionType == false ? "单选题" : "双选题",
                    GradeName = ef.Grades.FirstOrDefault(a => a.GradeID == ef.TextBooks.FirstOrDefault(x => x.BookID == item.BookID).GradeID).GradeName,
                    Description = item.Description
                    
                });
            }
            return li;
        }
        /// <summary>
        /// 年级的返回集合
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult BookList(string GradeID)
        {
            List<TextBook> li = new List<TextBook>();
            
            foreach (var item in ef.TextBooks.Where(x=>x.GradeID==ef.Grades.FirstOrDefault(a=>a.GradeName==GradeID).GradeID).ToList())
            {
                li.Add(new TextBook() { BookID = item.BookID, BookName = item.BookName });
            }
            li.Insert(0, new TextBook() { BookID = -1, BookName = "全部" });
            return Json(li, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 章节返回集合
        /// </summary>
        /// <param name="Chapter"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ChapterList(string Chapter)
        {
            List<Chapter> li = new List<Chapter>();

            foreach (var item in ef.Chapters.Where(x => x.BookID == ef.TextBooks.FirstOrDefault(a => a.BookName ==Chapter).BookID).ToList())
            {
                li.Add(new Chapter() { ChapterID = item.ChapterID, ChapterName = item.ChapterName });
            }
            li.Insert(0, new Chapter() { ChapterID =-1, ChapterName ="全部"});
            return Json(li, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 教材的返回集合 
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GradeList()
        {
            List<Grade> li = new List<Grade>();
            foreach (var item in ef.Grades)
            {
                li.Add(new Grade() { GradeID = item.GradeID, GradeName = item.GradeName });
            }
            li.Insert(0, new Grade() { GradeName = "全部", GradeID = -1 });
            return Json(li, JsonRequestBehavior.AllowGet);
        }
        
    }
}