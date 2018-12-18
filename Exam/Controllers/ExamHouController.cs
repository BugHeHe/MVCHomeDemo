using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;

namespace Exam.Controllers
{
    public class ExamHouController : Controller
    {
        // GET: ExamHou
        public ActionResult Index()
        {
            if (Session["User"] == null)
            {
                return RedirectToAction("Index","LoginExamGou");
            }
            return View();
        }
    }
}