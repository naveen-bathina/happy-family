using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services;

public interface IReminderService
{
    Task<List<ReminderDto>> GetAllRemindersAsync(int pageNumber = 1, int pageSize = 10);
    Task<ReminderDto> GetReminderByIdAsync(Guid id);
    Task CreateReminderAsync(ReminderDto ReminderDto);
    Task<bool> UpdateReminderAsync(Guid id, ReminderDto ReminderDto);
    Task<bool> DeleteReminderAsync(Guid id);
}
