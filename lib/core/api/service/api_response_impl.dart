
// Concrete implementation of ApiResponse
import 'contracts/api_response.dart';

class ApiResponseImpl<T> implements ApiResponse<T> {

  final T? _data;
  final String _message;
  final dynamic _errors;
  final String _responseCode;

  ApiResponseImpl(this._data, this._errors, this._message, this._responseCode);

  @override
  T? get data => _data;

  @override
  String get responseCode => _responseCode;

  @override
  String get message => _message;

  @override
  dynamic get errors => _errors;

}