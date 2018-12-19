using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using PagedList.Mvc;
using Exam.Controllers;
using Exam.Models.ViewModels;

namespace Exam.Controllers
{
    /// <summary>
    /// 教材管理
    /// </summary>
    public class BookController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Book
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List()
        {
            List<TextBooks> li = new List<TextBooks>();
            foreach (var item in ef.TextBooks.ToList())
            {
                li.Add(new TextBooks()
                {
                    BookID = item.BookID,
                    BookName = item.BookName,
                    GradeName = ef.Grades.FirstOrDefault(x => x.GradeID == item.GradeID).GradeName
                });
            }
            return Json(li.Skip((1- 1) * 10).Take(20).ToList(),JsonRequestBehavior.AllowGet);
        }
    }
}