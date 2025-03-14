using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Exceptions;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace HappyFamily.Api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {

        private readonly ILogger<UserController> _logger;
        private readonly IUserProfileService _service;
        public UserController(ILogger<UserController> logger, IUserProfileService service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet("profile")]
        public async Task<ActionResult<ApiResponse<UserProfileDto>>> GetUserProfile()
        {
            var userClaims = User.Identity as ClaimsIdentity;
            if (userClaims == null)
                return Unauthorized("Invalid token or user not authenticated.");
            var userId = userClaims.FindFirst("UserId")?.Value;
            if (string.IsNullOrEmpty(userId))
                throw new CustomException("User details not found", 404);

            var userProfile = await _service.GetUserProfileByIdAsync(userId);

            return Ok(ApiResponse<UserProfileDto>.SuccessResponse(userProfile));

            // Extract claims
            //var phoneNumber = userClaims.FindFirst("PhoneNumber")?.Value;
            //var emailAddress = userClaims.FindFirst("EmailAddress")?.Value;
            //var lastLogin = userClaims.FindFirst("LastLogin")?.Value;
            //var role = userClaims.FindFirst("Role")?.Value;            
        }
    }
}
