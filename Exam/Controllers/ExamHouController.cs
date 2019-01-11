using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using Exam.Filter;

namespace Exam.Controllers
{
    public class ExamHouController : Controller
    {
        // GET: ExamHou
        [LoginHou]
        public ActionResult Index()
        {
            
            return View();
        }
    }
}