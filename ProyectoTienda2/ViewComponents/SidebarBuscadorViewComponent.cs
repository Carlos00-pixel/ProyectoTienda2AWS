using Azure.Storage.Blobs;
using Azure.Storage.Sas;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Newtonsoft.Json;
using ProyectoTienda2.Helpers;
using ProyectoTienda2.Models;
using ProyectoTienda2.Services;
using PyoyectoNugetTienda;
using System.Collections.Generic;

namespace ProyectoTienda2.ViewComponents
{
    [ViewComponent(Name = "SidebarBuscador")]
    public class SidebarBuscadorViewComponent : ViewComponent
    {
        private ServiceApi service;
        private string BucketUrl;
        string miSecreto = HelperSecretManager.GetSecretAsync().Result;

        public SidebarBuscadorViewComponent(ServiceApi service, IConfiguration configuration)
        {
            this.service = service;
            KeysModel model = JsonConvert.DeserializeObject<KeysModel>(miSecreto);
            this.BucketUrl = model.BucketUrl;
        }

        public async Task<IViewComponentResult> InvokeAsync(string query)
        {
            DatosArtista artistas;
                artistas = await this.service.GetArtistasAsync();
            ViewData["BUCKETURL"] = this.BucketUrl;
            return View(artistas);
        }

    }
}
