using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Shared.DTOs;
using HappyFamily.Shared.Responses;
using Microsoft.AspNetCore.Mvc;

namespace HappyFamily.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SupportController : ControllerBase
    {
        private readonly ILogger<SupportController> _logger;
        private readonly ISupportService _service;
        public SupportController(ILogger<SupportController> logger, ISupportService service)
        {
            _logger = logger;
            _service = service;
        }


        [HttpGet(Name = "Get all tickets")]
        public async Task<ActionResult<ApiResponse<IEnumerable<SuppportTicketDto>>>> Get(int pageNumber, int pageSize)
        {
            var result = await _service.GetAllSupportTicketsAsync(pageNumber, pageSize);
            return ApiResponse<IEnumerable<SuppportTicketDto>>.SuccessResponse(result, "Successfully fetched support tickets");
        }
    }
}
