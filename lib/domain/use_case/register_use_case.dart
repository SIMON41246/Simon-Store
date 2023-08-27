import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/request.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_use_case.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterRequestInput, Authentication> {
  Repository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterRequestInput input)async {
    return await repository.register(RegisterRequest(
        input.userName,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password,
        input.profilePicture));
  }
}

class RegisterRequestInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterRequestInput(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.profilePicture);
}
