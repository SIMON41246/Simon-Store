import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/response/response.dart';

import '../../data/network/failure.dart';
import '../../data/network/request.dart';
import '../models/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, String>> forgotPassword(String email);

  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);

}
