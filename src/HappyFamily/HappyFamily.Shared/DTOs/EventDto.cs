

namespace HappyFamily.Shared.DTOs;

public class EventDto
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public bool IsJoined { get; set; }
    public string Host { get; set; }
    public string Location { get; set; }
}
