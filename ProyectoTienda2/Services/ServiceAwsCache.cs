using Microsoft.Extensions.Caching.Distributed;
using Newtonsoft.Json;
using ProyectoTienda2.Data;
using PyoyectoNugetTienda;
using System.Net.Http.Headers;

namespace ProyectoTienda2.Services
{
    public class ServiceAwsCache
    {
        private MediaTypeWithQualityHeaderValue Header;
        private string UrlApiProyectoTienda;
        private ProyectoTiendaContext context;
        private IDistributedCache cache;

        public ServiceAwsCache(IConfiguration configuration, ProyectoTiendaContext context, IDistributedCache cache)
        {
            this.UrlApiProyectoTienda =
                configuration.GetValue<string>("ApiUrls:ApiProyectoTienda");
            this.Header =
                new MediaTypeWithQualityHeaderValue("application/json");
            this.context = context;
            this.cache = cache;
        }

        private async Task<T> CallApiAsync<T>(string request)
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.UrlApiProyectoTienda);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                HttpResponseMessage response =
                    await client.GetAsync(request);
                if (response.IsSuccessStatusCode)
                {
                    T data = await response.Content.ReadAsAsync<T>();
                    return data;
                }
                else
                {
                    return default(T);
                }
            }
        }

        private async Task<T> CallApiAsync<T>
            (string request, string token)
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri(this.UrlApiProyectoTienda);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(this.Header);
                client.DefaultRequestHeaders.Add
                    ("Authorization", "bearer " + token);
                HttpResponseMessage response =
                    await client.GetAsync(request);
                if (response.IsSuccessStatusCode)
                {
                    T data = await response.Content.ReadAsAsync<T>();
                    return data;
                }
                else
                {
                    return default(T);
                }
            }
        }
        public async Task<List<DatosArtista>> GetFavoritosAsync()
        {

            string jsonArte =
                await this.cache.GetStringAsync("cuadrosfavoritos");
            if (jsonArte == null)
            {
                return null;
            }
            else
            {
                List<DatosArtista> cuadros = JsonConvert.DeserializeObject<List<DatosArtista>>
                    (jsonArte);
                return cuadros;
            }
        }

        public async Task AddFavoritoAsync(DatosArtista cuadro)
        {
            List<DatosArtista> cuadros = await this.GetFavoritosAsync();
            if (cuadros == null)
            {
                cuadros = new List<DatosArtista>();
            }
            cuadros.Add(cuadro);
            string jsonArte = JsonConvert.SerializeObject(cuadros);
            await this.cache.SetStringAsync
                ("cuadrosfavoritos", jsonArte, new DistributedCacheEntryOptions()
                .SetSlidingExpiration(TimeSpan.FromMinutes(30)));
        }

        public async Task DeleteFavoritoAsync(int idfavorito)
        {
            List<DatosArtista> cuadros = await this.GetFavoritosAsync();
            if (cuadros != null)
            {
                DatosArtista cuadroEliminar =
                    cuadros.FirstOrDefault(x => x.infoProducto.IdInfoArte == idfavorito);
                cuadros.Remove(cuadroEliminar);
                if (cuadros.Count == 0)
                {
                    await this.cache.RemoveAsync("cochesfavoritos");
                }
                else
                {
                    string jsonArte = await this.cache.GetStringAsync("cuadrosfavoritos");
                    await this.cache.SetStringAsync
                        ("cochesfavoritos", jsonArte, new DistributedCacheEntryOptions()
                        .SetSlidingExpiration(TimeSpan.FromMinutes(30)));
                }
            }
        }
    }
}
