using HappyFamily.Domain.Entities;

namespace HappyFamily.Domain.Interfaces.Repositories
{
    public interface IChatRepository : IBaseRepository<Chat>
    {
        Task<List<Chat>> GetUserChatsAsync(string userId);
        Task UpdateLastModifiedAsync(string chatId);
    }
}
