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
        public ActionResult List(string page)
        {

            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<ClassS> li = Show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 查询返回分页 可以根据班级名称 教师名称 以及年级下拉框
        /// </summary>
        /// <param name="page"></param>
        /// <param name="GradeID"></param>
        /// <param name="TiN"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Select(string page, string GradeID, string ClassName,string TeacherName)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<ClassS> li = Show();
            List<ClassS> pagedList = null;
            int GradID = Convert.ToInt32(GradeID);
            Grade GrNa = ef.Grades.FirstOrDefault(x => x.GradeID == GradID);
            //条件判断
            if (!string.IsNullOrEmpty(ClassName) && !string.IsNullOrEmpty(GradeID) && !string.IsNullOrEmpty(TeacherName))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x => x.MasterName ==TeacherName && x.GradeName == GrNa.GradeName && x.ClassName==ClassName).Skip((ye - 1) * 10).Take(10).ToList();
                }
                else
                    pagedList = li.Where(x => x.MasterName == TeacherName  && x.ClassName == ClassName).ToList();

            }
            else if (string.IsNullOrEmpty(ClassName) && GradID >= 1 && string.IsNullOrEmpty(TeacherName))
            {
                pagedList = li.Where(x =>x.GradeName==GrNa.GradeName).ToList();
            }
            else if (!string.IsNullOrEmpty(ClassName) && string.IsNullOrEmpty(TeacherName))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x =>x.GradeName == GrNa.GradeName && x.ClassName == ClassName).Skip((ye - 1) * 10).Take(10).ToList();
                }
                else
                    pagedList = li.Where(x =>x.ClassName == ClassName).ToList();
            }
            else if (string.IsNullOrEmpty(ClassName) && !string.IsNullOrEmpty(TeacherName))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x => x.MasterName == TeacherName  && x.GradeName == GrNa.GradeName).Skip((ye - 1) * 10).Take(10).ToList();
                }
                else
                    pagedList = li.Where(x => x.MasterName == TeacherName).ToList();
            }
            else
            {
                pagedList = li.ToList();
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 增加班级
        /// </summary>
        /// <param name="te"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ADD(ClassS te)
        {
            try
            {
                ClassS t = te;
                Class cl = new Class();
                cl.ClassName = te.ClassName;
                cl.GradeID = Convert.ToInt32(t.GradeName);
                Teacher a = ef.Teachers.FirstOrDefault(x => x.TeacherName == t.MasterName);
                foreach (var item in ef.Teachers.ToList())
                {
                    if (item.TeacherName == t.MasterName)
                    {
                        cl.MasterID = item.TeacherID;
                    }
                    if (item.TeacherName == t.TeacharName)
                    {
                        cl.TeacharID = item.TeacherID;
                    }
                }
               
                if (string.IsNullOrEmpty(te.CreateTime))
                {
                    cl.CreateTime = DateTime.Now;
                }
                else
                cl.CreateTime = DateTime.Parse(te.CreateTime);
                ef.Configuration.EnsureTransactionsForFunctionsAndCommands = false;
                ef.Entry(cl).State = EntityState.Added;
                if (ef.SaveChanges() > 0)
                {
                    return Content("增加成功");
                }
                return Content("失败");
            }
            catch
            {
                return Content("请输入正确的班主任名称或者教员名称");
            }
            
        }

        [HttpPost]
        public ActionResult Clear(ClassS te)
        {
           
            ef.Configuration.EnsureTransactionsForFunctionsAndCommands = false;
            ef.Classes.Remove(ef.Classes.FirstOrDefault(x=>x.ClassName==te.ClassName));
            if (ef.SaveChanges() > 0)
            {
                return Content("删除成功");
            }
            else
                return Content("失败");
        }
        public  List<ClassS> Show()
        {
            List<ClassS> li = new List<ClassS>();
            foreach (var item in ef.Classes.ToList())
            {
                li.Add(new ClassS()
                {
                    ClassID = item.ClassID,
                    ClassName = item.ClassName,
                    CreateTime =DateTime.Parse(item.CreateTime.ToString()).ToString("yyyy-MM-dd"),
                    GradeName = ef.Grades.FirstOrDefault(x => x.GradeID == item.ClassID).GradeName,
                    MasterName = ef.Teachers.FirstOrDefault(x => x.TeacherID == item.MasterID).TeacherName,
                    TeacharName = ef.Teachers.FirstOrDefault(x => x.TeacherID == item.TeacharID).TeacherName
                });
            }
            return li;
        }


    }
}