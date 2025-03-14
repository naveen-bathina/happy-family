
namespace HappyFamily.Domain.Entities;
public class Document : BaseEntity
{
    public string Title { get; set; }
    public string Content { get; set; }
    public string Author { get; set; }
    public string FileType { get; set; }
    public string DownloadUrl { get; set; }
}