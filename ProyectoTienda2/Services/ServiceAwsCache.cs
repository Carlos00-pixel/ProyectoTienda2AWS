using Microsoft.Extensions.Caching.Distributed;
using Newtonsoft.Json;
using ProyectoTienda2.Data;
using PyoyectoNugetTienda;
using System.Net.Http.Headers;

namespace ProyectoTienda2.Services
{
    public class ServiceAwsCache
    {
        private IDistributedCache cache;

        public ServiceAwsCache(IDistributedCache cache)
        {
            this.cache = cache;
        }

        public async Task<DatosArtista> GetFavoritosAsync()
        {

            string jsonArte =
                await this.cache.GetStringAsync("cuadrosfavoritos");
            if (jsonArte == null)
            {
                return null;
            }
            else
            {
                DatosArtista cuadros = JsonConvert.DeserializeObject<DatosArtista>
                    (jsonArte);
                return cuadros;
            }
        }

        public async Task AddFavoritoAsync(DatosArtista cuadro)
        {
            DatosArtista cuadros = await this.GetFavoritosAsync();
            if (cuadros == null)
            {
                cuadros = new DatosArtista();
            }
            cuadros.listaProductos.Add(cuadro);
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
                    await this.cache.RemoveAsync("cuadrosfavoritos");
                }
                else
                {
                    string jsonArte = await this.cache.GetStringAsync("cuadrosfavoritos");
                    await this.cache.SetStringAsync
                        ("cuadrosfavoritos", jsonArte, new DistributedCacheEntryOptions()
                        .SetSlidingExpiration(TimeSpan.FromMinutes(30)));
                }
            }
        }
    }
}
