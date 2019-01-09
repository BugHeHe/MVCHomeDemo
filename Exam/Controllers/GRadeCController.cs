﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Controllers;
using Exam.Models;
using System.Data.Entity;

namespace Exam.Controllers
{
    public class GRadeCController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: GRadeC
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List()
        {
            ef.Configuration.ProxyCreationEnabled = false;
            return Json(ef.Grades.Where(x=>x.Shan==false).ToList(), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Select(string Name)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            if (!string.IsNullOrEmpty(Name))
            {
                return Json(ef.Grades.Where(x => x.GradeName == Name && x.Shan==false).ToList(), JsonRequestBehavior.AllowGet);
            }
            return Content("失败");


        }
        /// <summary>
        /// 根据年级名称 添加年级对象
        /// </summary>
        /// <param name="GradeName"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ADD(string GradeNme)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            string an = GradeNme;
            List<Grade> list = ef.Grades.ToList();
            if (list.Any(i => i.GradeName == GradeNme))
                return Content("已经存在");
            Grade ad = new Grade() {GradeName= GradeNme };
            ad.Shan = false;
            ef.Entry(ad).State = EntityState.Added;
            if(ef.SaveChanges()>0)
            {
                return Content("添加成功");
            }
            return Content("失败");
            
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
            Grade lis = ef.Grades.FirstOrDefault(x => x.GradeName == GradeN);
            lis.Shan = true;
            ef.Entry(lis).State = EntityState.Modified;
            if (ef.SaveChanges() > 0)
            {
                return Content("删除成功");
            }
                return Content("删除失败");
        }
        /// <summary>
        /// 修改年级信息
        /// </summary>
        /// <param name="GradeID"></param>
        /// <param name="GradeNam"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Update(string GradeID,string GradeNam)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            if (ef.Grades.Any(x => x.GradeName == GradeNam))
                return Content("已经存在");
            Grade gr = new Grade() { GradeID = Convert.ToInt32(GradeID), GradeName = GradeNam };
            ef.Entry(gr).State = EntityState.Modified;
            if (ef.SaveChanges() > 0)
            {
                return Content("修改成功");
            }
            return Content("修改失败");
        }
    }
}