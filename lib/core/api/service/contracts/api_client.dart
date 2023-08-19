

import 'package:dartz/dartz.dart';

import '../../../enums/api_method_types.dart';
import '../../exceptions/contracts/failure.dart';
import 'api_response.dart';

abstract class IApiClient {
  Future<Either<Failure, ApiResponse<T>>> request<T>(
      String url,
      MethodType method,
      T Function(dynamic) fromJson,
      dynamic params,
      );

  Future<Either<Failure, ApiResponse<T>>> multipartRequest<T>(
      String url,
      MethodType method,
      T Function(dynamic) fromJson,
      dynamic params,
      );
}