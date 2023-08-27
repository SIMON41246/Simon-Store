import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../app/constants.dart';
import '../response/response.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseurl)
abstract class ApiServiceClient {
  factory ApiServiceClient(Dio dio, {String baseUrl}) = _ApiServiceClient;

  @POST("/customer/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @POST("/customer/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/customer/register")
  Future<AuthenticationResponse> register(
      @Field("user_name") String userName,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile_picture") String profilePicture);
}


