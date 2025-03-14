using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services;
public interface IPollService
{
    Task<List<PollDto>> GetAllPollsAsync(int pageNumber = 1, int pageSize = 10);
    Task<PollDto> GetPollByIdAsync(Guid id);
    Task CreatePollAsync(PollDto PollDto);
    Task<bool> UpdatePollAsync(Guid id, PollDto PollDto);
    Task<bool> DeletePollAsync(Guid id);
}
