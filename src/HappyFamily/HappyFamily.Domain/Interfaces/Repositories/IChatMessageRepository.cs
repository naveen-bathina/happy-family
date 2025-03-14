using HappyFamily.Domain.Entities;

namespace HappyFamily.Domain.Interfaces.Repositories
{
    public interface IChatMessageRepository : IBaseRepository<ChatMessage>
    {
        Task<List<ChatMessage>> GetMessagesByChatIdAsync(string chatId, int page, int pageSize);
        Task<ChatMessage?> GetLastMessageByChatIdAsync(string chatId);
    }
}
