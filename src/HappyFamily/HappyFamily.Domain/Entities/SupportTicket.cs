namespace HappyFamily.Domain.Entities
{
    public class SupportTicket : BaseEntity
    {
        public string Title { get; set; }
        public DateTime ReportedDate { get; set; }
        public string Status { get; set; }
    }
}
