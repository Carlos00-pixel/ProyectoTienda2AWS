using Azure.Storage.Blobs;
using Azure.Storage.Sas;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using ProyectoTienda2.Filters;
using ProyectoTienda2.Services;
using PyoyectoNugetTienda;
using System.Drawing;
using System.Security.Claims;
using static System.Net.Mime.MediaTypeNames;

namespace ProyectoTienda2.Controllers
{
    public class ArtistaController : Controller
    {
        private ServiceApi service;
        private ServiceStorageBlobs serviceBlob;
        private string containerName = "proyectotienda";
        private string BucketUrl;

        public ArtistaController(ServiceApi service, ServiceStorageBlobs serviceBlob, IConfiguration configuration)
        {
            this.service = service;
            this.serviceBlob = serviceBlob;
            this.BucketUrl = configuration.GetValue<string>("AWS:BucketUrl");
        }

        public async Task<IActionResult> DetallesArtista(int idartista)
        {

            DatosArtista artista = await this.service.DetailsArtistaAsync(idartista);
            ViewData["CONTARPRODUCT"] = artista.listaProductos.Count;
            //ViewData["PERFIL"] = await this.serviceBlob.GetBlobAsync(this.containerName, artista.artista.Imagen);
            //ViewData["FOTOFONDO"] = await this.serviceBlob.GetBlobAsync(this.containerName, artista.artista.ImagenFondo);
            ViewData["PERFIL"] = this.BucketUrl + artista.artista.Imagen;
            ViewData["FOTOFONDO"] = this.BucketUrl + artista.artista.ImagenFondo;
            ViewData["BUCKETURL"] = this.BucketUrl;
            return View(artista);
        }
        public async Task<IActionResult> PerfilArtista
            (int idartista, int? idInfoArteEliminado)
        {
            DatosArtista artista = new DatosArtista();

            if (idInfoArteEliminado != null)
            {
                await this.service.DeleteInfoArteAsync(idInfoArteEliminado.Value);
            }

            artista = await this.service.DetailsArtistaAsync(idartista);
            ViewData["CONTARPRODUCT"] = artista.listaProductos.Count;
            //ViewData["PERFIL"] = await this.serviceBlob.GetBlobAsync(this.containerName, artista.artista.Imagen);
            //ViewData["FOTOFONDO"] = await this.serviceBlob.GetBlobAsync(this.containerName, artista.artista.ImagenFondo);
            ViewData["PERFIL"] = this.BucketUrl + artista.artista.Imagen;
            ViewData["FOTOFONDO"] = this.BucketUrl + artista.artista.ImagenFondo;
            return View(artista);
        }

        [HttpPost]
        public async Task<IActionResult> PerfilArtista
            (int idartista, IFormFile fileFondo)
        {
            string blobName = fileFondo.FileName;
            using (Stream stream = fileFondo.OpenReadStream())
            {
                await this.serviceBlob.UploadBlobAsync(this.containerName, blobName, stream);
            }
            await this.service.CambiarImagenFondoAsync(idartista, blobName);
            return RedirectToAction("PerfilArtista", new { idartista = int.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value) });
        }

        public async Task<IActionResult> EditarPerfilArtista(int idartista)
        {
            DatosArtista artista = await this.service.DetailsArtistaAsync(idartista);
            return View(artista);
        }

        [HttpPost]
        public async Task<IActionResult> EditarPerfilArtista
            (int idartista, string nombre, string apellidos, string nick, string descripcion,
            string email, IFormFile file)
        {
            DatosArtista artista = new DatosArtista();
            string blobName = file.FileName;
            using (Stream stream = file.OpenReadStream())
            {
                await this.serviceBlob.UploadBlobAsync(this.containerName, blobName, stream);
            }
            idartista = int.Parse(HttpContext.User.FindFirst(ClaimTypes.NameIdentifier).Value);
            await this.service.PerfilArtista
                (idartista, nombre, apellidos, nick, descripcion,
                email, blobName);

            return RedirectToAction("PerfilArtista", new { idartista = idartista });
        }
    }
}
