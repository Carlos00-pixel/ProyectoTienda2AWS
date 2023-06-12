using Microsoft.AspNetCore.Mvc;
using System.Net.Mail;
using System.Net;

namespace ProyectoTienda2.Controllers
{
    public class EmailsController : Controller
    {
        private IConfiguration configuration;

        public EmailsController(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index
            (string email, string subject, string body)
        {
            string user = this.configuration.GetValue<string>
                ("AWS:EmailCredentials:User");
            string emailSender =
                this.configuration.GetValue<string>
                ("AWS:EmailCredentials:Email");
            string server = this.configuration.GetValue<string>
                ("AWS:EmailCredentials:Server");
            string password = this.configuration.GetValue<string>
                ("AWS:EmailCredentials:Password");
            MailMessage message = new MailMessage();
            //FROM: CUENTA DEL SENDER DE AWS
            message.From = new MailAddress(emailSender);
            message.To.Add(new MailAddress(email));
            message.Subject = subject;
            message.Body = body;
            //CONFIGURAMOS LAS CREDENCIALES DE NUESTRO SERVICIO
            NetworkCredential credentials =
                new NetworkCredential(user, password);
            //CONFIGURAMOS EL SERVIDOR SMTP
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Host = server;
            smtpClient.Port = 25;
            smtpClient.EnableSsl = true;
            smtpClient.UseDefaultCredentials = true;
            smtpClient.Credentials = credentials;
            await smtpClient.SendMailAsync(message);
            ViewData["MENSAJE"] = "Mail enviado correctamente";
            return View();
        }

    }
}
