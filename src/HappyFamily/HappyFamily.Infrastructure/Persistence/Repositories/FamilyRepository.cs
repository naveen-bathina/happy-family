using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using MongoDB.Driver;

namespace HappyFamily.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementation for IFamilyRepository contract.
/// </summary>
public class FamilyRepository : BaseRepository<Family>, IFamilyRepository
{
    public FamilyRepository(MongoDbContext dbContext) : base(dbContext, "Families")
    {
    }
}
