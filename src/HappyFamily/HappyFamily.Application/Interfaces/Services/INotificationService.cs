using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services;

public interface INotificationService
{
    Task<List<NotificationDto>> GetAllNotificationsAsync(int pageNumber = 1, int pageSize = 10);
    Task<NotificationDto> GetNotificationByIdAsync(Guid id);
    Task CreateNotificationAsync(NotificationDto NotificationDto);
    Task<bool> UpdateNotificationAsync(Guid id, NotificationDto NotificationDto);
    Task<bool> DeleteNotificationAsync(Guid id);
}
