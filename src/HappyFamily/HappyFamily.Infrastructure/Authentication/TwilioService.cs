

using Microsoft.Extensions.Configuration;
using Twilio;
using Twilio.Rest.Api.V2010.Account;
using Twilio.Types;

namespace HappyFamily.Infrastructure.Authentication;

public class TwilioService
{
    private readonly string _accountSid;
    private readonly string _authToken;
    private readonly string _fromNumber;

    public TwilioService(IConfiguration configuration)
    {
        _accountSid = configuration["Twilio:AccountSid"] ?? "";
        _authToken = configuration["Twilio:AuthToken"] ?? "";
        _fromNumber = configuration["Twilio:FromNumber"] ?? "";
        TwilioClient.Init(_accountSid, _authToken);
    }

    public async Task<string> SendOtpAsync(string phoneNumber, string otp)
    {
        var message = await MessageResource.CreateAsync(
            body: $"Your OTP code is: {otp}",
            from: new PhoneNumber(_fromNumber),
            to: new PhoneNumber(phoneNumber)
        );

        return message.Sid;
    }
}