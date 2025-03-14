using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using MongoDB.Driver;

namespace HappyFamily.Infrastructure.Persistence.Repositories
{
    public class ChatRepository : BaseRepository<Chat>, IChatRepository
    {
        public ChatRepository(MongoDbContext dbContext) : base(dbContext, "Chats")
        {
        }

        public async Task<List<Chat>> GetUserChatsAsync(string userId)
        {
            return await _collection
                .Find(c => c.ParticipantIds.Contains(userId))
                .SortByDescending(c => c.UpdatedAt)
                .ToListAsync();
        }

        public async Task UpdateLastModifiedAsync(string chatId)
        {
            var update = Builders<Chat>.Update.Set(c => c.UpdatedAt, DateTime.UtcNow);
            await _collection.UpdateOneAsync(c => c.Id == chatId, update);
        }
    }
}
