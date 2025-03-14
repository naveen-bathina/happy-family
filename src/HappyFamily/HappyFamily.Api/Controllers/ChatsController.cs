using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChatController : ControllerBase
    {
        private readonly IChatService _chatService;
        private readonly IMapper _mapper;

        public ChatController(IChatService chatService, IMapper mapper)
        {
            _chatService = chatService;
            _mapper = mapper;
        }

        // ✅ Get all chats for a user
        [HttpGet("user/{userId}")]
        public async Task<ActionResult<ApiResponse<List<ChatDto>>>> GetUserChats(string userId)
        {
            var chats = await _chatService.GetUserChatsAsync(userId);
            var chatDtos = _mapper.Map<List<ChatDto>>(chats);
            return Ok(ApiResponse<List<ChatDto>>.SuccessResponse(chatDtos, "Retrieved chats"));
        }

        // ✅ Get a specific chat by ID
        [HttpGet("{chatId}")]
        public async Task<ActionResult<ApiResponse<ChatDto>>> GetChatById(string chatId)
        {
            var chat = await _chatService.GetChatByIdAsync(chatId);
            if (chat == null) return NotFound(ApiResponse<ChatDto>.FailureResponse("Chat not found"));

            var chatDto = _mapper.Map<ChatDto>(chat);
            return Ok(ApiResponse<ChatDto>.SuccessResponse(chatDto, "Retrieved chats"));
        }

        // ✅ Create a new chat
        [HttpPost]
        public async Task<ActionResult<ApiResponse<ChatDto>>> CreateChat([FromBody] ChatDto chatDto)
        {
            if (chatDto == null) return BadRequest("Chat data is required");

            var chat = _mapper.Map<ChatDto>(chatDto);
            var createdChat = await _chatService.CreateChatAsync(chat);
            var createdChatDto = _mapper.Map<ChatDto>(createdChat);

            return ApiResponse<ChatDto>.SuccessResponse(createdChatDto, "Created chat");
        }

        // ✅ Delete a chat
        [HttpDelete("{chatId}")]
        public async Task<ActionResult<ApiResponse<ChatDto>>> DeleteChat(string chatId)
        {
            var deleted = await _chatService.DeleteChatAsync(chatId);
            if (!deleted) return NotFound(ApiResponse<ChatDto>.FailureResponse("Chat not found"));

            return NoContent();
        }

        // ✅ Get paginated messages in a chat
        [HttpGet("{chatId}/messages")]
        public async Task<ActionResult<ApiResponse<List<ChatMessageDto>>>> GetChatMessages(string chatId, [FromQuery] int page = 1, [FromQuery] int pageSize = 20)
        {
            var messages = await _chatService.GetMessagesByChatIdAsync(chatId, page, pageSize);
            var messageDtos = _mapper.Map<List<ChatMessageDto>>(messages);

            return Ok(ApiResponse<List<ChatMessageDto>>.SuccessResponse(messageDtos));
        }

        // ✅ Add a message to a chat
        [HttpPost("{chatId}/messages")]
        public async Task<ActionResult<ApiResponse<ChatMessageDto>>> AddMessage(string chatId, [FromBody] ChatMessageDto messageDto)
        {
            if (messageDto == null || messageDto.ChatId != chatId)
                return BadRequest("Invalid message data");

            var message = _mapper.Map<ChatMessageDto>(messageDto);
            var addedMessage = await _chatService.AddMessageAsync(message);
            var addedMessageDto = _mapper.Map<ChatMessageDto>(addedMessage);

            return Ok(ApiResponse<ChatMessageDto>.SuccessResponse(addedMessageDto));
        }
    }
}
