import 'api_error.dart';

class ApiResponse<T> {
  final T? data;
  final ApiError? error;

  ApiResponse({this.data, this.error});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    data: json['data'],
    error: json['error'] != null ? ApiError(message: json['error']) : null,
  );
}
