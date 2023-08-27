import 'package:http/http.dart' as http;

import '../network/app_api.dart';
import '../network/request.dart';
import '../response/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgotPasswordResponse> forgotPassword(String email);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

}

class RemoteDataSourceImpl implements RemoteDataSource {
  ApiServiceClient apiServiceClient;

  RemoteDataSourceImpl(this.apiServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) {
    return apiServiceClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await apiServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await apiServiceClient.register(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        "");
  }

}
