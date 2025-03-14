using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;

namespace HappyFamily.Infrastructure.Persistence.Repositories
{
    public class SupportRepository : BaseRepository<SupportTicket>, ISupportRepository
    {
        public SupportRepository(MongoDbContext dbContext) : base(dbContext, "SupportTickets")
        {
        }
    }
}
