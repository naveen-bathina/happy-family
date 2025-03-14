

using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using Microsoft.Extensions.Logging;

namespace HappyFamily.Application.Services;

public class NotificationService : INotificationService
{
    private readonly IMapper _mapper;
    private readonly ILogger<NotificationService> _logger;
    private readonly INotificationRepository _repository;

    public NotificationService(INotificationRepository repository, ILogger<NotificationService> logger, IMapper mapper)
    {
        _repository = repository;
        _logger = logger;
        _mapper = mapper;
    }

    public Task CreateNotificationAsync(NotificationDto NotificationDto)
    {
        throw new NotImplementedException();
    }

    public Task<bool> DeleteNotificationAsync(Guid id)
    {
        throw new NotImplementedException();
    }

    public Task<List<NotificationDto>> GetAllNotificationsAsync(int pageNumber = 1, int pageSize = 10)
    {
        throw new NotImplementedException();
    }

    public Task<NotificationDto> GetNotificationByIdAsync(Guid id)
    {
        throw new NotImplementedException();
    }

    public Task<bool> UpdateNotificationAsync(Guid id, NotificationDto NotificationDto)
    {
        throw new NotImplementedException();
    }
}