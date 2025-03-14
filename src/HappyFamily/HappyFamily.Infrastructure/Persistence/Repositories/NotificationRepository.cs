

using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;

namespace HappyFamily.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementation for INotificationRepository contract.
/// </summary>
public class NotificationRepository : BaseRepository<Notification>, INotificationRepository
{
    public NotificationRepository(MongoDbContext dbContext) : base(dbContext, "Notifications")
    {
    }
}
