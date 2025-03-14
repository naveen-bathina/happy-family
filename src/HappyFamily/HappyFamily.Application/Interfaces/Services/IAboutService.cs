using HappyFamily.Shared.DTOs;

namespace HappyFamily.Application.Interfaces.Services
{
    public interface IAboutService
    {
        Task<AboutDto> GetDefault();
        Task<AboutDto> GetAboutAsync(string id);
        Task<bool> UpdateAboutAsync(string id, AboutDto aboutDto);
        Task CreateAboutAsync(AboutRequest request);
    }
}
