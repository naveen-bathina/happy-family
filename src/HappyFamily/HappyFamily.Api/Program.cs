using HappyFamily.Api.Mappings;
using HappyFamily.Api.Middleware;
using HappyFamily.Application;
using HappyFamily.Infrastructure;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace HappyFamily.Api
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var jwtSettings = builder.Configuration.GetSection("JwtSettings");
            var key = Encoding.UTF8.GetBytes(jwtSettings["SecretKey"] ?? throw new ArgumentNullException("JWT Secret Key is missing!"));

            builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = jwtSettings["Issuer"],
                        ValidAudience = jwtSettings["Audience"],
                        IssuerSigningKey = new SymmetricSecurityKey(key)
                    };
                });

            builder.Services.AddInfrastructure();
            builder.Services.AddApplication();

            builder.Services.AddAutoMapper(typeof(MappingProfile));

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
            builder.Services.AddOpenApi();

            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll",
                    policy => policy.AllowAnyOrigin()
                                    .AllowAnyHeader()
                                    .AllowAnyMethod());
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.MapOpenApi();
            }

            if (app.Environment.IsProduction())
            {
                app.UseHttpsRedirection();
            }
            app.UseMiddleware<ExceptionMiddleware>();
            app.UseAuthentication();
            app.UseAuthorization();

            app.MapControllers();

            app.UseSwaggerUI(options =>
            {
                options.SwaggerEndpoint("/openapi/v1.json", "v1");
            });

            app.UseCors("AllowAll");

            app.Run();
        }
    }
}
