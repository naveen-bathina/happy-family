namespace HappyFamily.Common.Response
{
    public class ResponseBase<T>
    {
        public ResponseBase(string responseCode, string responseMessage, bool hasError, T data)
        {
            ResponseCode = responseCode;
            ResponseMessage = responseMessage;
            HasError = hasError;
            Data = data;
        }

        public string ResponseCode { get; set; }
        public string ResponseMessage { get; set; }
        public bool HasError { get; set; }
        public T Data { get; set; }
    }


    public class SuccessResponse<T> : ResponseBase<T>
    {
        public SuccessResponse(string responseCode, string responseMessage, T data) : base(responseCode, responseMessage, false, data)
        {

        }
    }

    public class ErrorResponse<T> : ResponseBase<T>
    {
        public ErrorResponse(string responseCode, string responseMessage) : base(responseCode, responseMessage, true, default)
        {

        }
    }
}
