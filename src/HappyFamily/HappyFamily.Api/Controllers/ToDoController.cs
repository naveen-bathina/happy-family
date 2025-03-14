using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.Api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TodoController : ControllerBase
    {
        private readonly ILogger<TodoController> _logger;
        private readonly IToDoService _toDoService;

        public TodoController(ILogger<TodoController> logger, IToDoService todoService)
        {
            _logger = logger;
            _toDoService = todoService;
        }

        [HttpGet(Name = "Get Todo Items")]
        public async Task<ActionResult<ApiResponse<IEnumerable<ToDoDto>>>> GetTodosAsync()
        {
            var todoList = await _toDoService.GetAllToDosAsync();
            var response = ApiResponse<IEnumerable<ToDoDto>>.SuccessResponse(todoList, "Event fetched successfully");
            return Ok(response);
        }
    }
}
