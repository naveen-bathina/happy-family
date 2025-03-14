using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services;

public interface IToDoService
{
    Task<List<ToDoDto>> GetAllToDosAsync(int pageNumber = 1, int pageSize = 10);
    Task<ToDoDto> GetToDoByIdAsync(string id);
    Task CreateToDoAsync(ToDoDto ToDoDto);
    Task<bool> UpdateToDoAsync(string id, ToDoDto ToDoDto);
    Task<bool> DeleteToDoAsync(string id);
}
