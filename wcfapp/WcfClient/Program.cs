using System;
using System.IO;
using System.ServiceModel;
using System.Threading;

using System.Linq;  
using System.Text;  
using System.Net; 


using System.Collections.Generic;
using System.Collections.Specialized;

using System.Threading.Tasks;
using System.Web;
using System.Net.Http;


namespace HttpClientAPP
{

         class Program   
       {  
           
        static void Main(string[] args)  
        {  
        
            //Console.ReadLine();  
         while (true){
            Call("http://example.com");
            Thread.Sleep(2000);
            AcquireSession("http://front-end");
             Thread.Sleep(2000);
            CallCustomer("http://iis");
            //WriteToFile();
            GetData("https://github.com");
            }

    
        }  
         
        
         
      static void Call(String myurl){
        try{
        WebClient client = new WebClient ();
        client.Headers.Add ("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");

        Stream data = client.OpenRead (myurl);
        StreamReader reader = new StreamReader (data);
        string s = reader.ReadToEnd ();
        Console.WriteLine (s);
        data.Close ();
        reader.Close ();
        }catch (Exception){

        }
    }  
   
    static void AcquireSession(String myurl){
        try{
        WebClient client = new WebClient ();
        client.Headers.Add ("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");

        Stream data = client.OpenRead (myurl);
        StreamReader reader = new StreamReader (data);
        string s = reader.ReadToEnd ();
        Console.WriteLine (s);
        data.Close ();
        reader.Close ();
         }catch (Exception){

        }
    }  

    public static void CallCustomer(String myurl){
        try{
        Thread.Sleep(5000);
        WebClient client = new WebClient ();
        client.Headers.Add ("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");

        Stream data = client.OpenRead (myurl);
        StreamReader reader = new StreamReader (data);
        string s = reader.ReadToEnd ();
        Console.WriteLine (s);
        data.Close ();
        reader.Close ();
         }catch (Exception){

        }

        
    }  
    
   public  static void GetData(String m){ 
         
         var request = (HttpWebRequest)WebRequest.Create(m);
         var response = (HttpWebResponse)request.GetResponse();
         var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
        }


    
}    
}
