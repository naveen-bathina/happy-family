namespace HappyFamily.Common.DTOs
{
    public class PollDto
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime expiryDate { get; set; }
        public List<PollOption> Options { get; set; }

    }

    public class PollOption
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public int Votes { get; set; }
    }
}
