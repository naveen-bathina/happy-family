
namespace HappyFamily.Domain.Entities;

public abstract class BaseEntity
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public string UpdatedBy { get; set; } = string.Empty;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
}