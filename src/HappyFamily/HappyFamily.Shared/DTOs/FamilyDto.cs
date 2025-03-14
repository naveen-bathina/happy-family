namespace HappyFamily.Shared.DTOs;

public class FamilyDto
{
    public string Id { get; set; }
    public string Code { get; set; }
    public string FamilyName { get; set; }
    public string LogoUrl { get; set; }
    public string GroupPhotoUrl { get; set; }
    public int FamilyMembersCount { get; set; }
    public List<FamilyMemberDto> Members { get; set; }
}

public class FamilyMemberDto
{
    public string Id { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;
    public string Gender { get; set; } = string.Empty;
    public string Relation { get; set; } = string.Empty;
    public string DisplayPicture { get; set; } = string.Empty;
    public string ContactNumber { get; set; } = string.Empty;
    public string EmailAddress { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
}

public class JoinFamilyDto {
    public string FamilyName { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Gender { get; set; } = string.Empty;
    public string ContactNumber { get; set; } = string.Empty;
    public string EmailAddress { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
}
