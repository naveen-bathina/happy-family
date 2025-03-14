

using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;

namespace HappyFamily.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementation for IDocumentRepository contract.
/// </summary>
public class DocumentRepository : BaseRepository<Document>, IDocumentRepository
{
    public DocumentRepository(MongoDbContext dbContext) : base(dbContext, "Documents")
    {
    }
}