using HappyFamily.Domain.Entities;

namespace HappyFamily.Domain.Interfaces.Repositories
{
    public interface IUserRepository : IBaseRepository<User>
    {
        Task<User?> GetUserByPhoneNumberAsync(string phoneNumber);
        Task AddOrUpdateUserAsync(User user);
        Task AddLoginHistoryAsync(string phoneNumber, string ipAddress, string deviceInfo, string otp, bool isVerified, DateTime expiresAt);
    }
}
