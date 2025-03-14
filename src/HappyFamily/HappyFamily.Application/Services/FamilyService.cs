using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Exceptions;
using Microsoft.Extensions.Logging;

namespace HappyFamily.Application.Services
{
    public class FamilyService : IFamilyService
    {
        private readonly IFamilyRepository _familyRepository;
        private readonly IUserRepository _userRepository;
        private readonly IUserProfileRepository _userProfileRepository;
        private readonly IMapper _mapper;
        private readonly ILogger<FamilyService> _logger;

        public FamilyService(IFamilyRepository familyRepository, ILogger<FamilyService> logger, IMapper mapper, IUserRepository userRepository, IUserProfileRepository userProfileRepository)
        {
            _familyRepository = familyRepository;
            _logger = logger;
            _mapper = mapper;
            _userRepository = userRepository;
            _userProfileRepository = userProfileRepository;
        }

        public async Task<List<FamilyDto>> GetAllFamiliesAsync(int pageNumber = 1, int pageSize = 10)
        {
            var families = await _familyRepository.GetAllAsync(pageNumber, pageSize);
            return _mapper.Map<List<FamilyDto>>(families);
        }

        public async Task<FamilyDto> GetFamilyByIdAsync(string id)
        {
            var family = await _familyRepository.GetByIdAsync(id);
            if (family == null)
                throw new CustomException("Family not found", 404);

            return _mapper.Map<FamilyDto>(family);
        }

        public async Task CreateFamilyAsync(FamilyDto familyDto)
        {
            if (string.IsNullOrWhiteSpace(familyDto.FamilyName))
                throw new CustomException("Family name cannot be empty", 400);

            var familyEntity = _mapper.Map<Family>(familyDto);
            await _familyRepository.CreateAsync(familyEntity);
            _logger.LogInformation("Created new family: {FamilyName}", familyEntity.Name);
        }

        public async Task<bool> UpdateFamilyAsync(string id, FamilyDto familyDto)
        {
            var existingFamily = await _familyRepository.GetByIdAsync(id);
            if (existingFamily == null)
                throw new CustomException("Family not found", 404);

            var familyEntity = _mapper.Map<Family>(familyDto);
            familyEntity.Id = id;

            await _familyRepository.UpdateAsync(id, familyEntity);
            _logger.LogInformation("Updated family: {FamilyId}", id);
            return true;
        }

        public async Task<bool> DeleteFamilyAsync(string id)
        {
            var deleted = await _familyRepository.DeleteAsync(id);
            if (!deleted)
                throw new CustomException("Family not found or could not be deleted", 404);

            _logger.LogInformation("Deleted family: {FamilyId}", id);
            return true;
        }

        public async Task<FamilyDto> AddFamilyMember(string familyId, FamilyMemberDto familyMemberDto)
        {
            var existingFamily = await _familyRepository.GetByIdAsync(familyId)
                ?? throw new CustomException("Family not found or could not be deleted", 404);

            // check has already member.

            if (!existingFamily.CheckMemberExists(familyMemberDto.FirstName, familyMemberDto.LastName))
                existingFamily.Members.Add(_mapper.Map<FamilyMember>(familyMemberDto));

            var updatedEntity = await _familyRepository.UpdateAsync(familyId, existingFamily);
            if (!updatedEntity)
                throw new CustomException("Family not found or could not be updated", 404);


            var family = await _familyRepository.GetByIdAsync(familyId);
            return _mapper.Map<FamilyDto>(family);
        }

        public async Task<List<FamilyMemberDto>> GetFamilyMembersAsync(string familyId)
        {
            var familyEntity = await _familyRepository.GetByIdAsync(familyId);
            return _mapper.Map<List<FamilyMemberDto>>(familyEntity?.Members);
        }

