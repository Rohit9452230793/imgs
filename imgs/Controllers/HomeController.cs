using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using imgs.DAL;
using imgs.Models;

namespace imgs.Controllers
{
    public class HomeController : Controller
    {
        dataAccess DB=new dataAccess();
        private int procId;

        [HttpGet]
        public ActionResult Index()
        {
            image Model = new image();
            if (Request.QueryString["sid"] != null)   // update and fill all value base on id here  using 3 rd storeprocedure
            {
                Model.id = Convert.ToInt32(Request.QueryString["sid"].ToString());
                Model = DB.AddImage(3, Model).ToList().FirstOrDefault();
                ViewBag.buttonName = "Update";
            }
            else
            {
                ViewBag.button = "submit";
            }
            var list1 = DB.AddImage(4, Model).ToList(); // Show data here...; use procuder 4 for show data 
            if (list1.Count > 0)
            {
                ViewBag.list = list1;

            }
            else
            {
                ViewBag.list = null;
            }
            return View(Model);
        }
        [HttpPost]
        public ActionResult Index(image Model, string command, HttpPostedFileBase imgInp)
        {
            if (imgInp != null)
            {
                string prepath = "~/Content/Uploads";
                string path = "";
                var uploadUrl = Server.MapPath(prepath);
                string extension = System.IO.Path.GetExtension(Request.Files["imgInp"].FileName);
                if (extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg" || extension.ToLower() == ".png")
                {
                    if (imgInp.ContentLength > 0)
                    {
                        imgInp = Request.Files["imgInp"];
                        string Name = DateTime.Now.Ticks + "_R" + extension.ToLower().ToString();
                        string pathtosave = prepath + "/" + Name;
                        path = uploadUrl + "/" + Name;
                        Model.Imagepath = pathtosave;
                        imgInp.SaveAs(path);
                    }
                    else
                    {
                        TempData["Message"] = "Please Upload Photo !";
                    }
                }
                else
                {
                    TempData["Message"] = "Please Upload Valid File !";
                }
            }

            if (command == "Submit")
            {
                procId = 1;

            }
            else if (command == "Update")
            {
                procId = 2;
            }
            var list = DB.AddImage(procId, Model).ToList();
            if(list.Count>0)
            {
                if (list[0].msg == "success")
                {
                    TempData["msg"] = "1";
                }
                else if (list[1].msg == "   ")
                {
                    TempData["msg"] = "2";
                }
                else if (list[0].msg == "update")
                {
                    TempData["msg"] = "3";
                }
                else
                {
                    TempData["msg"] = "4";
                }
                ViewBag.list = list;
            }
            else
            {
                ViewBag.list = null;
            }
            return RedirectToAction("Index","Home");
        }
        public JsonResult Delete(int sid) //  delete here   using procedure 5 
        {
            image Model = new image();
            Model.id = sid;
            var data = DB.AddImage(5, Model).ToList().FirstOrDefault();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Update(int Rid) // update here only go on the id form here ........
        {
            image Model = new image();
            return RedirectToAction("Index", new { sid = Rid });
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}