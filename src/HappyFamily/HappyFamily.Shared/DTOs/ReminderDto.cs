

namespace HappyFamily.Shared.DTOs;

public class ReminderDto {
    public string Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public DateTime Date { get; set; }
    public DateTime Time { get; set; }
    public bool IsCompleted { get; set; }
    public string AssignedTo { get; set; }
    public string AssignedBy { get; set; }
}
