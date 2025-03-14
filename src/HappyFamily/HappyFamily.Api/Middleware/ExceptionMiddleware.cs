using HappyFamily.Shared.Exceptions;
using HappyFamily.Shared.Responses;
using System.Net;
using System.Text.Json;

namespace HappyFamily.Api.Middleware
{
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ExceptionMiddleware> _logger;

        public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (CustomException ex) // Handle CustomException
            {
                _logger.LogWarning($"Custom Exception: {ex.Message}");
                await HandleExceptionAsync(context, ex.StatusCode, ex.Message);
            }
            catch (Exception ex) // Handle Unhandled Exceptions
            {
                _logger.LogError($"Unhandled Exception: {ex}");
                await HandleExceptionAsync(context, (int)HttpStatusCode.InternalServerError, "An unexpected error occurred.");
            }
        }

        private static Task HandleExceptionAsync(HttpContext context, int statusCode, string message)
        {
            context.Response.ContentType = "application/json";
            context.Response.StatusCode = statusCode;

            var response = ApiResponse<string>.FailureResponse(message);

            return context.Response.WriteAsync(JsonSerializer.Serialize(response));
        }
    }
}
