
namespace HappyFamily.Domain.Entities;

public class Poll : BaseEntity
{
    public string Title { get; set; }
    public string Description { get; set; }
    public DateTime ExpiryDate { get; set; }
    public List<PollOption> Options { get; set; }
    public List<Vote> Votes { get; set; }

}

public class PollOption : BaseEntity
{
    public string Title { get; set; }
    public int Votes { get; set; }
}

public class Vote : BaseEntity
{
    public string VotedOption { get; set; }
    public string VotedUser { get; set; }
    public string VotedOn { get; set; }
}