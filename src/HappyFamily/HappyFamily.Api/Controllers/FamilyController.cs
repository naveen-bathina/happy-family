using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using System.Security.Claims;

namespace HappyFamily.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FamilyController : ControllerBase
    {
        private readonly IFamilyService _familyService;
        private readonly ILogger<FamilyController> _logger;
        private readonly IMapper _mapper;

        public FamilyController(IFamilyService familyService, ILogger<FamilyController> logger, IMapper mapper)
        {
            _familyService = familyService;
            _logger = logger;
            _mapper = mapper;
        }

        /// <summary>
        /// Get a paginated list of families.
        /// </summary>
        [HttpGet]
        public async Task<ActionResult<ApiResponse<List<FamilyDto>>>> GetFamilies([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10)
        {
            var families = await _familyService.GetAllFamiliesAsync(pageNumber, pageSize);
            return Ok(ApiResponse<List<FamilyDto>>.SuccessResponse(families));
        }

        /// <summary>
        /// Get a family by ID.
        /// </summary>
        [HttpGet("{id}")]
        public async Task<ActionResult<ApiResponse<FamilyDto>>> GetFamilyById(string id)
        {
            var family = await _familyService.GetFamilyByIdAsync(id);
            return Ok(ApiResponse<FamilyDto>.SuccessResponse(family));
        }

        /// <summary>
        /// Create a new family.
        /// </summary>
        [HttpPost]
        public async Task<ActionResult<ApiResponse<string>>> CreateFamily([FromBody] JoinFamilyDto familyDto)
        {
            //var identity = HttpContext.User.Identity as ClaimsIdentity;
            //if (identity != null)
            //{
            //    IEnumerable<Claim> claims = identity.Claims;
            //    // or
            //    identity.FindFirst("ClaimName").Value;

            //}
            var data = _mapper.Map<FamilyDto>(familyDto);
            await _familyService.CreateFamilyAsync(data);
            return CreatedAtAction(nameof(GetFamilyById), new { id = data.Id }, ApiResponse<string>.SuccessResponse("Family created successfully"));
        }

        /// <summary>
        /// Update an existing family.
        /// </summary>
        [HttpPut("{id}")]
        public async Task<ActionResult<ApiResponse<string>>> UpdateFamily(string id, [FromBody] FamilyDto familyDto)
        {
            await _familyService.UpdateFamilyAsync(id, familyDto);
            return Ok(ApiResponse<string>.SuccessResponse("Family updated successfully"));
        }

        /// <summary>
        /// Delete a family by ID.
        /// </summary>
        [HttpDelete("{id}")]
        public async Task<ActionResult<ApiResponse<string>>> DeleteFamily(string id)
        {
            await _familyService.DeleteFamilyAsync(id);
            return Ok(ApiResponse<string>.SuccessResponse("Family deleted successfully"));
        }

        [HttpPost("join")]
        public async Task<ActionResult<ApiResponse<string>>> Join(JoinFamilyDto joinFamilyDto)
        {
            await _familyService.JoinAsync(joinFamilyDto);
            return Ok();
        }

        [Authorize]
        [HttpPost("join-with-code")]
        public async Task<ActionResult<ApiResponse<FamilyDto>>> JoinWithCode([FromBody] JoinFamilyWithCodeRequest request)
        {

            var identity = HttpContext.User.Identity as ClaimsIdentity;
            if (identity != null)
            {
                IEnumerable<Claim> claims = identity.Claims;

                var userId = claims.First(x => x.Type == "UserId").Value;
                var phoneNumber = claims.First(x => x.Type == "PhoneNumber").Value;
                var emailAddress = claims.First(x => x.Type == "EmailAddress").Value;
                var role = claims.First(x => x.Type == "Role").Value;

                var family = await _familyService.AddMemberAsync(userId, request.FamilyCode);
                return Ok(ApiResponse<FamilyDto>.SuccessResponse(family, $"You joined family with code {family.Code}"));
            }

            return Ok(ApiResponse<FamilyDto>.FailureResponse("Failed to join family code"));

        }

        [Authorize]
        [HttpPost("create-with-name")]
        public async Task<ActionResult<ApiResponse<string>>> CreateFamilyWithName([FromBody] CreateFamilyWithNameRequest request)
        {
            var accessToken = HttpContext.Request.Headers[HeaderNames.Authorization];
            return Ok(ApiResponse<string>.SuccessResponse("Happy Family", $"You created family with  name {request.FamilyName} "));
        }
    }
}
