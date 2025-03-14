using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PollsController : ControllerBase
    {
        private readonly IPollService _pollsService;
        private readonly ILogger<PollsController> _logger;

        public PollsController(ILogger<PollsController> logger, IPollService pollsService)
        {
            _logger = logger;
            _pollsService = pollsService;
        }

        // GET: api/polls
        [HttpGet]
        public async Task<ActionResult<ApiResponse<IEnumerable<PollDto>>>> GetPollsAsync()
        {
            var polls = await _pollsService.GetAllPollsAsync();
            var response = ApiResponse<IEnumerable<PollDto>>.SuccessResponse(polls, "Event fetched successfully");
            return Ok(response);
        }
    }
}
