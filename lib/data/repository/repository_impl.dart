import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/response/response.dart';
import 'package:ecommerce_app/domain/mappers/mappers.dart';

import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import '../network/connection_checker.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/request.dart';
import '../remote_data_source/local_data_source.dart';
import '../remote_data_source/remote_data_source.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  LocalDataSource _localDataSource;
  NetworkInfoImpl networkInfoImpl;

  RepositoryImpl(
      this.networkInfoImpl, this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(1, response.message ?? ""));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


}
