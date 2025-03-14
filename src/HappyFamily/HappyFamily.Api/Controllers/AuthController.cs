using AutoMapper;
using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IOtpService _otpService;
        private readonly IUserProfileService _userProfileService;
        private readonly IMapper _mapper;
        public AuthController(IOtpService otpService, IUserProfileService userProfileService, IMapper mapper)
        {
            _otpService = otpService;
            _userProfileService = userProfileService;
            _mapper = mapper;
        }

        [HttpPost("request-otp")]
        public async Task<ActionResult<ApiResponse<bool>>> RequestOtp([FromBody] OtpRequest request)
        {
            var ipAddress = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Unknown";
            var userAgent = Request.Headers["User-Agent"].ToString();

            var otp = await _otpService.GenerateOtpAsync(request.PhoneNumber, ipAddress, userAgent);
            return Ok(ApiResponse<bool>.SuccessResponse(true,"OTP sent successfully"));

        }

        [HttpPost("verify-otp")]
        public async Task<IActionResult> VerifyOtp([FromBody] VerifyOtpRequest request)
        {
            var ipAddress = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Unknown";
            var userAgent = Request.Headers["User-Agent"].ToString();

            var token = await _otpService.VerifyOtpAsync(request.PhoneNumber, request.Otp, ipAddress, userAgent);
            if (token == null) return BadRequest(ApiResponse<string>.FailureResponse("Invalid or expired OTP"));

            return Ok(ApiResponse<string>.SuccessResponse(token, "OTP verified successfully"));
        }

        [HttpPost("join")]
        public async Task<ActionResult<ApiResponse<string>>> Join([FromBody] JoinFamilyDto joinFamily)
        {
            var profileDto = _mapper.Map<UserProfileDto>(joinFamily);
            await _userProfileService.JoinFamily(profileDto);
            return Ok();
        }
    }
}
