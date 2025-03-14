using HappyFamily.Domain.Entities;
using System.Linq.Expressions;

namespace HappyFamily.Domain.Interfaces.Repositories
{
    public interface IBaseRepository<T> where T : BaseEntity
    {
        Task<T?> GetByIdAsync(string id);
        Task<List<T>> GetAllAsync(int pageNumber = 1, int pageSize = 10);
        Task<List<T>> FindAsync(Expression<Func<T, bool>> filter);
        Task<T> CreateAsync(T entity);
        Task<bool> UpdateAsync(string id, T entity);
        Task<bool> DeleteAsync(string id);
    }
}
