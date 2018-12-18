using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using PagedList.Mvc;

namespace Exam.Controllers
{
    /// <summary>
    /// 教材管理
    /// </summary>
    public class BookController : Controller
    {
        ExamSysEntities ef = new ExamSysEntities();
        // GET: Book
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List()
        {
            return View();
        }
    }
}