import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_use_case.dart';

class ForgotPasswordUseCase extends BaseUseCase<String, String> {
  Repository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, String>> execute(String input) {
    return repository.forgotPassword(input);
  }
}
