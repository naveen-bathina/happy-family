

using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;

namespace HappyFamily.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementation for IToDoRepository contract.
/// </summary>
public class ToDoRepository : BaseRepository<ToDo>, IToDoRepository
{
    public ToDoRepository(MongoDbContext dbContext) : base(dbContext, "ToDos")
    {
    }
}
