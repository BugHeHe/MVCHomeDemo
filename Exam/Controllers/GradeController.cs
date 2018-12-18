using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;

namespace Exam.Controllers
{
    /// <summary>
    /// 年级管理
    /// </summary>
    public class GradeController : Controller
    {

        ExamSysEntities ef = new ExamSysEntities();
        // GET: Grade
        public ActionResult Index()
        {
            return View();
        }
       /// <summary>
       /// 查询所有的年级对象
       /// </summary>
       /// <returns></returns>
        public ActionResult List()
        {
            ef.Configuration.ProxyCreationEnabled = false;
            return Json(ef.Grades.ToList(), JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 查询单个 或者模糊查询
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Select(string Name)
        {
            string nae = Name;
            ef.Configuration.ProxyCreationEnabled = false;
            List<Grade> li = ef.Grades.Where(x => x.GradeName == Name).ToList();
            return Json(li, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 根据年级名称 添加年级对象
        /// </summary>
        /// <param name="GradeName"></param>
        /// <returns></returns>
        [HttpPost] 
        public ActionResult ADD(string GradeName)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            List<Grade> list = ef.Grades.ToList();
            if (list.Any(i => i.GradeName == GradeName))
                return Content("失败");
            ef.Grades.Add(new Grade() { GradeName= GradeName });
            ef.SaveChanges();
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 根据年级名称 删除指定的年级对象
        /// </summary>
        /// <param name="GradeN"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Clear(string GradeN)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            List<Grade> list = ef.Grades.ToList();
            ef.Grades.Remove(list.FirstOrDefault(x=>x.GradeName==GradeN));
            ef.SaveChanges();
            return Json(list, JsonRequestBehavior.AllowGet);
        }
    }
}