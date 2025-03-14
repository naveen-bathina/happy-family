namespace HappyFamily.Domain.Entities;

/// <summary>
/// FamilyMember
/// </summary>
public class FamilyMember : BaseEntity
{
    public string FirstName { get; set; } 
    public string LastName { get; set; } 
    public string Role { get; set; } 
    public string Gender { get; set; } 
    public string Relation { get; set; } 
    public string DisplayPicture { get; set; } 
    public string ContactNumber { get; set; } 
    public string EmailAddress { get; set; } 
    public string Address { get; set; } 

    public void UpdateValues(FamilyMember updatedEntity)
    {
        FirstName = updatedEntity.FirstName ?? FirstName;
        LastName = updatedEntity.LastName ?? LastName;
        Gender = updatedEntity.Gender ?? Gender;
        Role = updatedEntity.Role ?? Role;
        Relation = updatedEntity.Relation ?? Relation;
    }

}
