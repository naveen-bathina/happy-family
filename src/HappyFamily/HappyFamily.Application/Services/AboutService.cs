using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Services
{
    public class AboutService : IAboutService
    {
        private readonly IAboutRepository _aboutRepository;
        private readonly IMapper _mapper;
        public AboutService(IAboutRepository aboutRepository, IMapper mapper)
        {
            _aboutRepository = aboutRepository;
            _mapper = mapper;
        }

        public async Task CreateAboutAsync(AboutRequest request)
        {
            var entity = _mapper.Map<About>(request);
            await _aboutRepository.CreateAsync(entity);
        }

        public async Task<AboutDto> GetAboutAsync(string id)
        {
            var entity = await _aboutRepository.GetDefault();
            return _mapper.Map<AboutDto>(entity);
        }

        public async Task<AboutDto> GetDefault()
        {
            var entity = await _aboutRepository.GetDefault();
            return _mapper.Map<AboutDto>(entity);
        }

        public async Task<bool> UpdateAboutAsync(string id, AboutDto aboutDto)
        {
            var entity = _mapper.Map<About>(aboutDto);
            await _aboutRepository.UpdateAsync(id, entity);
            return true;
        }
    }
}
