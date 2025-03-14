

using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;

namespace HappyFamily.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementation for IReminderRepository contract.
/// </summary>
public class ReminderRepository : BaseRepository<Reminder>, IReminderRepository
{
    public ReminderRepository(MongoDbContext dbContext) : base(dbContext, "Reminders")
    {
    }
}
