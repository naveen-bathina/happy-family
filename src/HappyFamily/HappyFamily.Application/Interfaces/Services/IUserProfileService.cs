using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services
{
    public interface IUserProfileService
    {
        Task<UserProfileDto> GetUserProfileByIdAsync(string userId);
        Task JoinFamily(UserProfileDto userProfile);
    }
}
