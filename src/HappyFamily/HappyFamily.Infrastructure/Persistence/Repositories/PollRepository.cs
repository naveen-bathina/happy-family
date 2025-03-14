
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;

namespace HappyFamily.Infrastructure.Persistence.Repositories;

public class PollRepository : BaseRepository<Poll>, IPollRepository
{
    public PollRepository(MongoDbContext dbContext) : base(dbContext, "Polls")
    {

    }
}