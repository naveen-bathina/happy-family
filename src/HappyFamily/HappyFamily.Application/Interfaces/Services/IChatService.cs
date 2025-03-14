using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services
{
    public interface IChatService
    {
        Task<List<ChatDto>> GetUserChatsAsync(string userId);
        Task<ChatDto?> GetChatByIdAsync(string chatId);
        Task<ChatDto> CreateChatAsync(ChatDto chatDto);
        Task<bool> DeleteChatAsync(string chatId);
        Task<List<ChatMessageDto>> GetMessagesByChatIdAsync(string chatId, int page, int pageSize);
        Task<ChatMessageDto> AddMessageAsync(ChatMessageDto messageDto);
    }
}
