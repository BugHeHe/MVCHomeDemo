using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using System.Data.Entity;

namespace Exam.Controllers
{
    public class PaperTypeController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: PaperType
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
            List<PaperType> li = Show();
            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.OrderBy(x=>x.TypeID).Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Select(string page, string Name)
        {

            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<PaperType> li = Show();
            List<PaperType> pagedList = null;
            if (!string.IsNullOrEmpty(Name))
            {
                pagedList = li.Where(x => x.TypeName.Contains(Name)).ToList();
            }
            else
                pagedList = li;
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult ADD(PaperType te)
        {
            try
            {
                if (ef.PaperTypes.FirstOrDefault(x => x.TypeName == te.TypeName && x.Shan==true) != null)
                {
                    PaperType ta = ef.PaperTypes.FirstOrDefault(x => x.TypeName == te.TypeName);
                    ta.Shan = false;
                    ef.Entry(ta).State = EntityState.Modified;
                    if (ef.SaveChanges() > 0)
                        return Content("添加成功");
                }
                else
                {
                    te.Shan = false;
                    ef.Entry(te).State = EntityState.Added;
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
        public ActionResult Update(PaperType te)
        {
            try
            {
                if(ef.PaperTypes.FirstOrDefault(x=>x.TypeName==te.TypeName) != null)
                {

                    return Content("已经拥有了该名称");
                }
                else
                {
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
        [HttpPost]
        public ActionResult Clear(PaperType te)
        {
            try
            {
                PaperType ta = ef.PaperTypes.FirstOrDefault(x => x.TypeID == te.TypeID && x.TypeName == te.TypeName);
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

        public List<PaperType> Show()
        {
            List<PaperType> li = new List<PaperType>();
            foreach (var item in ef.PaperTypes.Where(x=>x.Shan==false).ToList())
            {
                li.Add(new PaperType() { TypeID=item.TypeID,TypeName=item.TypeName });
            }
            return li;
        }
    }
}