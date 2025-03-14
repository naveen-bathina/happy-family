using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services
{
    public interface ISupportService
    {
        Task<List<SuppportTicketDto>> GetAllSupportTicketsAsync(int pageNumber, int pageSize);
    }
}
