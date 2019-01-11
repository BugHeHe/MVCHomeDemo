using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using Exam.Models.ViewModels;
using System.Data.Entity;
namespace Exam.Controllers
{
    public class LoginController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string Shen,string Mi)
        {
            if(ef.Students.FirstOrDefault(x=>x.CardID==Shen && x.Password==Mi && x.Shan == false) != null)
            {
                Session["Student"] = ef.Students.FirstOrDefault(x => x.CardID == Shen && x.Password == Mi && x.Shan == false);
                return Content("登录成功");
            }
            else
            {
                return Content("登录失败");
            }
        }
    }
}