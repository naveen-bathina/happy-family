

namespace HappyFamily.Shared.DTOs;

public class NotificationDto
{
    public string Id { get; set; }
    public string Title { get; set; }
    public string Body { get; set; }

}

public class NotificationRequest
{
    public string Title { get; set; }
    public string Body { get; set; }
    public string Token { get; set; }
}
