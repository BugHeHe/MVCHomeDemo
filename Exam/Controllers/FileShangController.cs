using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Exam.Models;
using Exam.Models.ViewModels;

namespace Exam.Controllers
{
    public class FileShangController : Controller
    {
        // GET: FileShang
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult File()
        {
            try
            {
                //物理路径
                string path = Server.MapPath("~/images/");
                //Filesp[]写前台页面 input文件的name名称
                HttpPostedFileBase file = Request.Files["img"];
                string savePath =path+ file.FileName;
                file.SaveAs(savePath);
                return Content("成功");
            }
            catch(Exception ex)
            {
                return Content(ex.ToString());
            }
        }
        public ActionResult uploadImage(HttpPostedFileBase imageFile)
        {
            try
            {

                string name =Request.Files["img"].ToString();
                string fileName = Path.GetFileName(name);
                string filePath = Server.MapPath("~/Images/" + fileName);
                imageFile.SaveAs(filePath);
                return Content("success");
            }
            catch (Exception ex)
            {
                return Content("fail" + ex);
            }
        }
    }
}