using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using Exam.Models;
using Exam.Models.ViewModels;
using System.Web.Mvc;

namespace Exam.Controllers
{
    public class PaperRuleController : Controller
    {
        // GET: PaperRule
        public ActionResult Index()
        {
            return View();
        }
    }
}