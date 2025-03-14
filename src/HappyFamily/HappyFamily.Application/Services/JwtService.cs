using HappyFamily.Application.Interfaces.Services;
using HappyFamily.Domain.Entities;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace HappyFamily.Application.Services
{
    public class JwtService : IJwtService
    {
        private readonly string _secretKey;
        private readonly int _expiryMinutes;
        private readonly string _issuer;
        private readonly string _audience;

        public JwtService(IConfiguration configuration)
        {
            _secretKey = configuration["JwtSettings:SecretKey"] ?? throw new ArgumentNullException("JWT Secret Key is missing!");
            _expiryMinutes = int.Parse(configuration["JwtSettings:ExpiryMinutes"] ?? "60"); // Default: 60 minutes
            _issuer = configuration["JwtSettings:Issuer"] ?? throw new ArgumentNullException("JWT Issuer is missing!");
            _audience = configuration["JwtSettings:Audience"] ?? throw new ArgumentNullException("JWT Audience is missing!");
        }

        public string GenerateToken(User user)
        {
            if (string.IsNullOrEmpty(_secretKey))
                throw new InvalidOperationException("JWT secret key is not configured properly.");

            var keyBytes = Encoding.UTF8.GetBytes(_secretKey);
            if (keyBytes.Length < 32) // Ensure at least 256 bits
                throw new InvalidOperationException("JWT secret key must be at least 256 bits long.");

            var key = new SymmetricSecurityKey(keyBytes);
            var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Id),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim("UserId",user.Id),
                new Claim("PhoneNumber", user.PhoneNumber),
                new Claim("EmailAddress", user.EmailAddress ?? string.Empty),
                new Claim("Role", "User"), // Add role-based access if needed
                new Claim("LastLogin", DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString()) // Unix Timestamp
            };

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.UtcNow.AddMinutes(_expiryMinutes),
                Issuer = _issuer,
                Audience = _audience,
                SigningCredentials = credentials
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);

            return tokenHandler.WriteToken(token);
        }
    }
}
