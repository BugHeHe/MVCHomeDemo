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
    public class TeacherController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Teacher
        public ActionResult Index()
        {
            var li = new List<SelectListItem>();
            foreach (var item in ef.Roles.ToList())
            {
                li.Add(new SelectListItem() { Text =item.RoleName, Value = item.RoleID.ToString() });
            }
            SelectListItem lis = new SelectListItem() { Text = "全部", Value = "-1" };
            li.Insert(0, lis);
            ViewData["Chapter"] = li;
            return View();
        }

       /// <summary>
       /// 返回list集合
       /// </summary>
       /// <param name="page"></param>
       /// <returns></returns>
        public ActionResult List(string page)
        {

            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<TeacherS> li = Show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 查询返回分页 可以根据章节名称以及教材
        /// </summary>
        /// <param name="page"></param>
        /// <param name="GradeID"></param>
        /// <param name="TiN"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Select(string page, string TextBookID, string ChapterName)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<TeacherS> li = Show();
            List<TeacherS> pagedList = null;
            int GradID = Convert.ToInt32(TextBookID);
            Role GrNa = ef.Roles.FirstOrDefault(x => x.RoleID == GradID);
            if (!string.IsNullOrEmpty(ChapterName) && !string.IsNullOrEmpty(TextBookID))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x => x.TeacherName == ChapterName && x.RoleName == GrNa.RoleName).Skip((ye - 1) * 10).Take(10).ToList();
                }
                else
                    pagedList = li.Where(x => x.TeacherName == ChapterName).ToList();

            }
            else if (string.IsNullOrEmpty(ChapterName) && GradID >= 1)
            {
                pagedList = li.Where(x => x.RoleName == GrNa.RoleName).ToList();
            }
            else if (string.IsNullOrEmpty(TextBookID))
            {
                pagedList = li.Where(x => x.TeacherName == ChapterName).ToList();
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
        /// 增加对象
        /// </summary>
        /// <param name="te"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ADD(TeacherS te)
        {
            try
            {


                Teacher tea = new Teacher()
                {
                    Password = te.Password,
                    UserName = te.UserName,
                    TeacherName = te.TeacherName
                };
                tea.RoleID = Convert.ToInt32(te.RoleName);
                if (string.IsNullOrEmpty(te.JoinTime))
                    tea.JoinTime = DateTime.Now;
                else
                    tea.JoinTime = DateTime.Parse(te.JoinTime);

                if (ef.Teachers.FirstOrDefault(x =>  x.Shan == true && x.UserName==te.UserName) != null)
                {
                    Teacher taew = ef.Teachers.FirstOrDefault(x => x.Shan == true && x.UserName == te.UserName);
                    taew.Shan = false;
                    taew.RoleID = Convert.ToInt32(te.RoleName);
                    if (string.IsNullOrEmpty(te.JoinTime))
                        taew.JoinTime = DateTime.Now;
                    else
                        taew.JoinTime = DateTime.Parse(te.JoinTime);
                    ef.Entry(taew).State = EntityState.Modified;
                    if (ef.SaveChanges() > 0)
                        return Content("添加成功");
                }
                else
                {
                    tea.Shan = false;
                    ef.Entry(tea).State = EntityState.Added;
                    if (ef.SaveChanges() > 0)
                        return Content("添加成功");
                }
                return Content("");

                //ef.Entry(tea).State = EntityState.Added;
                //if (ef.SaveChanges() > 0)
                //    return Content("添加成功");
                //else
                //    return Content("失败");
            }
            catch
            {
                return Content("有错误,请重新输入");
            }
        }

        [HttpPost]
        public ActionResult Clear(TeacherS te)
        {
            try
            {
                
                Teacher tea = ef.Teachers.FirstOrDefault(x => te.TeacherID == x.TeacherID && te.TeacherName == x.TeacherName);
                tea.Shan = true;
                ef.Entry(tea).State = EntityState.Modified;
                if (ef.SaveChanges() > 0)
                    return Content("删除成功");
                else
                    return Content("删除失败");
            }
            catch
            {
                return Content("遇到错误");
            }
        }

        [HttpPost]
        public ActionResult Update(TeacherS te)
        {
            try
            {
                Teacher tea = new Teacher()
                {
                    Password = te.Password,
                    UserName = te.UserName,
                    TeacherName = te.TeacherName
                };
                tea.RoleID = Convert.ToInt32(te.RoleName);
                if (string.IsNullOrEmpty(te.JoinTime))
                    tea.JoinTime = DateTime.Now;
                else
                    tea.JoinTime = DateTime.Parse(te.JoinTime);
                tea.TeacherID = te.TeacherID;
                ef.Entry(tea).State = EntityState.Modified;
                if (ef.SaveChanges() > 0)
                    return Content("修改成功");
                else
                    return Content("失败");
            }
            catch
            {
                return Content("出现错误");
            }
        }
        public List<TeacherS> Show()
        {
            List<TeacherS> li = new List<TeacherS>();
            foreach (var item in ef.Teachers.Where(x=>x.Shan==false).ToList())
            {
                li.Add(new TeacherS()
                {
                    JoinTime = item.JoinTime.ToString("yyyy-MM-dd"),
                    Password=item.Password,
                    RoleName=ef.Roles.FirstOrDefault(x=>x.RoleID==item.RoleID).RoleName,
                    TeacherID=item.TeacherID,
                    TeacherName=item.TeacherName,
                    UserName=item.UserName
                });
            }
            return li;
        }
    }
}