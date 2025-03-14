

namespace HappyFamily.Domain.Entities;

/// <summary>
/// Family
/// </summary>
public class Family : BaseEntity
{
    public string Name { get; set; }
    public string Code { get; set; }
    public string LogoUrl { get; set; }
    public string GroupPhotoUrl { get; set; }
    public List<FamilyMember> Members { get; set; } = [];

    public void UpdateValues(Family updatedEntity)
    {
        Name = updatedEntity.Name ?? Name;
        LogoUrl = updatedEntity.Name ?? LogoUrl;
        GroupPhotoUrl = updatedEntity.GroupPhotoUrl ?? GroupPhotoUrl;
        Members = updatedEntity.Members ?? Members;
    }

    public bool CheckMemberExists(string firstName, string lastName)
    {
        return Members.Any(m => m.FirstName.ToLower() == firstName && m.LastName.ToLower() == lastName);
    }
    public bool CheckMemberExist(string userId)
    {
        return Members.Any(m => m.Id == userId);
    }

    public void AddFamilyMember(FamilyMember member)
    {
        var existingMember = Members?.FirstOrDefault(fm => fm.Id == member.Id);
        if (existingMember != null)
        {
            existingMember.Address = existingMember.Address ?? member.Address;
            existingMember.Role = existingMember.Role ?? member.Role;
            existingMember.Gender = existingMember.Gender ?? member.Gender;
            existingMember.ContactNumber = existingMember.ContactNumber ?? member.ContactNumber;
            existingMember.EmailAddress = existingMember.EmailAddress ?? member.EmailAddress;
        }
        else
        {
            existingMember = new FamilyMember()
            {
                Id = member.Id,
                Role = member.Role
            };
            if (Members == null)
            {
                Members = [existingMember];
            }
            else {
                Members.Add(existingMember);
            }
        }
    }
}
