var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();

// AuthAddition - need to add database connection to use the AspNet tables
var cs = builder.Configuration.GetConnectionString("BlazorAuthDemoConnectionString");
builder.Services.AddDbContext<BlazorAuthDemoDataContext>(options =>
    options.UseSqlServer(cs));

// Not sure if this can be used somehow to change the way that passwords are hashed to make them backwardly compatible...?
//builder.Services.Configure<PasswordHasherOptions>(options =>
//    options.CompatibilityMode = PasswordHasherCompatibilityMode.IdentityV2);

// AuthAddition
builder.Services.AddIdentity<IdentityUser, IdentityRole>()
    .AddEntityFrameworkStores<BlazorAuthDemoDataContext>();

builder.Services.AddSingleton<WeatherForecastService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

// AuthAddition
app.UseAuthentication();
app.UseAuthorization();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
