using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using Exam.Models;
using Exam.Models.ViewModels;

namespace Exam.Controllers
{
    public class ClassController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Class
        public ActionResult Index()
        {
            var li = new List<SelectListItem>();
            foreach (var item in ef.Grades.ToList())
            {
                li.Add(new SelectListItem() { Text = item.GradeName, Value = item.GradeID.ToString() });
            }
            SelectListItem lis = new SelectListItem() { Text = "全部", Value = "-1" };
            li.Insert(0, lis);
            ViewData["Grade"] = li;
            return View();
        }

    }
}