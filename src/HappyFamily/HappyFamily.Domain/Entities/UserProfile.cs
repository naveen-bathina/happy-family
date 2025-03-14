namespace HappyFamily.Domain.Entities
{
    public class UserProfile : BaseEntity
    {
        public string UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string DisplayPicture { get; set; }
        public string MobileNumber { get; set; }
        public string FamilyId { get; set; }
        public List<string> Roles { get; set; } = [];
    }
}
