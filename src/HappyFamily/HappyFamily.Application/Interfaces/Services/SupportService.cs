using AutoMapper;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services
{
    public class SupportService : ISupportService
    {
        private readonly ISupportRepository _repository;
        private readonly IMapper _mapper;
        public SupportService(ISupportRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }


        public async Task<List<SuppportTicketDto>> GetAllSupportTicketsAsync(int pageNumber, int pageSize)
        {
            var entities = await _repository.GetAllAsync(pageNumber, pageSize);
            return _mapper.Map<List<SuppportTicketDto>>(entities);
        }
    }
}
