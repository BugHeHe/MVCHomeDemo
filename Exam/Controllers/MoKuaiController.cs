using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;

namespace Exam.Controllers
{
    public class MoKuaiController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();

        // GET: MoKuai
        public ActionResult Index()
        {
            ViewData["MoKuai"]=Session["User"];
            return View();
        }
    }
}