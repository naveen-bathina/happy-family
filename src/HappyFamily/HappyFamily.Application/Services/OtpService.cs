using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Interfaces.Repositories;
using HappyFamily.Shared.Exceptions;

namespace HappyFamily.Application.Services
{
    public class OtpService : IOtpService
    {
        private readonly IUserRepository _userRepository;
        private readonly IJwtService _jwtService;

        public OtpService(IUserRepository userRepository, IJwtService jwtService)
        {
            _userRepository = userRepository;
            _jwtService = jwtService;
        }


        public async Task<string> GenerateOtpAsync(string phoneNumber, string ipAddress, string deviceInfo)
        {
            var otp = new Random().Next(100000, 999999).ToString();
            var expiryTime = DateTime.UtcNow.AddMinutes(5); // OTP expires in 5 minutes

            var existingUser = await _userRepository.GetUserByPhoneNumberAsync(phoneNumber);
            
            if (existingUser == null)
            {
                var createdUser = await _userRepository.CreateAsync(new Domain.Entities.User() { PhoneNumber = phoneNumber }) ?? throw new CustomException("User Not found, please try register!", 400);
            }

            await _userRepository.AddLoginHistoryAsync(phoneNumber, ipAddress, deviceInfo, otp, false, expiryTime);

            // Send OTP via SMS (Replace with actual SMS gateway)
            Console.WriteLine($"OTP for {phoneNumber}: {otp}");

            return otp;
        }

        public async Task<string?> VerifyOtpAsync(string phoneNumber, string otp, string ipAddress, string deviceInfo)
        {
            var user = await _userRepository.GetUserByPhoneNumberAsync(phoneNumber) ?? throw new CustomException("User Not found, please try register!", 400);
            
            var loginAttempt = user.LoginHistory
                .Where(lh => lh.Otp == otp && !lh.IsVerified && lh.ExpiresAt > DateTime.UtcNow)
                .OrderByDescending(lh => lh.Timestamp)
                .FirstOrDefault() ?? throw new CustomException("Invalid Otp, please try again!", 400);
            await _userRepository.AddLoginHistoryAsync(phoneNumber, ipAddress, deviceInfo, otp, true, DateTime.UtcNow);

            return _jwtService.GenerateToken(user);
        }
    }
}
