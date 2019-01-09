using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using System.Data.Entity;
using Exam.Models.ViewModels;

namespace Exam.Controllers
{
    public class ChapterController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: Chapter
        public ActionResult Index()
        {
            var li = new List<SelectListItem>();
            foreach (var item in ef.TextBooks.Where(x=>x.Shan==false).ToList())
            {
                li.Add(new SelectListItem() { Text = item.BookName, Value = item.BookID.ToString() });
            }
            SelectListItem lis = new SelectListItem() { Text = "全部", Value = "-1" };
            li.Insert(0, lis);
            ViewData["Chapter"] = li;
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
            List<ChapterS> li = Show();
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
            List<ChapterS> li = Show();
            List<ChapterS> pagedList = null;
            int GradID = Convert.ToInt32(TextBookID);
            TextBook GrNa = ef.TextBooks.FirstOrDefault(x =>x.BookID==GradID && x.Shan==false);
            if (!string.IsNullOrEmpty(ChapterName) && !string.IsNullOrEmpty(TextBookID))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x => x.ChapterName.Contains(ChapterName) && x.BookName== GrNa.BookName).Skip((ye - 1) * 10).Take(10).ToList();
                }
                else
                    pagedList = li.Where(x => x.ChapterName.Contains(ChapterName)).ToList();

            }
            else if (string.IsNullOrEmpty(ChapterName) && GradID >= 1)
            {
                pagedList = li.Where(x => x.BookName == GrNa.BookName).ToList();
            }
            else if (string.IsNullOrEmpty(TextBookID))
            {
                pagedList = li.Where(x => x.ChapterName.Contains(ChapterName)).ToList();
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
        /// 添加教材
        /// </summary>
        /// <param name="te"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ADD(Chapter te)
        {
            try
            {

                Chapter ch = new Chapter()
                {
                    BookID = te.BookID,
                    ChapterName = te.ChapterName
                };
                if (ef.Chapters.Any(x => x.ChapterName == te.ChapterName.Trim()))
                {
                    if (ef.Chapters.All(x =>  x.Shan == true && x.BookID==te.BookID))
                    {
                        Chapter ta = ef.Chapters.FirstOrDefault(x => x.ChapterName == te.ChapterName);
                        ta.Shan = false;
                        ef.Entry(ta).State = EntityState.Modified;
                        if (ef.SaveChanges() > 0)
                        {
                            return Content("添加成功");
                        }
                    }
                   else
                        return Content("已经存在了");
                }
                else
                {
                    ch.Shan = false;
                    ef.Entry(ch).State = EntityState.Added;
                    if (ef.SaveChanges() > 0)
                        return Content("添加成功");
                }
                return Content("添加失败");

            }
            catch(Exception ex)
            {
                return Content(ex.ToString());
            }
           
            
        }
        /// <summary>
        /// 清除对象  删除
        /// </summary>
        /// <param name="te"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Clear(Chapter te)
        {
            Chapter ta = ef.Chapters.FirstOrDefault(x => x.ChapterName == te.ChapterName.Trim());
            ta.Shan = true;
            ef.Entry(ta).State = EntityState.Modified;
            if (ef.SaveChanges() > 0)
            {
                return Content("删除成功");
            }
            else
                return Content("失败");
        }
        /// <summary>
        /// 修改章节
        /// </summary>
        /// <param name="te"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Update(Chapter te)
        {
            if (ef.Chapters.All(x => x.ChapterName == te.ChapterName.Trim() && x.ChapterID == te.ChapterID && x.BookID == te.BookID))
                return Content("已经存在了");
            Chapter a = new Chapter() { ChapterID=te.ChapterID,ChapterName=te.ChapterName.Trim(),BookID=te.BookID,Shan=false};
            ef.Entry(a).State = EntityState.Modified;
            if (ef.SaveChanges() > 0)
            {
                return Content("修改成功");
            }
            return Content("失败");
        }
        public List<ChapterS> Show()
        {
            List<ChapterS> li = new List<ChapterS>();
            foreach (var item in ef.Chapters.Where(x => x.Shan == false).ToList())
            {
                li.Add(new ChapterS()
                {
                    ChapterID = item.ChapterID,
                    ChapterName = item.ChapterName,
                    BookName = ef.TextBooks.FirstOrDefault(x => x.BookID == item.BookID).BookName
                });

            }
            return li;
        }

    }
}