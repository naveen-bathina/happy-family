using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Exceptions;

namespace HappyFamily.Application.Services
{
    public class UserProfileService : IUserProfileService
    {
       
        private readonly IUserProfileRepository _repository;
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;
        public UserProfileService(IUserProfileRepository repository, IMapper mapper, IUserRepository userRepository)
        {
            _repository = repository;
            _mapper = mapper;
            _userRepository = userRepository;
        }

        public async Task JoinFamily(UserProfileDto userProfileDto)
        {
            var user = await _userRepository.GetUserByPhoneNumberAsync(userProfileDto.PhoneNumber);
            if (user != null)
            {
                var userProfile = _mapper.Map<UserProfile>(userProfileDto);
                userProfile.UserId = user.Id;
                await _repository.CreateAsync(userProfile);
            }
            else
            {
                throw new CustomException("User not found", 404);
            }
        }

        public async Task<UserProfileDto> GetUserProfileByIdAsync(string userId)
        {
            var userProfileEntity = await _repository.GetUserProfileByUserId(userId);

            if (userProfileEntity == null)
                throw new CustomException("User profile not found", 404);

            return _mapper.Map<UserProfileDto>(userProfileEntity);
        }
    }
}
