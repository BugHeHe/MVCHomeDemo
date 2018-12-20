using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using PagedList.Mvc;
using Exam.Controllers;
using Exam.Models.ViewModels;
using PagedList;

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
            
            var li = new List<SelectListItem>();
            foreach (var item in ef.Grades.ToList())
            {
                li.Add(new SelectListItem() { Text = item.GradeName, Value = item.GradeID.ToString() });
            }
            SelectListItem lis = new SelectListItem() {Text="全部",Value="-1" };
            li.Insert(0,lis);
            ViewData["BookGrade"] = li;
            return View();
        }
        public ActionResult List(string  page,string GradeID,string TiN)
        {

            int ye = Convert.ToInt32(page)==0?1: Convert.ToInt32(page);
            List<TextBooks> li = new List<TextBooks>();
            foreach (var item in ef.TextBooks.ToList())
            {
                TextBooks Book = new TextBooks();
                Book.BookID = item.BookID;
                if (!string.IsNullOrEmpty(TiN))
                    Book.BookName =TiN;
                else
                    Book.BookName = item.BookName;
                if (!string.IsNullOrEmpty(GradeID))
                    Book.GradeName = ef.Grades.FirstOrDefault(x => x.GradeID == item.GradeID && x.GradeID == int.Parse(GradeID) ? item.GradeID == int.Parse(GradeID) : x.GradeID == item.GradeID).GradeName;
                else
                    Book.GradeName = ef.Grades.FirstOrDefault(x => x.GradeID == item.GradeID).GradeName;
                li.Add(Book);
             }
             List<TextBooks> pagedList = li.Skip((ye - 1) * 10).Take(10).ToList();
             int CountYe=li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
             var Tili = new {Li=pagedList,Ye=CountYe,Hang= 10 };
             return Json(Tili, JsonRequestBehavior.AllowGet);
        }
    }
}