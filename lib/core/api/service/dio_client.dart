// import 'dart:developer';
// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_performance_dio/firebase_performance_dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// import '../../../config/flavor/flavor.dart';
// import '../../enums/api_method_types.dart';
// import '../exceptions/api_exception.dart';
// import '../exceptions/contracts/failure.dart';
// import '../network/network_info.dart';
// import 'api_response_impl.dart';
// import 'contracts/api_client.dart';
// import 'contracts/api_response.dart';

// class DioClient implements IApiClient {
//   late Dio _dio;
//   late NetworkInfo networkInfo;

//   ///setup [optional here, should be part of app initializer class]
//   static void setup() {
//     GetIt.instance.registerFactoryParam<DioClient, NetworkInfo, void>(
//           (networkInfoImpl, _) => DioClient.createInstance(networkInfoImpl),
//     );
//   }

//   factory DioClient.createInstance(NetworkInfo value) {
//     return DioClient(value);
//   }

//   //static DioClient get instance => GetIt.I<DioClient>();

//   DioClient(this.networkInfo) {
//     _dio = Dio(BaseOptions(baseUrl: env.baseUrl))
//       ..interceptors.add(DioFirebasePerformanceInterceptor())
//       ..interceptors.add(
//         PrettyDioLogger(
//             requestHeader: true,
//             requestBody: true,
//             responseBody: true,
//             responseHeader: false,
//             error: true,
//             compact: true,
//             maxWidth: 90),
//       );
//   }

//   @override
//   Future<Either<Failure, ApiResponse<T>>> request<T>(String url,
//       MethodType method, T Function(dynamic) fromJson,
//       [dynamic params]) async {
//     try {
//       Response response;
//       if (await networkInfo.isConnected()) {
//         // _dio.transformer = MyTransformer<T>();
//         if (method == MethodType.post) {
//           response = await _dio.post(url, data: params);
//         } else if (method == MethodType.delete) {
//           response = await _dio.delete(url);
//         } else if (method == MethodType.patch) {
//           response = await _dio.patch(url);
//         } else {
//           response = await _dio.get(
//             url,
//           );
//         }

//         //log(requestResponse.toString(), name: "requestResponse");
//         if (_isRequestSuccessful(response.statusCode)) {
//           var requestResponse = ApiResponseImpl<T>(
//             fromJson(response.data['data']),
//             response.data['errors'],
//             response.data['message'],
//             response.data['responseCode'],
//           );
//           return right(requestResponse);
//         }
//         var requestResponse = ApiResponseImpl<T>(
//           null,
//           response.data['errors'],
//           response.data['message'],
//           response.data['responseCode'],
//         );
//         return left(ValidationFailure(requestResponse.message));
//       } else {
//         return left(InternetFailure());
//       }
//     } on DioException catch (dioError) {
//       return left(_handleDioError(dioError));
//     }
//   }

//   @override
//   Future<Either<Failure, ApiResponse<T>>> multipartRequest<T>(
//       String url,
//       MethodType method,
//       T Function(dynamic) fromJson,
//       dynamic params) async {
//     try {
//       Response response;
//       if (await networkInfo.isConnected()) {
//         response = await _dio.post(url,
//             data: params,
//             options: Options(headers: {
//               "Content-Type": "multipart/form-data",
//             }));

//         if (_isRequestSuccessful(response.statusCode)) {
//           var requestResponse = ApiResponseImpl<T>(
//             fromJson(response.data['data']),
//             response.data['errors'],
//             response.data['message'],
//             response.data['responseCode'],
//           );
//           return right(requestResponse);
//         }
//         var requestResponse = ApiResponseImpl<T>(
//           null,
//           response.data['errors'],
//           response.data['message'],
//           response.data['responseCode'],
//         );
//         return left(ValidationFailure(requestResponse.message));
//       } else {
//         return left(InternetFailure());
//       }
//     } on DioException catch (dioError) {
//       return left(_handleDioError(dioError));
//     }
//   }

//   bool _isRequestSuccessful(int? statusCode) =>
//       statusCode == 200 || statusCode == 201;

//   Failure _handleDioError(DioException error) {
//     if (error.error != null && error.error is SocketException) {
//       return InternetFailure();
//     }

//     late Failure failureType;
//     switch (error.type) {
//       case DioExceptionType.cancel:
//         failureType = CancelFailure();
//         break;
//       case DioExceptionType.connectionTimeout:
//         failureType = ConnectionTimeOutFailure();
//         break;
//       case DioExceptionType.connectionError:
//         failureType = ConnectionFailure();
//         break;
//       case DioExceptionType.badCertificate:
//         failureType = BadCertificateFailure();
//         break;
//       case DioExceptionType.badResponse:
//         failureType =
//             BadResponseFailure();
//         break;
//       case DioExceptionType.receiveTimeout:
//         failureType = ReceivedTimeOutFailure();
//         break;
//       case DioExceptionType.sendTimeout:
//         failureType = SendTimeOutFailure();
//         break;
//       case DioExceptionType.unknown:
//         failureType = ServerFailure();
//         break;
//     }
//     return failureType;
//   }
// }
