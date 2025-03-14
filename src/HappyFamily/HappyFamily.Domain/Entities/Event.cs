

namespace HappyFamily.Domain.Entities;

//Event
public class Event : BaseEntity
{
    public string Title { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public string Host { get; set; }
    public string Location { get; set; }
}
