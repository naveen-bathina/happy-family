

using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using Microsoft.Extensions.Logging;

namespace HappyFamily.Application.Services;

public class EventService : IEventService
{
    private readonly IEventRepository _repository;
    private readonly IMapper _mapper;
    private readonly ILogger<EventService> _logger;

    public EventService(IEventRepository eventRepository, ILogger<EventService> logger, IMapper mapper)
    {
        _repository = eventRepository;
        _logger = logger;
        _mapper = mapper;
    }

    public async Task CreateEventAsync(EventDto eventDto)
    {
        var eventItem = _mapper.Map<Event>(eventDto);
        eventItem.Id = Guid.NewGuid().ToString();
        eventItem.CreatedAt = DateTime.UtcNow;

        await _repository.CreateAsync(eventItem);
    }

    public async Task<bool> DeleteEventAsync(string id)
    {
        return await _repository.DeleteAsync(id);
    }

    public async Task<List<EventDto>> GetAllEventsAsync(int pageNumber = 1, int pageSize = 10)
    {
        var entities = await _repository.GetAllAsync(pageNumber, pageSize);
        return _mapper.Map<List<EventDto>>(entities);
    }

    public async Task<EventDto> GetEventByIdAsync(string id)
    {
        var entity = await _repository.GetByIdAsync(id);
        return _mapper.Map<EventDto>(entity);
    }

    public async Task<bool> UpdateEventAsync(string id, EventDto eventDto)
    {
        var eventItem = _mapper.Map<Event>(eventDto);
        eventItem.CreatedAt = DateTime.UtcNow;
        await _repository.UpdateAsync(id,eventItem);
        return true;
    }
}