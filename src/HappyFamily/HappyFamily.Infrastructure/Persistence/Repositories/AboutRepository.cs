using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using MongoDB.Driver;

namespace HappyFamily.Infrastructure.Persistence.Repositories
{
    public class AboutRepository : BaseRepository<About>, IAboutRepository
    {
        public AboutRepository(MongoDbContext dbContext) : base(dbContext, "About")
        {

        }

        public Task<About> GetDefault()
        {
            return _collection.Find(_ => true).FirstOrDefaultAsync();
        }
    }
}
