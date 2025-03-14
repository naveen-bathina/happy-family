namespace HappyFamily.Common.DTOs
{
    public class FamilyInfoDto
    {
        public string Id { get; set; }
        public string FamilyName { get; set; }
        public string FamilyDisplayPictureUrl { get; set; }
        public int FamilyMembersCount { get; set; }
        public List<FamilyMemberDto> Members { get; set; }
    }
}
