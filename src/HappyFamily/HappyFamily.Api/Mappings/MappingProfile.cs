using AutoMapper;
using HappyFamily.Shared.DTOs;

namespace HappyFamily.Api.Mappings
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<JoinFamilyDto, FamilyDto>()
                .ForMember(d=> d.Id, opt => opt.MapFrom(_ => Guid.NewGuid().ToString()))
                .ForMember(d => d.FamilyName, opt => opt.MapFrom(s => s.FamilyName))
                .ForMember(d => d.Members, opt => opt.MapFrom(s => 
                new List<FamilyMemberDto>() { 
                    new() 
                    { 
                        FirstName = s.FirstName, 
                        LastName = s.LastName, 
                        Address = s.Address, 
                        ContactNumber = s.ContactNumber, 
                        Gender = s.Gender, 
                        EmailAddress = s.EmailAddress
                    }}));

            CreateMap<JoinFamilyDto, UserProfileDto>();
        }
    }
}
