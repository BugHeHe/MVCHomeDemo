using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using System.Data.Entity;

namespace Exam.Controllers
{
    public class RoleController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Role
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <param name="page"></param>
        /// <returns></returns>
        public ActionResult List(string page)
        {

            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<Role> li = Show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Select(string page, string Name)
        {

            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<Role> li = Show();
            List<Role> pagedList = null;
            if (!string.IsNullOrEmpty(Name))
            {
                pagedList = li.Where(x => x.RoleName.Contains(Name)).ToList();
            }
            else
                pagedList = li;
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult ADD(Role re)
        {
            try
            {
                if (ef.Roles.FirstOrDefault(x => x.RoleName ==re.RoleName && x.Shan == true) != null)
                {
                    Role ta = ef.Roles.FirstOrDefault(x => x.RoleName == re.RoleName);
                    ta.Shan = false;
                    ef.Entry(ta).State = EntityState.Modified;
                    if (ef.SaveChanges() > 0)
                        return Content("添加成功");
                }
                else
                {
                    re.Shan = false;
                    ef.Entry(re).State = EntityState.Added;
                    if (ef.SaveChanges() > 0)
                        return Content("添加成功");
                }
                return Content("");
            }
            catch
            {
                return Content("出现错误");
            }
        }
        [HttpPost]
        public ActionResult Clear(Role te)
        {
            try
            {
                Role ta = ef.Roles.FirstOrDefault(x => x.RoleName==te.RoleName && x.RoleID == te.RoleID);
                ta.Shan = true;
                ef.Entry(ta).State = EntityState.Modified;
                if (ef.SaveChanges() > 0)
                    return Content("删除成功");
                else
                    return Content("失败");
            }
            catch
            {
                return Content("出现错误");
            }
        }
        [HttpPost]
        public ActionResult Update(Role te)
        {
            try
            {

                if (ef.Roles.FirstOrDefault(x => x.RoleName==te.RoleName) != null)
                {

                    return Content("已经拥有了该名称");
                }
                else
                {
                    te.Shan = false;
                    ef.Entry(te).State = EntityState.Modified;
                    if (ef.SaveChanges() > 0)
                        return Content("修改成功");
                }
                return Content("");
            }
            catch
            {
                return Content("出现错误");
            }
        }
        public List<Role> Show()
        {
            List<Role> li = new List<Role>();
            foreach (var item in ef.Roles.Where(x=>x.Shan==false).ToList())
            {
                li.Add(new Role() { Description=item.Description,RoleID=item.RoleID,RoleName=item.RoleName});
            }
            return li;
        }

        [HttpPost]
        public ActionResult RoleShou(string ID)
        {
            List<string> li = new List<string>();
            foreach (var item in ef.Menus)
            {
                string[] jie = item.Roles.Split(',');
                for (int i = 0; i <jie.Length ; i++)
                {
                    if (ID ==jie[i])
                    {
                        li.Add(item.MenuName);
                    }
                }
            }
            return Json(li, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult RoleList(string ID)
        {
            List<string> li = new List<string>();
            foreach (var item in ef.Menus)
            {
                string[] jie = item.Roles.Split(',');
                for (int i = 0; i < jie.Length; i++)
                {
                    if (ID != jie[i])
                    {
                        if (li.Any(x => x == item.MenuName)) { }
                        else
                            li.Add(item.MenuName);
                    }
                }
            }
            return Json(li, JsonRequestBehavior.AllowGet);
        }
    }
}