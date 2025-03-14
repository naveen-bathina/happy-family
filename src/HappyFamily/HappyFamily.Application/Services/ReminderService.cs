

using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using Microsoft.Extensions.Logging;

namespace HappyFamily.Application.Services;

public class ReminderService : IReminderService
{

    private readonly IMapper _mapper;
    private readonly ILogger<ReminderService> _logger;
    private readonly IReminderRepository _repository;

    public ReminderService(IReminderRepository repository, ILogger<ReminderService> logger, IMapper mapper)
    {
        _repository = repository;
        _logger = logger;
        _mapper = mapper;
    }
    public Task CreateReminderAsync(ReminderDto ReminderDto)
    {
        throw new NotImplementedException();
    }

    public Task<bool> DeleteReminderAsync(Guid id)
    {
        throw new NotImplementedException();
    }

    public Task<List<ReminderDto>> GetAllRemindersAsync(int pageNumber = 1, int pageSize = 10)
    {
        throw new NotImplementedException();
    }

    public Task<ReminderDto> GetReminderByIdAsync(Guid id)
    {
        throw new NotImplementedException();
    }

    public Task<bool> UpdateReminderAsync(Guid id, ReminderDto ReminderDto)
    {
        throw new NotImplementedException();
    }
}