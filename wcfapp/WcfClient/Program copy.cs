using System;
using System.IO;
using System.ServiceModel;
using System.Threading;


namespace WcfClient
{
    class Program
    {
        static string host;

        static void Main(string[] args)
        {
            Console.WriteLine("Client OS: {0}", Environment.OSVersion);
            host = Environment.GetEnvironmentVariable("host") ?? "localhost";
            Console.WriteLine("Service Host: {0}", host);
            
            // Coz I wanna keep it running 
            while(true) {
            try{
            Caller("https:/github.com");
            CallViaHttp();
            Thread.Sleep(5000);
            CallViaNetTcp();
            Thread.Sleep(000);
            AppDLogger();

            }catch{
               Console.WriteLine("The master service is down");  
               ErrorHandler();
                Caller("https://appdynamics.com");
            }
            }
        }

         static void Caller(string iuri)
        {
         
            var binding = new BasicHttpBinding();
            var factory = new ChannelFactory<IService1>(binding, iuri);
            var channel = factory.CreateChannel();

            Console.WriteLine(channel.Hello("Calling git via Http"));
        }


        static void CallViaHttp()
        {
        
            var address = string.Format("http://{0}/Service1.svc", host);
            var binding = new BasicHttpBinding();
            var factory = new ChannelFactory<IService1>(binding, address);
            var channel = factory.CreateChannel();

            Console.WriteLine(channel.Hello("WCF via Http"));
        }


        static void CallViaNetTcp()
        {
            var address = string.Format("net.tcp://{0}/Service1.svc", host);
            var binding = new NetTcpBinding(SecurityMode.None);
            var factory = new ChannelFactory<IService1>(binding, address);
            var channel = factory.CreateChannel();

            Console.WriteLine(channel.Hello("WCF via Net.Tcp"));
        }
         

        static void AppDLogger(){
           string path = "client.log";
            using (StreamWriter sw = File.AppendText(path)) 
           {
            sw.WriteLine(DateTime.Now+" Server is up, job done");
           }
        }
      
       static void ErrorHandler(){
           Thread.Sleep(5000);
           Console.WriteLine("Calling Error");

      }


    }
}
