

using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using Microsoft.Extensions.Logging;

namespace HappyFamily.Application.Services;

public class PollService : IPollService
{

    private readonly IMapper _mapper;
    private readonly ILogger<PollService> _logger;
    private readonly IPollRepository _repository;

    public PollService(IPollRepository repository, ILogger<PollService> logger, IMapper mapper)
    {
        _repository = repository;
        _logger = logger;
        _mapper = mapper;
    }
    public async Task CreatePollAsync(PollDto PollDto)
    {
        var entity = _mapper.Map<Poll>(PollDto);
        await _repository.CreateAsync(entity);
    }

    public Task<bool> DeletePollAsync(Guid id)
    {
        throw new NotImplementedException();
    }

    public async Task<List<PollDto>> GetAllPollsAsync(int pageNumber = 1, int pageSize = 10)
    {
        var data = await  _repository.GetAllAsync(pageNumber, pageSize);
        return _mapper.Map<List<PollDto>>(data);
    }

    public Task<PollDto> GetPollByIdAsync(Guid id)
    {
        throw new NotImplementedException();
    }

    public Task<bool> UpdatePollAsync(Guid id, PollDto PollDto)
    {
        throw new NotImplementedException();
    }
}