using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MembersController : ControllerBase
    {
        //private readonly List<FamilyMemberDto> _members = new List<FamilyMemberDto>() {
        //    new FamilyMemberDto() {
        //        FirstName = "Naveen",
        //        LastName="Bathina",
        //        EmailAddress="naveen.bathina9@gmail.com",
        //        ContactNumber="9620430945",
        //        DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
        //        Relation="Son",
        //        Role="Family Member",
        //        Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
        //    },
        //    new FamilyMemberDto() {
        //        FirstName = "Murali Krishna",
        //        LastName="Bathina",
        //        EmailAddress="murali.bathina9@gmail.com",
        //        ContactNumber="8897468169",
        //        DisplayPicture="https://happyfamily.org.in/static/media/logo.7fff66788ec91af47a31.png",
        //        Relation="Father",
        //        Role="Head of the Family",
        //        Address = "Bathina Home, Darakastu Road, Ojili (village & post) \n Tirupati District, Andhra Pradesh \n India - 524402"
        //    }
        //};

        private readonly ILogger<MembersController> _logger;
        private readonly IFamilyService _service;
        public MembersController(ILogger<MembersController> logger, IFamilyService service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet("{familyId}")]
        public async Task<ActionResult<ApiResponse<IEnumerable<FamilyMemberDto>>>> Get(string familyId)
        {
            var members = await _service.GetFamilyMembersAsync(familyId);
            var response = ApiResponse<IEnumerable<FamilyMemberDto>>.SuccessResponse(members, "success");
            return await Task.FromResult(response);
        }

        [HttpGet("me/{familyId}/{memberId}", Name = "Me")]
        public async Task<ActionResult<ApiResponse<FamilyMemberDto>>> Me(string familyId, string memberId)
        {
            var member = await _service.GetFamilyMemberInfoAsync(familyId, memberId);
            var response = ApiResponse<FamilyMemberDto>.SuccessResponse(member, "success");
            return await Task.FromResult(response);
        }
    }
}
