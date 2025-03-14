using HappyFamily.Common.DTOs;
using HappyFamily.Services.Abstractions;

namespace HappyFamily.Services.Implementation
{
    public class EventService : IEventService
    {
        private static List<CalendarEventDto> _events = new List<CalendarEventDto>();

        public EventService()
        {
            if (!_events.Any())
            {
                SeedDummyEvents();
            }
        }

        private void SeedDummyEvents()
        {
            _events.Add(new CalendarEventDto
            {
                Id = new Guid("48951e5b-f825-4c97-93a1-8aae76cb8903"),
                Title = "Family Picnic",
                StartDate = new DateTime(2025, 6, 15, 10, 0, 0),
                EndDate = new DateTime(2025, 6, 15, 14, 0, 0),
                IsJoined = false
            });

            _events.Add(new CalendarEventDto
            {
                Id = new Guid("9f1e5a7e-cd26-4464-820b-21f1c55058dd"),
                Title = "Birthday Party",
                StartDate = new DateTime(2025, 7, 20, 16, 0, 0),
                EndDate = new DateTime(2025, 7, 20, 20, 0, 0),
                IsJoined = true
            });

            _events.Add(new CalendarEventDto
            {
                Id = new Guid("7af8e1fc-8b36-42d9-8a7d-3a085533b0ca"),
                Title = "Family Reunion",
                StartDate = new DateTime(2025, 8, 10, 12, 0, 0),
                EndDate = new DateTime(2025, 8, 12, 18, 0, 0),
                IsJoined = false
            });

            _events.Add(new CalendarEventDto
            {
                Id = new Guid("4e20f728-cdb9-4e6c-a869-cf54249d1957"),
                Title = "Thanksgiving Dinner",
                StartDate = new DateTime(2025, 11, 26, 18, 0, 0),
                EndDate = new DateTime(2025, 11, 26, 22, 0, 0),
                IsJoined = false
            });

            _events.Add(new CalendarEventDto
            {
                Id = new Guid("30495b90-bd9d-4fcc-909f-c2b30a2ed100"),
                Title = "Christmas Celebration",
                StartDate = new DateTime(2025, 12, 25, 17, 0, 0),
                EndDate = new DateTime(2025, 12, 25, 22, 0, 0),
                IsJoined = true,
            });

            _events.Add(new CalendarEventDto
            {
                Id = new Guid("7fed6bfa-aa2e-4d74-97e3-997ebf7be052"),
                Title = "Family Get together celebration",
                StartDate = new DateTime(2025, 2, 25, 17, 0, 0),
                EndDate = new DateTime(2025, 2, 25, 22, 0, 0),
                IsJoined = true,
            });
        }

        public List<CalendarEventDto> GetAllEvents()
        {
            return _events;
        }

        public CalendarEventDto GetEventById(Guid id)
        {
            return _events.FirstOrDefault(e => e.Id == id);
        }

        public CalendarEventDto CreateEvent(CalendarEventDto newEvent)
        {
            newEvent.Id = Guid.NewGuid(); // Assign a new ID
            _events.Add(newEvent);
            return newEvent;
        }

        public bool UpdateEvent(Guid id, CalendarEventDto updatedEvent)
        {
            var existingEvent = _events.FirstOrDefault(e => e.Id == id);
            if (existingEvent == null)
            {
                return false;
            }

            existingEvent.Title = updatedEvent.Title;
            existingEvent.StartDate = updatedEvent.StartDate;
            existingEvent.EndDate = updatedEvent.EndDate;
            return true;
        }

        public bool DeleteEvent(Guid id)
        {
            var eventToDelete = _events.FirstOrDefault(e => e.Id == id);
            if (eventToDelete == null)
            {
                return false;
            }

            _events.Remove(eventToDelete);
            return true;
        }
    }
}
