using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services;

public interface IFamilyService
{
    Task<List<FamilyDto>> GetAllFamiliesAsync(int pageNumber = 1, int pageSize = 10);
    Task<FamilyDto> GetFamilyByIdAsync(string id);
    Task<FamilyDto> GetFamilyByCodeAsync(string code);
    Task CreateFamilyAsync(FamilyDto FamilyDto);
    Task<bool> UpdateFamilyAsync(string id, FamilyDto FamilyDto);
    Task<bool> DeleteFamilyAsync(string id);
    Task<FamilyDto> AddFamilyMember(string familyId, FamilyMemberDto familyMemberDto);
    Task<List<FamilyMemberDto>> GetFamilyMembersAsync(string familyId);
    Task<FamilyMemberDto> GetFamilyMemberInfoAsync(string familyId, string memberId);
    Task JoinAsync(JoinFamilyDto joinFamilyDto);
    Task<FamilyDto> AddMemberAsync(string userId, string familyCode);

}
