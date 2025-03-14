namespace HappyFamily.Shared.DTOs
{
    public class ChatDto
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string DisplayPicture { get; set; }
        public List<ChatMessageDto> Messages { get; set; } = [];
        public ChatMessageDto? LastMessage { get; set; }
    }

    public class ChatMessageDto
    {
        public string Id { get; set; }
        public string ChatId { get; set; }
        public string SenderId { get; set; }
        public string Message { get; set; }
        public DateTime Timestamp { get; set; }
        public bool IsRead { get; set; }
    }
}
