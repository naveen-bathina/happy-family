

using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using Microsoft.Extensions.Logging;

namespace HappyFamily.Application.Services;

public class ToDoService : IToDoService
{

    private readonly IMapper _mapper;
    private readonly ILogger<ToDoService> _logger;
    private readonly IToDoRepository _repository;

    public ToDoService(IToDoRepository repository, ILogger<ToDoService> logger, IMapper mapper)
    {
        _repository = repository;
        _logger = logger;
        _mapper = mapper;
    }

    public Task CreateToDoAsync(ToDoDto ToDoDto)
    {
        throw new NotImplementedException();
    }

    public Task<bool> DeleteToDoAsync(string id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<ToDoDto>> GetAllToDosAsync(int pageNumber = 1, int pageSize = 10)
    {
        var entities = await _repository.GetAllAsync(pageNumber, pageSize);
        return _mapper.Map<List<ToDoDto>>(entities);
    }

    public async Task<ToDoDto> GetToDoByIdAsync(string id)
    {
        var entities = await _repository.GetByIdAsync(id);
        return _mapper.Map<ToDoDto>(entities);
    }

    public Task<bool> UpdateToDoAsync(string id, ToDoDto ToDoDto)
    {
        throw new NotImplementedException();
    }
}