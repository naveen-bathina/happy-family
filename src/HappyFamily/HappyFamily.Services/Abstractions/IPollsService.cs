using HappyFamily.Common.DTOs;

namespace HappyFamily.Services.Abstractions
{
    public interface IPollsService
    {
        IEnumerable<PollDto> GetPolls();
    }
}
