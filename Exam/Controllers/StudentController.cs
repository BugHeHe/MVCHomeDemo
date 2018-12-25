using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models.ViewModels;
using Exam.Models;
using System.Data.Entity;

namespace Exam.Controllers
{
    public class StudentController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Student
        public ActionResult Index()
        {
            var li = new List<SelectListItem>();
            foreach (var item in ef.Classes.ToList())
            {
                li.Add(new SelectListItem() { Text = item.ClassName, Value = item.ClassID.ToString() });
            }
            SelectListItem utem = new SelectListItem() { Text = "不限", Value = "-1" };
            li.Insert(0, utem);
            ViewData["Grade"] = li;
            return View();

        }
        public ActionResult List(string page)
        {

            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<StudentS> li = show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 分页查询返回数据
        /// </summary>
        /// <param name="page"></param>
        /// <param name="ClassID"></param>
        /// <param name="StudentName"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Select(string page, string ClassID, string StudentName)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<StudentS> li = show();
            List<StudentS> pagedList = null;
            int GradID = Convert.ToInt32(ClassID);
            Class GrNa = ef.Classes.FirstOrDefault(x => x.ClassID ==GradID);
            if (!string.IsNullOrEmpty(StudentName) && !string.IsNullOrEmpty(ClassID))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x => x.StudentName == StudentName && x.ClassName == GrNa.ClassName).Skip((ye - 1) * 10).Take(10).ToList();
                }
                else
                    pagedList = li.Where(x => x.StudentName == StudentName).ToList();

            }
            else if (string.IsNullOrEmpty(StudentName) && GradID >= 1)
            {
                pagedList = li.Where(x => x.ClassName == GrNa.ClassName).ToList();
            }
            else if (string.IsNullOrEmpty(ClassID))
            {
                pagedList = li.Where(x => x.StudentName == StudentName).ToList();
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
        /// 返回属于学生类型的集合
        /// </summary>
        /// <returns></returns>
        public List<StudentS> show()
        {
            List<StudentS> li = new List<StudentS>();
            foreach (var item in ef.Students.ToList())
            {
                li.Add(new StudentS()
                {
                    StudentID = item.StudentID,
                    Address = item.Address,
                    Borndate = DateTime.Parse(item.Borndate.ToString()).ToString("yyyy-MM-dd"),
                    Gender = item.Gender ==false? "男" : "女",
                    ClassName = ef.Classes.FirstOrDefault(x => x.ClassID == item.ClassID).ClassName,
                    CreateTime = DateTime.Parse(item.CreateTime.ToString()).ToString("yyyy-MM-dd"),
                    Email = item.Email,
                    Password = item.Password,
                    Phone = item.Phone,
                    StudentName = item.StudentName,
                    CardID=item.CardID

                });
            }
            return li;
        }
    }
}