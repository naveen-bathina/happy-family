namespace HappyFamily.Domain.Entities
{
    public class Chat : BaseEntity
    {
        public string Title { get; set; } = string.Empty;
        public string DisplayPicture { get; set; } = string.Empty;
        public List<string> ParticipantIds { get; set; } = [];
        public ChatMessage? LastMessage { get; set; }
    }

    public class ChatMessage : BaseEntity
    {
        public string ChatId { get; set; } = string.Empty;
        public string SenderId { get; set; } = string.Empty;
        public string Message { get; set; } = string.Empty;
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
        public bool IsRead { get; set; } = false;
    }
}
