using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;


namespace aspnetmvcapp.Controllers
{
    public class ValuesController : ApiController
    {
     private static readonly HttpClient client = new HttpClient();
        public int[] GetValues()
        {
            client.GetStringAsync("https://github.com/iogbole");
            client.GetStringAsync("http://www.example.com/recepticle.aspx");
            client.GetStringAsync("https://io.is.me");

            var values = new int[] { 1, 2, 3, 4 };
            return values;
        }
    }
}
