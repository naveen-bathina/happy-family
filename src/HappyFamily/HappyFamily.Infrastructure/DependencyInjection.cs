using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Infrastructure.Authentication;
using HappyFamily.Infrastructure.Persistence;
using HappyFamily.Infrastructure.Persistence.Repositories;
using Microsoft.Extensions.DependencyInjection;

namespace HappyFamily.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services)
        {
            // Register MongoDB Context as Singleton
            services.AddSingleton<MongoDbContext>();

            // Register Repositories as Scoped

            services.AddScoped<IAboutRepository, AboutRepository>();
            services.AddScoped<IDocumentRepository, DocumentRepository>();
            services.AddScoped<IEventRepository, EventRepository>();
            services.AddScoped<IFamilyRepository, FamilyRepository>();
            services.AddScoped<INotificationRepository, NotificationRepository>();
            services.AddScoped<IPollRepository, PollRepository>();
            services.AddScoped<IReminderRepository, ReminderRepository>();
            services.AddScoped<IToDoRepository, ToDoRepository>();
            services.AddScoped<ISupportRepository, SupportRepository>();
            services.AddScoped<IChatRepository, ChatRepository>();
            services.AddScoped<IChatMessageRepository, ChatMessageRepository>();
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IUserProfileRepository, UserProfileRepository>();

            // Register Services
            services.AddSingleton<TwilioService>();

            // Register Jwt Token service
            services.AddSingleton<JwtTokenService>();

            return services;
        }
    }
}
