namespace HappyFamily.Domain.Entities
{
    public class User : BaseEntity
    {
        public string PhoneNumber { get; set; } = string.Empty;
        public string EmailAddress { get; set; }
        public List<LoginHistory> LoginHistory { get; set; } = new();
    }

    public class LoginHistory
    {
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
        public string IpAddress { get; set; } = string.Empty;
        public string DeviceInfo { get; set; } = string.Empty;
        public string? Otp { get; set; }
        public bool IsVerified { get; set; } = false;
        public DateTime ExpiresAt { get; set; }
    }
}
