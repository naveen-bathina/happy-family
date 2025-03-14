using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using MongoDB.Driver;

namespace HappyFamily.Infrastructure.Persistence.Repositories
{
    public class UserProfileRepository : BaseRepository<UserProfile>, IUserProfileRepository
    {
        public UserProfileRepository(MongoDbContext context) : base(context, "UserProfiles")
        {
        }

        public async Task<UserProfile> GetUserProfileByUserId(string userId)
        {
            var userProfile = await _collection.Find(up => up.UserId == userId).FirstOrDefaultAsync();

            return userProfile;
        }
    }
}
