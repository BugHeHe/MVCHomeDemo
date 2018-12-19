using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;

namespace Exam.Controllers
{
    public class LoginExamGouController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: LoginExamGou
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Dian(string LoginDeng, string LognPwd)
        {
            List<Teacher> li = ef.Teachers.ToList();
            foreach (var item in li)
            {
                if (item.UserName == LoginDeng && item.Password == LognPwd)
                {
                    Session["User"] = item;
                    return RedirectToAction("Index", "ExamHou");
                }
            }
            return Content("失败");
        }
    }
}