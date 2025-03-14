namespace HappyFamily.Application.Interfaces.Services
{
    public interface IOtpService
    {
        Task<string> GenerateOtpAsync(string phoneNumber, string ipAddress, string deviceInfo);
        Task<string?> VerifyOtpAsync(string phoneNumber, string otp, string ipAddress, string deviceInfo);
    }
}
