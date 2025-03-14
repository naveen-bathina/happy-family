class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({required this.success, required this.message, this.data});

  // Generic fromJson method (T should be handled manually)
  static ApiResponse<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      "success": success,
      "message": message,
      "data": data != null ? toJsonT(data as T) : null,
    };
  }

  // factory ApiResponse.fromJson(Map<String, dynamic> json) {
  //   return ApiResponse(
  //     success: json['success'],
  //     message: json['message'],
  //     data: json['data'],
  //   );
  // }
}
