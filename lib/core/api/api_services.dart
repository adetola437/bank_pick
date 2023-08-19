
import 'package:dartz/dartz.dart';
import '../data/models/login.dart';
import 'exceptions/contracts/failure.dart';
import 'service/contracts/api_response.dart';

abstract class ApiServices{
  Future<Either<Failure, ApiResponse<Login>>> login(String username, String password);
}