using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exam.Models
{
    public class LeiFen
    {
        public static string[] FenList(string ku)
        {
             string[] so = ku.Split(',');
             return so;

        }
    }
}