using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace HappyFamily.Data.Mongo
{
    public class MongoDBContext
    {
        private readonly IMongoDatabase _database;

        public MongoDBContext(IMongoDatabase database)
        {
            _database = database;
        }

        public IMongoCollection<Entities.Family> Families => _database.GetCollection<Entities.Family>("Families");
        public IMongoCollection<Entities.MemberProfile> MemberProfiles => _database.GetCollection<Entities.MemberProfile>("MemberProfiles");

    }
}

