using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services;
public interface IEventService
{
    Task<List<EventDto>> GetAllEventsAsync(int pageNumber = 1, int pageSize = 10);
    Task<EventDto> GetEventByIdAsync(string id);
    Task CreateEventAsync(EventDto eventDto);
    Task<bool> UpdateEventAsync(string id, EventDto eventDto);
    Task<bool> DeleteEventAsync(string id);
}
