

namespace HappyFamily.Shared.DTOs;

public class ToDoDto
{
    public string Id { get; set; }
    public string Title { get; set; }
    public DateTime DueDate { get; set; }
    public bool IsCompleted { get; set; }
    public string AssignedTo { get; set; }
    public string AssignedBy { get; set; }

}