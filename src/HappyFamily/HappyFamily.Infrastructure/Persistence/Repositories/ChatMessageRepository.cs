using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using MongoDB.Driver;
using Twilio.Base;

namespace HappyFamily.Infrastructure.Persistence.Repositories
{
    public class ChatMessageRepository : BaseRepository<ChatMessage>, IChatMessageRepository
    {
        public ChatMessageRepository(MongoDbContext dbContext) : base(dbContext, "ChatMessages")
        {
        }

        public async Task<ChatMessage?> GetLastMessageByChatIdAsync(string chatId)
        {
            return await _collection.Find(m => m.ChatId == chatId)
                                    .SortByDescending(m => m.Timestamp)
                                    .Limit(1)
                                    .FirstOrDefaultAsync();
        }

        public async Task<List<ChatMessage>> GetMessagesByChatIdAsync(string chatId, int page, int pageSize)
        {
            return await _collection
                .Find(m => m.ChatId == chatId)
                .SortByDescending(m => m.Timestamp)
                .Skip((page - 1) * pageSize)
                .Limit(pageSize)
                .ToListAsync();
        }
    }
}