        public async Task<FamilyMemberDto> GetFamilyMemberInfoAsync(string familyId, string memberId)
        {
            var familyEntity = await _familyRepository.GetByIdAsync(familyId);
            if (familyEntity == null)
                throw new CustomException("Family not found", 404);
            var member = familyEntity.Members.FirstOrDefault(m => m.Id == memberId);
            return _mapper.Map<FamilyMemberDto>(member);
        }

        public async Task JoinAsync(JoinFamilyDto joinFamilyDto)
        {
            string userId = string.Empty;
            string familyId = string.Empty;

            if (string.IsNullOrWhiteSpace(joinFamilyDto.FamilyName))
                throw new CustomException("Family name cannot be empty", 400);

            //TODO: Check user already exists, Create user if not exists
            var user = await _userRepository.GetUserByPhoneNumberAsync(joinFamilyDto.ContactNumber);
            if (user == null)
            {
                var userEntity = new User() { PhoneNumber = joinFamilyDto.ContactNumber, EmailAddress = joinFamilyDto.EmailAddress };
                userId = userEntity.Id;
                var createdUser = await _userRepository.CreateAsync(userEntity);
                _logger.LogInformation("Created new user: {UserId}", createdUser.Id);

            }
            else
            {
                userId = user.Id;
            }

            //TODO: Check Family Code exists
            var family = (await _familyRepository.FindAsync(f => f.Code.ToLower() == joinFamilyDto.FamilyName.ToLower())).FirstOrDefault();
            if (family == null)
            {
                var familyEntity = new Family() { Name = joinFamilyDto.FamilyName, Code = GenerateFamilyCode() };
                familyId = familyEntity.Id;
                var createdFamily = await _familyRepository.CreateAsync(familyEntity);
                familyId = createdFamily.Id;
                _logger.LogInformation("Created new family: {FamilyId}", familyEntity.Id);
            }
            else
            {
                familyId = family.Id;
            }

            var userProfile = (await _userProfileRepository.FindAsync(up => up.MobileNumber == joinFamilyDto.ContactNumber)).FirstOrDefault();
            if (userProfile == null)
            {
                UserProfile newProfile = new UserProfile()
                {
                    Id = userId,
                    UserId = userId,
                    FirstName = joinFamilyDto.FirstName,
                    LastName = joinFamilyDto.LastName,
                    FamilyId = familyId,
                    Roles = ["FamilyAdmin"],
                    MobileNumber = joinFamilyDto.ContactNumber,
                };

                var createdProfile = await _userProfileRepository.CreateAsync(newProfile);
                _logger.LogInformation("Created new user profile: {UserProfileId}", createdProfile.Id);

            }

        }

        private string GenerateFamilyCode()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            return new string(Enumerable.Repeat(chars, 6).Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public async Task<FamilyDto> GetFamilyByCodeAsync(string code)
        {
            var family = await _familyRepository.FindAsync(f => f.Code.ToLower() == code.ToLower()) ?? throw new CustomException("Family info not found", 404);

            return _mapper.Map<FamilyDto>(family.FirstOrDefault());
        }

        public async Task<FamilyDto> AddMemberAsync(string userId, string familyCode)
        {
            var familyInfo = await _familyRepository.FindAsync(f => f.Code.ToLower() == familyCode.ToLower());
            var userDetails = await _userRepository.GetByIdAsync(userId) ?? throw new CustomException("User Not found", 404);
            var userProfile = await _userProfileRepository.GetByIdAsync(userId);

            var familyEntity = familyInfo == null || familyInfo.Count == 0 ? throw new CustomException("Family Not found with your code", 404) : familyInfo.First();
            familyEntity.AddFamilyMember(new FamilyMember() { Id = userId });

            var updated = await _familyRepository.UpdateAsync(familyEntity.Id, familyEntity);

            familyInfo = await _familyRepository.FindAsync(f => f.Code.ToLower() == familyCode.ToLower());
            return _mapper.Map<FamilyDto>(familyInfo.First());
        }
    }
}
