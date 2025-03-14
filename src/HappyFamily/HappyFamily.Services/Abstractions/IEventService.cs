using HappyFamily.Common.DTOs;

namespace HappyFamily.Services.Abstractions
{
    public interface IEventService
    {
        List<CalendarEventDto> GetAllEvents();
        CalendarEventDto GetEventById(Guid id);
        CalendarEventDto CreateEvent(CalendarEventDto newEvent);
        bool UpdateEvent(Guid id, CalendarEventDto updatedEvent);
        bool DeleteEvent(Guid id);
    }
}
