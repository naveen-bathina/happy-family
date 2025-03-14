
namespace HappyFamily.Shared.DTOs;

public class PollDto
{
    public string Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public DateTime ExpiryDate { get; set; }
    public List<PollOptionDto> Options { get; set; }

}

public class PollOptionDto
{
    public string Id { get; set; }
    public string Title { get; set; }
    public int Votes { get; set; }
}