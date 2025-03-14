using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AboutController : ControllerBase
    {
        private readonly ILogger<AboutController> _logger;
        private readonly IAboutService _service;
        public AboutController(ILogger<AboutController> logger, IAboutService service)
        {
            _logger = logger;
            _service = service;
        }


        [HttpGet(Name = "about")]
        public async Task<ActionResult<ApiResponse<AboutDto>>> Get()
        {
            var data = await _service.GetDefault();
            return Ok(ApiResponse<AboutDto>.SuccessResponse(data, "Got about us"));
        }

        [HttpPost(Name = "create about")]
        public async Task<ActionResult<ApiResponse<string>>> Post([FromBody] AboutRequest request) 
        {
            await _service.CreateAboutAsync(request);
            return Ok(ApiResponse<string>.SuccessResponse(string.Empty, "Created new about"));
        }
    }
}
