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
using System.Data.Entity;

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
            List<TextBooks> li = Shou();
            
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new {Li=li.Skip((ye-1)*10).Take(10), Ye=CountYe,Hang= page };
             return Json(Tili, JsonRequestBehavior.AllowGet);
        }

       /// <summary>
       /// 查询返回分页 可以根据教材名称以及年级
       /// </summary>
       /// <param name="page"></param>
       /// <param name="GradeID"></param>
       /// <param name="TiN"></param>
       /// <returns></returns>
        [HttpPost]
        public ActionResult Select(string page, string GradeID, string TiN)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<TextBooks> li = Shou();
            List<TextBooks> pagedList = null;
            int GradID = Convert.ToInt32(GradeID);
            Grade GrNa = ef.Grades.FirstOrDefault(x => x.GradeID == GradID);
            if (!string.IsNullOrEmpty(TiN) && !string.IsNullOrEmpty(GradeID))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x => x.BookName == TiN && x.GradeName == GrNa.GradeName).Skip((ye - 1) * 10).Take(10).ToList();
                }else
                    pagedList = li.Where(x => x.BookName == TiN).ToList();

            }
            else if (string.IsNullOrEmpty(TiN) && GradID>=1)
            {
                pagedList = li.Where(x =>x.GradeName == GrNa.GradeName).ToList();
            }
            else if(string.IsNullOrEmpty(GradeID))
            {
                pagedList = li.Where(x => x.BookName == TiN ).ToList();
            }
            else
            {
                pagedList= li.ToList();
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye-1)*10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 添加对象
        /// </summary>
        /// <param name="te"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ADD(TextBook te)
        {
            ef.Entry(te).State= EntityState.Added;
                if (ef.SaveChanges() > 0)
                {
                    return Json(Shou(), JsonRequestBehavior.AllowGet);
                }
                else
                    return Content("失败");
            
        }
        /// <summary>
        /// 清除教材
        /// </summary>
        /// <param name="te"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Clear(TextBook te)
        {
            string name = te.BookName;
            ef.TextBooks.Remove(ef.TextBooks.FirstOrDefault(x =>x.BookName==te.BookName));
            if (ef.SaveChanges() > 0)
            {
                return Json(Shou(), JsonRequestBehavior.AllowGet);
            }
            else
                return Content("失败");
        }
        [HttpPost]
        public ActionResult Update(TextBook te)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            TextBook a = new TextBook() { BookName = te.BookName, GradeID = te.GradeID,BookID=te.BookID};
            ef.Entry(a).State = EntityState.Modified;
            if (ef.SaveChanges() > 0)
            {
                return Json(Shou(),JsonRequestBehavior.AllowGet);
            }
            return Content("失败");
        }
        public List<TextBooks> Shou()
        {
            List<TextBooks> li = new List<TextBooks>();
            foreach (var item in ef.TextBooks.ToList())
            {
                TextBooks Book = new TextBooks();
                Book.BookID = item.BookID;
                Book.BookName = item.BookName;
                Book.GradeName = ef.Grades.FirstOrDefault(x => x.GradeID == item.GradeID).GradeName;
                li.Add(Book);
            }
            return li;
        }
    }
}