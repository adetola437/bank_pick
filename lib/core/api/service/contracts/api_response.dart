abstract class ApiResponse<T> {
  String? get message;
  String get responseCode;
  dynamic get errors;
  T? get data;
}
