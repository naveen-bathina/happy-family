using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using MongoDB.Driver;
using System.Linq.Expressions;

namespace HappyFamily.Infrastructure.Persistence.Repositories
{
    public abstract class BaseRepository<T> : IBaseRepository<T> where T : BaseEntity
    {
        protected readonly IMongoCollection<T> _collection;

        public BaseRepository(MongoDbContext context, string collectionName)
        {
            _collection = context.GetCollection<T>(collectionName);
        }

        // ✅ Get an entity by ID
        public async Task<T?> GetByIdAsync(string id)
        {
            return await _collection.Find(Builders<T>.Filter.Eq("_id", id)).FirstOrDefaultAsync();
        }

        // ✅ Get all entities
        public async Task<List<T>> GetAllAsync(int pageNumber = 1, int pageSize = 10)
        {
            return await _collection.Find(_ => true)
                                    .Skip((pageNumber - 1) * pageSize)
                                    .Limit(pageSize)
                                    .ToListAsync();
        }

        // ✅ Find entities based on filter
        public async Task<List<T>> FindAsync(Expression<Func<T, bool>> filter)
        {
            return await _collection.Find(filter).ToListAsync();
        }

        // ✅ Add a new entity
        public async Task<T> CreateAsync(T entity)
        {
            await _collection.InsertOneAsync(entity);
            return entity;
        }

        // ✅ Update an entity
        public async Task<bool> UpdateAsync(string id, T entity)
        {
            var result = await _collection.ReplaceOneAsync(Builders<T>.Filter.Eq("_id", id), entity);
            return result.ModifiedCount > 0;
        }

        // ✅ Delete an entity
        public async Task<bool> DeleteAsync(string id)
        {
            var result = await _collection.DeleteOneAsync(Builders<T>.Filter.Eq("_id", id));
            return result.DeletedCount > 0;
        }
    }
}
