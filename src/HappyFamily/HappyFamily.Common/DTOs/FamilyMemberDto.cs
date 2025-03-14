namespace HappyFamily.Common.DTOs
{
    public class FamilyMemberDto
    {
        public string Id { get; set; }
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
        public string Relation { get; set; } = string.Empty;
        public string ContactNumber { get; set; } = string.Empty;
        public string EmailAddress { get; set; } = string.Empty;
        public string DisplayPicture { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
    }
}
