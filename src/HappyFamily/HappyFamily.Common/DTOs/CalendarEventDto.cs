namespace HappyFamily.Common.DTOs
{
    public class CalendarEventDto
    {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public bool IsJoined { get; set; }
        public bool IsUpcoming => StartDate >= DateTime.Today;
    }
}
