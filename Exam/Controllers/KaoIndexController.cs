using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using Exam.Models;

namespace Exam.Controllers
{
    public class KaoIndexController : Controller
    {
        // GET: KaoIndex
        public ActionResult Index()
        {
            return View();
        }
    }
}