using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventsController : ControllerBase
    {
        private readonly IEventService _service;
        private readonly ILogger<EventsController> _logger;

        public EventsController(IEventService service, ILogger<EventsController> logger)
        {
            _service = service;
            _logger = logger;
        }

        // GET: api/events
        [HttpGet]
        public async Task<ActionResult<ApiResponse<IEnumerable<EventDto>>>> GetEventsAsync()
        {
            var events = await _service.GetAllEventsAsync();
            var response = ApiResponse<IEnumerable<EventDto>>.SuccessResponse(events, "Events fetched successfully");
            return Ok(response);
        }

        // GET: api/events/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<ApiResponse<EventDto>>> GetEvent(string id)
        {
            var calendarEvent = await _service.GetEventByIdAsync(id);
            if (calendarEvent == null)
            {
                return NotFound(ApiResponse<EventDto>.FailureResponse("Event not found."));
            }

            return Ok(ApiResponse<EventDto>.SuccessResponse(calendarEvent, "Found Event"));
        }

        // POST: api/events
        [HttpPost]
        public async Task<ActionResult<ApiResponse<EventDto>>> CreateEventAsync([FromBody] EventDto newEvent)
        {
            if (newEvent == null)
            {
                return BadRequest(ApiResponse<EventDto>.FailureResponse("Invalid input data."));
            }

            await _service.CreateEventAsync(newEvent);
            var response = ApiResponse<EventDto>.SuccessResponse(newEvent, "Event created successfully.");
            return CreatedAtAction(nameof(GetEvent), new { id = newEvent.Id }, response);
        }

        // PUT: api/events/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateEvent(string id, [FromBody] EventDto updatedEvent)
        {
            if (updatedEvent == null)
            {
                return BadRequest(ApiResponse<EventDto>.FailureResponse("Invalid event data."));
            }

            var isUpdated = await _service.UpdateEventAsync(id, updatedEvent);
            if (!isUpdated)
            {
                return NotFound(ApiResponse<EventDto>.FailureResponse("Event not found."));
            }

            return Ok(ApiResponse<EventDto>.SuccessResponse(updatedEvent, "Event updated successfully."));
        }

        // DELETE: api/events/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEvent(string id)
        {
            var isDeleted = await _service.DeleteEventAsync(id);
            if (!isDeleted)
            {
                return NotFound(ApiResponse<string>.FailureResponse("Event not found or could not be deleted."));
            }

            return Ok(ApiResponse<string>.SuccessResponse(id.ToString(), "Event deleted successfully."));
        }
    }
}
