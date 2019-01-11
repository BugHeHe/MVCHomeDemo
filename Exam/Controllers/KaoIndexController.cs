using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using Exam.Models;
using Exam.Filter;

namespace Exam.Controllers
{
    public class KaoIndexController : Controller
    {
        // GET: KaoIndex
        [Login]
        public ActionResult Index()
        {
            return View();
        }
        [Login]
        public ActionResult Kao()
        {
            return View();
        }
        public ActionResult Exit()
        {
            Session["Student"] = null;
            return RedirectToAction("Index", "Login");
        }
    }
}