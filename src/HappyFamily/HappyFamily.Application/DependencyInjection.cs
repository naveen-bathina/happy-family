using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Application.Mappings;
using HappyFamily.Application.Services;
using Microsoft.Extensions.DependencyInjection;

namespace HappyFamily.Application
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddApplication(this IServiceCollection services)
        {
            services.AddAutoMapper(typeof(MappingProfile));

            // Register Services as Scoped
            services.AddScoped<IAboutService, AboutService>();
            services.AddScoped<IAuthService, AuthService>();
            services.AddScoped<IDocumentService, DocumentService>();
            services.AddScoped<IEventService, EventService>();
            services.AddScoped<IFamilyService, FamilyService>();
            services.AddScoped<INotificationService, NotificationService>();
            services.AddScoped<IPollService, PollService>();
            services.AddScoped<IReminderService, ReminderService>();
            services.AddScoped<IToDoService, ToDoService>();
            services.AddScoped<ISupportService, SupportService>();
            services.AddScoped<IChatService, ChatService>();
            services.AddScoped<IOtpService, OtpService>();
            services.AddScoped<IJwtService, JwtService>();
            services.AddScoped<IUserProfileService, UserProfileService>();

            return services;
        }
    }
}
