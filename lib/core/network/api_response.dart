class ApiResponse<T> {
  final bool success;
  final int statusCode;
  final T? data;
  final String? message;
  final String timestamp;

  const ApiResponse({
    required this.success,
    required this.statusCode,
    this.data,
    this.message,
    required this.timestamp,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJson,
  ) {
    return ApiResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      data: json['data'] != null && fromJson != null
          ? fromJson(json['data'])
          : null,
      message: json['message'],
      timestamp: json['timestamp'] ?? '',
    );
  }
}