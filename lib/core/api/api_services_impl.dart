
import 'package:dartz/dartz.dart';

import '../data/models/login.dart';
import '../enums/api_method_types.dart';
import 'api_services.dart';
import 'exceptions/contracts/failure.dart';
import 'service/contracts/api_client.dart';
import 'service/contracts/api_response.dart';
import 'service/endpoints.dart';

class ApiServicesImpl implements ApiServices{

  final IApiClient apiClient;

  ApiServicesImpl({required this.apiClient});

  @override
  Future<Either<Failure, ApiResponse<Login>>> login(String username, String password) => apiClient.request(ApiEndpoint.login, MethodType.post, (response) => Login.fromJson(response), {"username": username, "password": password});
}