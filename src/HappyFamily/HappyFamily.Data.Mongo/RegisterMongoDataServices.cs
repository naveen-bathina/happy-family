using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace HappyFamily.Data.Mongo;
public static class RegisterMongoDataServices
{
    public static IServiceCollection RegisterDataServices(this IServiceCollection services, IConfiguration configuration)
    {
        // Register MongoDBSettings configuration
        services.Configure<MongoDBSettings>(configuration.GetSection("MongoDBSettings"));

        services.AddSingleton<MongoDBContext>(ctx =>
        {
            var client = new MongoClient(ctx.GetRequiredService<IOptions<MongoDBSettings>>().Value.ConnectionString);
            var database = client.GetDatabase(ctx.GetRequiredService<IOptions<MongoDBSettings>>().Value.DatabaseName);
            return new MongoDBContext(database);
        });

        return services;
    }
}