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
    public class CreatorLuController : Controller
    {
        /// <summary>
        /// 我的录题
        /// </summary>
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: CreatorLu
        public ActionResult Index()
        {
            
            return View();
        }
        public ActionResult ADD()
        {
            return View();
        }

        public ActionResult Desc(string bian)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            ViewData["bian"] =bian;
            return View();
        }


        [HttpPost]
        public ActionResult QuestionADD(QuestionS te)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            ef.Configuration.LazyLoadingEnabled = false;
          Teacher dong= Session["User"] as Teacher;
            Question an = new Question()
            {
                BookID = ef.TextBooks.FirstOrDefault(x => x.BookName == te.BookIDName).BookID,
                QuestionTitle = te.QuestionTitle,
                QuestionType = te.QuestionType == "单选题" ? false : true,
                QuestionLevel = te.QuestionLevel,
                ChapterID = ef.Chapters.FirstOrDefault(x => x.ChapterName == te.ChapterIDName).ChapterID,
                CreatorID = 2,
                CreateTime = DateTime.Now,
                IsCheck = false,
                Description = te.Description,
                Shan = false
            };
            ef.Entry(an).State = EntityState.Added;
            if (ef.SaveChanges() > 0)
                return Content("成功");
            return Content("失败");
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
        public ActionResult Select(string page, string Title, string GradeName, string BookName, string ChapterName)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<QuestionS> li = Show();
            List<QuestionS> pagedList = null;
            //条件判断
            if (!string.IsNullOrEmpty(Title))
            {
                if (GradeName == "全部")
                    pagedList = li.Where(x => x.QuestionTitle.Contains(Title)).ToList();
                else if (BookName == "全部")
                    pagedList = li.Where(x => x.QuestionTitle.Contains(Title) && x.GradeName == GradeName).ToList();
                else if (ChapterName == "全部")
                    pagedList = li.Where(x => x.QuestionTitle.Contains(Title) && x.GradeName == GradeName && x.BookIDName == BookName).ToList();
                else
                    pagedList = li.Where(x => x.QuestionTitle.Contains(Title) && x.GradeName == GradeName && x.BookIDName == BookName && x.ChapterIDName == ChapterName).ToList();
            }
            else
            {
                if (GradeName == "全部")
                    pagedList = li.ToList();
                else if (BookName == "全部")
                    pagedList = li.Where(x => x.GradeName == GradeName).ToList();
                else if (ChapterName == "全部")
                    pagedList = li.Where(x => x.GradeName == GradeName && x.BookIDName == BookName).ToList();
                else
                    pagedList = li.Where(x => x.GradeName == GradeName && x.BookIDName == BookName && x.ChapterIDName == ChapterName).ToList();
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        public List<QuestionS> Show()
        {
            Teacher te = Session["User"] as Teacher;
            List<QuestionS> li = new List<QuestionS>();
            foreach (var item in ef.Questions.ToList().Where(x=>x.CreatorID==2 && x.Shan==false))
            {
                li.Add(new QuestionS()
                {
                    BookIDName = ef.TextBooks.FirstOrDefault(x => x.BookID == item.BookID && x.Shan==false).BookName,
                    ChapterIDName = ef.Chapters.FirstOrDefault(x => x.ChapterID == item.ChapterID && x.Shan == false).ChapterName,
                    CreatorName = ef.Teachers.FirstOrDefault(x => x.TeacherID == item.CreatorID && x.Shan == false).UserName,
                    QuestionID = item.QuestionID,
                    QuestionLevel = item.QuestionLevel,
                    QuestionTitle = item.QuestionTitle,
                    QuestionType = item.QuestionType == true ?  "双选题":"单选题" ,
                    GradeName = ef.Grades.FirstOrDefault(a => a.GradeID == ef.TextBooks.FirstOrDefault(x => x.BookID == item.BookID && x.Shan == false).GradeID && a.Shan == false).GradeName,
                    CheckTime = item.CheckTime.ToString()
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

            foreach (var item in ef.TextBooks.Where(x => x.GradeID == ef.Grades.FirstOrDefault(a => a.GradeName == GradeID && a.Shan == false).GradeID && x.Shan == false).ToList())
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

            foreach (var item in ef.Chapters.Where(x => x.BookID == ef.TextBooks.FirstOrDefault(a => a.BookName == Chapter && a.Shan == false).BookID && x.Shan == false).ToList())
            {
                li.Add(new Chapter() { ChapterID = item.ChapterID, ChapterName = item.ChapterName });
            }
            li.Insert(0, new Chapter() { ChapterID = -1, ChapterName = "全部" });
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
            foreach (var item in ef.Grades.Where(x=>x.Shan==false).ToList())
            {
                li.Add(new Grade() { GradeID = item.GradeID, GradeName = item.GradeName });
            }
            li.Insert(0, new Grade() { GradeName = "全部", GradeID = -1 });
            return Json(li, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Anser(string an,string b)
        {
            try
            {
                List<Question> list = ef.Questions.Where(x=>x.Shan==false).ToList();
                Answer tae = new Answer() { Shan = false, AnswerContent = an, IsResult = b == "0" ? false : true };
                tae.QuestionID = list[list.Count - 1].QuestionID;
                ef.Entry(tae).State = EntityState.Added;
                ef.SaveChanges();
                return Content("");
            }
            catch(Exception ex)
            {
                return Content(ex.ToString());
            }
            
        }

    }
}