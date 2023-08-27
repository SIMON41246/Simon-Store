import 'package:dartz/dartz.dart';


import '../../data/network/failure.dart';
import '../../data/network/request.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_use_case.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) {
    return repository.login(LoginRequest(input.email, input.password));
  }


}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
