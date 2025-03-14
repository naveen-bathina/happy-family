using HappyFamily.Data.Mongo;
using HappyFamily.Services.Abstractions;
using HappyFamily.Services.Implementation;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace HappyFamily.Services
{
    public static class ServiceExtension
    {
        public static IServiceCollection ConfigureServices(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddScoped<IFamilyService, FamilyService>();
            services.AddScoped<IFamilyMemberService, FamilyMemberService>();
            services.AddScoped<IDocumentService, DocumentService>();
            services.AddScoped<IEventService, EventService>();
            services.AddScoped<IPollsService, PollsService>();
            services.AddScoped<IToDoService, ToDoService>();


            // Register data services
            services.RegisterDataServices(configuration);

            return services;
        }
    }
}
