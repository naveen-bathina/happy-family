

using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;

namespace HappyFamily.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementation for IEventRepository contract.
/// </summary>
public class EventRepository : BaseRepository<Event>, IEventRepository
{
    public EventRepository(MongoDbContext dbContext) : base(dbContext, "Events")
    {

    }
}
