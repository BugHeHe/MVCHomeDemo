using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using Exam.Models;
using Exam.Models.ViewModels;
using System.Web.Mvc;
using Exam.Filter;

namespace Exam.Controllers
{
    public class PaperRuleController : Controller
    {
        ExamSysEntities1 ef = new ExamSysEntities1();
        // GET: PaperRule
        [LoginHou]
        public ActionResult Index()
        {
            var li = new List<SelectListItem>();
            foreach (var item in ef.Grades.ToList())
            {
                li.Add(new SelectListItem() { Text = item.GradeName, Value = item.GradeID.ToString() });
            }
            SelectListItem lis = new SelectListItem() { Text = "全部", Value = "-1" };
            li.Insert(0, lis);
            ViewData["BookGrade"] = li;
            return View();
        }

        public ActionResult List(string page, string GradeID, string TiN)
        {

            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<PaperRuleS> li = Shou();

            int CountYe = li.Count % 10 > 0 ? (li.Count / 10) + 1 : li.Count / 10;
            var Tili = new { Li = li.Skip((ye - 1) * 10).Take(10), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Select(string page, string GradeID, string TiN)
        {
            int ye = Convert.ToInt32(page) == 0 ? 1 : Convert.ToInt32(page);
            List<PaperRuleS> li = Shou();
            List<PaperRuleS> pagedList = null;
            int GradID = Convert.ToInt32(GradeID);
            Grade GrNa = ef.Grades.FirstOrDefault(x => x.GradeID == GradID);
            if (!string.IsNullOrEmpty(TiN) && !string.IsNullOrEmpty(GradeID))
            {
                if (GradID >= 1)
                {
                    pagedList = li.Where(x => x.RuleName.Contains(TiN) && x.GradeIDName == GrNa.GradeName).Skip((ye - 1) * 10).Take(10).ToList();
                }
                else
                    pagedList = li.Where(x => x.RuleName.Contains(TiN)).ToList();

            }
            else if (string.IsNullOrEmpty(TiN) && GradID >= 1)
            {
                pagedList = li.Where(x => x.GradeIDName == GrNa.GradeName).ToList();
            }
            else if (string.IsNullOrEmpty(GradeID))
            {
                pagedList = li.Where(x => x.RuleName.Contains(TiN)).ToList();
            }
            else
            {
                pagedList = li.ToList();
            }
            int CountYe = pagedList.Count % 10 > 0 ? (pagedList.Count / 10) + 1 : pagedList.Count / 10;
            var Tili = new { Li = pagedList.Skip((ye - 1) * 10).Take(10).ToList(), Ye = CountYe, Hang = page };
            return Json(Tili, JsonRequestBehavior.AllowGet);
        }
        public List<PaperRuleS> Shou()
        {
            List<PaperRuleS> li = new List<PaperRuleS>();
            foreach (var item in ef.PaperRules.Where(x=>x.Shan==false).ToList())
            {
                li.Add(new PaperRuleS()
                {
                    CreateTime=item.CreateTime.ToString(),
                    CreatorIDName=ef.Teachers.FirstOrDefault(x=>x.TeacherID==item.CreatorID).TeacherName,
                    GradeIDName=ef.Grades.FirstOrDefault(x=>x.GradeID==item.GradeID).GradeName,
                    RuleID=item.RuleID,
                    RuleName=item.RuleName
                });
            }
            return li;
        }

        [HttpPost]
        public ActionResult ADD(PaperRuleS te)
        {
            try
            {
                int grade = Convert.ToInt32(te.GradeIDName);
                //首先判断是否有数据  
                if(ef.PaperRules.FirstOrDefault(x=>x.RuleName==te.RuleName && x.Shan == true)!=null)
                {
                    if (grade == ef.PaperRules.FirstOrDefault(x => x.RuleName == te.RuleName).GradeID)
                    {
                        PaperRule tae = ef.PaperRules.FirstOrDefault(x => x.RuleName == te.RuleName);
                        tae.CreateTime = DateTime.Now;
                        tae.Shan = false;
                        ef.Entry(tae).State = EntityState.Modified;
                        if (ef.SaveChanges() > 0)
                            return Content("增加成功");
                    }
                    else
                    {
                       return Content(Updashow(grade,te));
                    }
                    return Content("数据库中有包含的数据");
                }
                else
                {
                    //没有数据
                    return Content(ADDshow(grade,te));
                }
                return Content("空");
                #region MyRegion
                //if (ef.PaperRules.Any(x => x.RuleName == te.RuleName))
                //{
                //    if (ef.PaperRules.FirstOrDefault(x => x.RuleName == te.RuleName && x.GradeID==grade && x.Shan==false)==null)
                //    {
                //        PaperRule Rule = ef.PaperRules.FirstOrDefault(x => x.RuleName == te.RuleName);
                //        Rule.Shan = false;
                //        Rule.CreateTime = DateTime.Now;
                //        if (Rule.GradeID == grade)
                //        {
                //            ef.Entry(Rule).State = EntityState.Modified;
                //            ef.SaveChanges();
                //            return Content(ADDshow(grade, Rule));
                //        }
                //        else
                //        {
                //            return Content(ADDshow(grade, Rule));
                //        }

                //}
                //    return Content("已经存在");

                //}
                //else
                //    {
                //        //计算拥有的题目数量
                //        int suan = ef.Questions.Where(x => x.BookID == ef.TextBooks.FirstOrDefault(a => a.GradeID == grade && x.Shan == false).BookID && x.Shan == false).ToList().Count;
                //        List<TextBook> TextBookCount = ef.TextBooks.Where(x => x.GradeID == grade && x.Shan == false).ToList();
                //        int Ping = 50 % TextBookCount.Count;
                //        bool flage = true;
                //        int sum = 0;
                //        for (int i = 0; i < TextBookCount.Count; i++)
                //        {
                //            int BookIDa = TextBookCount[i].BookID;
                //            int jie = ef.Questions.Where(x => x.BookID == BookIDa && x.Shan == false).ToList().Count;
                //            sum += jie;
                //            if (sum < 50)
                //                flage = false;
                //        }
                //        if (flage)
                //        {
                //            Teacher tea = Session["User"] as Teacher;
                //            PaperRule ta = new PaperRule()
                //            {
                //                GradeID = Convert.ToInt32(te.GradeIDName),
                //                CreateTime = DateTime.Now,
                //                RuleName = te.RuleName,
                //                CreatorID = 1
                //            };
                //            ef.Entry(ta).State = EntityState.Added;
                //            ef.SaveChanges();
                //            Grade gr = ef.Grades.FirstOrDefault(x => x.GradeID == ta.GradeID);
                //            List<TextBook> li = ef.TextBooks.Where(x => x.GradeID == gr.GradeID).ToList();
                //            int chu = 50 % li.Count;
                //            List<PaperRule> listPa = ef.PaperRules.ToList();
                //            for (int i = 0; i < li.Count; i++)
                //            {
                //                RuleDetail Ru = new RuleDetail();
                //                Ru.RuleID = listPa[listPa.Count - 1].RuleID;
                //                Ru.BookID = li[i].BookID;
                //                Ru.QuestionCount = i == 0 ? ((50 - chu) / li.Count) + chu : (50 - chu) / li.Count;
                //                Ru.QuestionLevel = 1;
                //                Ru.Shan = false;
                //                ef.Entry(Ru).State = EntityState.Added;
                //                ef.SaveChanges();
                //            }
                //            return Content("增加成功");
                //        }
                //        else
                //        {
                //            return Content("题数量不够，不能进行抽题");
                //        }
                //    }
                #endregion


            }
            catch (Exception ex)
            {
                return Content(ex.ToString());
            }
            
        }
        [HttpPost]
        public ActionResult Clear(PaperRuleS  te)
        {
            try
            {
                string name = te.RuleName;
               PaperRule ga=ef.PaperRules.FirstOrDefault(x => x.RuleName == name);
                ga.Shan = true;
                ef.Entry(ga).State= EntityState.Modified;
                if (ef.SaveChanges() > 0)
                {
                    return Content("删除成功");
                }
                else
                    return Content("失败");
            }
            catch (Exception ex)
            {
                return Content(ex.ToString());
            }
        }

        //private void NewMethod(string name)
        //{
        //    List<Paper> PaperDeLi = ef.Papers.Where(x => x.RuleID == ef.PaperRules.FirstOrDefault(a => a.RuleName == name).RuleID).ToList();
        //    for (int i = 0; i < PaperDeLi.Count; i++)
        //    {
        //        ef.Papers.Remove(PaperDeLi[i]);
        //        ef.SaveChanges();
        //    }
        //    List<PaperDetail> li = ef.PaperDetails.Where(x => x.PaperID == ef.Papers.FirstOrDefault(a => a.RuleID == ef.PaperRules.FirstOrDefault(b => b.RuleName == name).RuleID).PaperID).ToList();
        //    for (int i = 0; i < li.Count; i++)
        //    {
        //        ef.PaperDetails.Remove(li[i]);
        //        ef.SaveChanges();
        //    }
           
        //}

        [HttpPost]
        public ActionResult Update(PaperRuleS te)
        {
            ef.Configuration.ProxyCreationEnabled = false;
            ef.Configuration.LazyLoadingEnabled = false;
            try
            {
                int grade = Convert.ToInt32(te.GradeIDName) ;
                
                if (ef.PaperRules.All(x => x.RuleName == te.RuleName))
                {
                    PaperRule a = ef.PaperRules.FirstOrDefault(x => x.RuleName == te.RuleName && x.Shan == false);
                    ef.Entry(a).State = EntityState.Modified;
                    if (ef.SaveChanges() > 0)
                    {
                        return Content("修改成功");
                    }
                    return Content("添加失败");
                }
                else
                    return Content("策略名称已经有了");
            }
            catch
            {
                return Content("请输入正确的姓名");
            }
            
        }

        public string ADDshow(int grade,PaperRuleS te)
        {
            int suan = ef.Questions.Where(x => x.BookID == ef.TextBooks.FirstOrDefault(a => a.GradeID == grade && x.Shan == false).BookID && x.Shan == false).ToList().Count;
            List<TextBook> TextBookCount = ef.TextBooks.Where(x => x.GradeID == grade && x.Shan == false).ToList();
            int Ping = 50 % TextBookCount.Count;
            bool flage = true;
            int sum = 0;
            for (int i = 0; i < TextBookCount.Count; i++)
            {
                int BookIDa = TextBookCount[i].BookID;
                int jie = ef.Questions.Where(x => x.BookID == BookIDa && x.Shan == false).ToList().Count;
                sum += jie;
                if (sum < 50)
                    flage = false;
            }
            if (flage)
            {
                Teacher tea = Session["User"] as Teacher;
                PaperRule ta = new PaperRule()
                {
                    GradeID = Convert.ToInt32(te.GradeIDName),
                    CreateTime = DateTime.Now,
                    RuleName = te.RuleName,
                    CreatorID = 1
                };
                ef.Entry(ta).State = EntityState.Added;
                ef.SaveChanges();
                Grade gr = ef.Grades.FirstOrDefault(x => x.GradeID == ta.GradeID);
                List<TextBook> li = ef.TextBooks.Where(x => x.GradeID == gr.GradeID).ToList();
                int chu = 50 % li.Count;
                List<PaperRule> listPa = ef.PaperRules.ToList();
                for (int i = 0; i < li.Count; i++)
                {
                    RuleDetail Ru = new RuleDetail();
                    Ru.RuleID = listPa[listPa.Count - 1].RuleID;
                    Ru.BookID = li[i].BookID;
                    Ru.QuestionCount = i == 0 ? ((50 - chu) / li.Count) + chu : (50 - chu) / li.Count;
                    Ru.QuestionLevel = 1;
                    Ru.Shan = false;
                    ef.Entry(Ru).State = EntityState.Added;
                    ef.SaveChanges();
                }
                return "增加成功";
            }
            else
            {
                return "题数量不够，不能进行抽题";
            }
        }

        public string Updashow(int grade, PaperRuleS te)
        {
            int suan = ef.Questions.Where(x => x.BookID == ef.TextBooks.FirstOrDefault(a => a.GradeID == grade && x.Shan == false).BookID && x.Shan == false).ToList().Count;
            List<TextBook> TextBookCount = ef.TextBooks.Where(x => x.GradeID == grade && x.Shan == false).ToList();
            int Ping = 50 % TextBookCount.Count;
            bool flage = true;
            int sum = 0;
            for (int i = 0; i < TextBookCount.Count; i++)
            {
                int BookIDa = TextBookCount[i].BookID;
                int jie = ef.Questions.Where(x => x.BookID == BookIDa && x.Shan == false).ToList().Count;
                sum += jie;
                if (sum < 50)
                    flage = false;
            }
            if (flage)
            {
                Teacher tea = Session["User"] as Teacher;
                PaperRule ta = new PaperRule()
                {
                    GradeID = grade,
                    CreateTime = DateTime.Now,
                    RuleName = te.RuleName,
                    CreatorID =tea.TeacherID,
                    Shan = false,
                    RuleID=te.RuleID
                    
                };
                ef.Entry(ta).State = EntityState.Modified;
                ef.SaveChanges();
                List<RuleDetail> List = ef.RuleDetails.Where(x=>x.RuleID==ta.RuleID).ToList();
                for (int i = 0; i <List.Count ; i++)
                {
                    ef.RuleDetails.Remove(List[i]);
                    ef.SaveChanges();
                }
                Grade gr = ef.Grades.FirstOrDefault(x => x.GradeID == ta.GradeID);
                List<TextBook> li = ef.TextBooks.Where(x => x.GradeID == gr.GradeID).ToList();
                int chu = 50 % li.Count;
                for (int i = 0; i < li.Count; i++)
                {
                    RuleDetail Ru = new RuleDetail();
                    Ru.RuleID =ta.RuleID;
                    Ru.BookID = li[i].BookID;
                    Ru.QuestionCount = i == 0 ? ((50 - chu) / li.Count) + chu : (50 - chu) / li.Count;
                    Ru.QuestionLevel = 1;
                    Ru.Shan = false;
                    ef.Entry(Ru).State = EntityState.Added;
                    ef.SaveChanges();
                }
                return "增加成功";
            }
            else
            {
                return "题数量不够，不能进行抽题";
            }
        }
    }
}