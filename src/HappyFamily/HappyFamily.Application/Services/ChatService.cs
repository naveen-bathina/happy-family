using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using System;

namespace HappyFamily.Application.Services
{
    public class ChatService : IChatService
    {
        private readonly IChatRepository _chatRepository;
        private readonly IChatMessageRepository _chatMessageRepository;
        private readonly IMapper _mapper;

        public ChatService(IChatRepository chatRepository, IChatMessageRepository chatMessageRepository, IMapper mapper)
        {
            _chatRepository = chatRepository;
            _chatMessageRepository = chatMessageRepository;
            _mapper = mapper;
        }

        // ✅ Get all chats for a user
        public async Task<List<ChatDto>> GetUserChatsAsync(string userId)
        {
            var chats = await _chatRepository.GetUserChatsAsync(userId);
            return _mapper.Map<List<ChatDto>>(chats);
        }

        // ✅ Get a chat by ID
        public async Task<ChatDto?> GetChatByIdAsync(string chatId)
        {
            var chat = await _chatRepository.GetByIdAsync(chatId);
            if (chat != null) 
            {
                chat.LastMessage = await _chatMessageRepository.GetLastMessageByChatIdAsync(chatId);
            }
            
            return chat == null ? null : _mapper.Map<ChatDto>(chat);
        }

        // ✅ Create a new chat
        public async Task<ChatDto> CreateChatAsync(ChatDto chatDto)
        {
            var chat = _mapper.Map<Chat>(chatDto);
            chat.CreatedAt = DateTime.UtcNow;
            chat.UpdatedAt = DateTime.UtcNow;

            var createdChat = await _chatRepository.CreateAsync(chat);
            return _mapper.Map<ChatDto>(createdChat);
        }

        // ✅ Delete a chat
        public async Task<bool> DeleteChatAsync(string chatId)
        {
            return await _chatRepository.DeleteAsync(chatId);
        }

        // ✅ Get paginated messages for a chat
        public async Task<List<ChatMessageDto>> GetMessagesByChatIdAsync(string chatId, int page, int pageSize)
        {
            var messages = await _chatMessageRepository.GetMessagesByChatIdAsync(chatId, page, pageSize);
            return _mapper.Map<List<ChatMessageDto>>(messages);
        }

        // ✅ Add a message to a chat
        public async Task<ChatMessageDto> AddMessageAsync(ChatMessageDto messageDto)
        {
            var message = _mapper.Map<ChatMessage>(messageDto);
            message.Timestamp = DateTime.UtcNow;

            var addedMessage = await _chatMessageRepository.CreateAsync(message);

            // Update chat's last modified timestamp
            await _chatRepository.UpdateLastModifiedAsync(message.ChatId);

            return _mapper.Map<ChatMessageDto>(addedMessage);
        }
    }
}
