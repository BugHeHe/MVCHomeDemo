using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using Exam.Models;
using Exam.Filter;

namespace Exam.Controllers
{
    public class KaoIndexController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        int i = 0;
        // GET: KaoIndex
        [Login]
        public ActionResult Index()
        {
            return View();
        }
        [Login]
        public ActionResult Kao(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return  RedirectToAction("Index", "Login");
            }
            ViewData["Num"] =id.ToString();
            Student bian= Session["Student"] as Student;
            int Id1 = Convert.ToInt32(id);
            if(ef.StuQueRecords.FirstOrDefault(x=>x.PaperID==Id1 && x.StudetnID == bian.StudentID)!=null)
            {

            }
            else
            {
                StuQueRecord jin = new StuQueRecord()
                {
                    RecordTime = DateTime.Now,
                    PaperID = Convert.ToInt32(id),
                    StudetnID = bian.StudentID
                };
                ef.Entry(jin).State = EntityState.Added;
                ef.SaveChanges();
            }
            return View();
        }
        public ActionResult Exit()
        {
            Session["Student"] = null;
            return RedirectToAction("Index", "Login");
        }

        public ActionResult Begin(string id)
        {
            i = Convert.ToInt32(id);
            return RedirectToAction("Kao", "KaoIndex");
        }

        /// <summary>
        /// 做题明细表
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Detail(string QuestionID,string Answer)
        {
            try
            {
                List<StuQueRecord> list = ef.StuQueRecords.ToList();
                int RecordID = 0;
                int QuestionId = Convert.ToInt32(QuestionID);
                int Answ = Convert.ToInt32(Answer);
                if (list.Count == 0)
                {
                    RecordID = list[list.Count].RecordID;
                }
                else
                {
                    RecordID = list[list.Count - 1].RecordID;
                }
                StuQueRecordDetail li = new StuQueRecordDetail();
                li.AnswerID = Answ;
                li.QuestionID = QuestionId;
                li.RecordID = RecordID;
                ef.Entry(li).State = EntityState.Added;
                ef.SaveChanges();
                return Content("1");
            }
            catch(Exception ex)
            {
                return Content(ex.ToString());
            }
        }
    }
}