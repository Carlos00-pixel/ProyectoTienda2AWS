using Azure.Storage.Blobs;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using ProyectoTienda2.Data;
using ProyectoTienda2.Services;

var builder = WebApplication.CreateBuilder(args);

string azureKeys = builder.Configuration.GetValue<string>("AzureKeys:StorageAccount");
BlobServiceClient blobServiceClient = new BlobServiceClient(azureKeys);
builder.Services.AddTransient<BlobServiceClient>(x => blobServiceClient);

// Add services to the container.
string connectionString = builder.Configuration.GetConnectionString("MySqlProyectoTienda");

builder.Services.AddTransient<ServiceApi>();
builder.Services.AddTransient<ServiceStorageBlobs>();
builder.Services.AddTransient<ServiceAwsCache>();
builder.Services.AddDbContext<ProyectoTiendaContext>
    (options => options.UseMySql(connectionString
    , ServerVersion.AutoDetect(connectionString)));
builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = "cache-proyecto-tienda.1xwnbt.ng.0001.use1.cache.amazonaws.com:6379";
    options.InstanceName = "cache-proyecto-tienda";
});

builder.Services.AddDistributedMemoryCache();
builder.Services.AddHttpContextAccessor();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
});

builder.Services.AddAntiforgery();
builder.Services.AddControllersWithViews(options => options.EnableEndpointRouting = false);

//SEGURIDAD
builder.Services.AddAuthentication(options =>
{
    options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
}).AddCookie(
    CookieAuthenticationDefaults.AuthenticationScheme,
    config =>
    {
        config.AccessDeniedPath = "/Cliente/ErrorAccesoCliente";
    });

builder.Services.AddControllersWithViews(options =>
options.EnableEndpointRouting = false)
    .AddSessionStateTempDataProvider();

builder.Services.AddHttpContextAccessor();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.UseSession();

app.UseMvc(route =>
{
    route.MapRoute(
        name: "default",
        template: "{controller=Home}/{action=Index}/{id?}");
});

app.Run();