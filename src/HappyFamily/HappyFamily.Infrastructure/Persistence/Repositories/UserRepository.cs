using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using MongoDB.Driver;

namespace HappyFamily.Infrastructure.Persistence.Repositories
{
    public class UserRepository : BaseRepository<User>, IUserRepository
    {
        public UserRepository(MongoDbContext context) : base(context, "Users")
        {

        }

        public async Task<User?> GetUserByPhoneNumberAsync(string phoneNumber)
        {
            return await _collection.Find(u => u.PhoneNumber == phoneNumber).FirstOrDefaultAsync();
        }

        public async Task AddOrUpdateUserAsync(User user)
        {
            var filter = Builders<User>.Filter.Eq(u => u.PhoneNumber, user.PhoneNumber);
            var existingUser = await _collection.Find(filter).FirstOrDefaultAsync();

            if (existingUser == null)
            {
                await _collection.InsertOneAsync(user);
            }
            else
            {
                await _collection.ReplaceOneAsync(filter, user);
            }
        }

        public async Task AddLoginHistoryAsync(string phoneNumber, string ipAddress, string deviceInfo, string otp, bool isVerified, DateTime expiresAt)
        {
            var filter = Builders<User>.Filter.Eq(u => u.PhoneNumber, phoneNumber);
            var update = Builders<User>.Update.Push(u => u.LoginHistory, new LoginHistory
            {
                IpAddress = ipAddress,
                DeviceInfo = deviceInfo,
                Otp = otp,
                IsVerified = isVerified,
                ExpiresAt = expiresAt
            });

            await _collection.UpdateOneAsync(filter, update);
        }
    }
}
