

using HappyFamily.Domain.Entities;
using Microsoft.Extensions.Configuration;
using MongoDB.Driver;

namespace HappyFamily.Infrastructure.Persistence;
public class MongoDbContext
{
    private readonly IMongoDatabase _database;

    public MongoDbContext(IConfiguration configuration)
    {
        var client = new MongoClient(configuration["MongoDB:ConnectionString"]);
        _database = client.GetDatabase(configuration["MongoDB:DatabaseName"]);

        // Ensure unique index on Family.Code
        CreateIndexes();
    }

    private void CreateIndexes()
    {
        var familyCodeIndex = Builders<Family>.IndexKeys.Ascending(f => f.Code);
        var indexOptions = new CreateIndexOptions { Unique = true };
        var indexModel = new CreateIndexModel<Family>(familyCodeIndex, indexOptions);

        GetCollection<Family>("Families").Indexes.CreateOne(indexModel);


        // Index on User.PhoneNumber for fast lookups
        var phoneIndex = Builders<User>.IndexKeys.Ascending(u => u.PhoneNumber);
        GetCollection<User>("Users").Indexes.CreateOne(new CreateIndexModel<User>(phoneIndex));
    }

    public IMongoCollection<T> GetCollection<T>(string collectionName)
    {
        return _database.GetCollection<T>(collectionName);
    }
}