using HappyFamily.Common.DTOs;
using HappyFamily.Services.Abstractions;

namespace HappyFamily.Services.Implementation
{
    public class ToDoService : IToDoService
    {
        public IEnumerable<ToDoDto> GetAll()
        {
            return new List<ToDoDto>() {
                new ToDoDto() { Id = "todo-1", Title="Task 1", DueDate= DateTime.Now.AddDays(1) },
                new ToDoDto() { Id = "todo-2", Title="Task 2", DueDate= DateTime.Now.AddDays(2) },
                new ToDoDto() { Id = "todo-3", Title="Task 3", DueDate= DateTime.Now.AddDays(3) },
                new ToDoDto() { Id = "todo-4", Title="Task 4", DueDate= DateTime.Now.AddDays(-2) },
                new ToDoDto() { Id = "todo-5", Title="Task 5", DueDate= DateTime.Now.AddDays(2) }
            };
        }
    }
}
