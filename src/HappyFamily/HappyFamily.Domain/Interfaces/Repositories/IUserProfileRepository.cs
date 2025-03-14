using HappyFamily.Domain.Entities;

namespace HappyFamily.Domain.Interfaces.Repositories
{
    public interface IUserProfileRepository : IBaseRepository<UserProfile>
    {
        Task<UserProfile> GetUserProfileByUserId(string userId);
    }
}
