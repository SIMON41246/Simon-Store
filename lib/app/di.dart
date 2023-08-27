import 'package:dio/dio.dart';
import 'package:ecommerce_app/presentation/base/baseviewmodel.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/app_api.dart';
import '../data/network/connection_checker.dart';
import '../data/network/dio_factory.dart';
import '../data/remote_data_source/local_data_source.dart';
import '../data/remote_data_source/remote_data_source.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/use_case/forgot_password_use_case.dart';
import '../domain/use_case/login_use_case.dart';
import '../domain/use_case/register_use_case.dart';
import '../presentation/forgot_password/forgot_view_model.dart';
import '../presentation/login/viewModel/LoginViewModel.dart';
import '../presentation/register/view_model/register_view_model.dart';
import 'app_preferences.dart';

final instance = Get.put(GetIt.I);

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton(() => sharedPreferences);

  instance
      .registerLazySingleton<AppPrefrences>(() => AppPrefrences(instance()));

  // Network Info
  instance.registerLazySingleton(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // Dio Factory
  instance.registerLazySingleton(() => DioFactory(instance()));

  // App Service Client
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<ApiServiceClient>(() => ApiServiceClient(dio));

  // Remote Data Source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // Local DataSource
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // Repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
  instance.registerFactory<ImagePicker>(() => ImagePicker());


}

Future<void> initLoginModule() async {
  // LoginUseCase
  if (!Get.isRegistered<LoginUseCase>()) {
    instance.registerFactory(() => LoginUseCase(instance()));
    instance.registerFactory(() => LoginViewModel(instance()));
  }
}

Future<void> initForgotPasswordModule() async {
  if (!Get.isRegistered<ForgotPasswordUseCase>()) {
    // Forgot Password UseCase
    instance.registerFactory(() => ForgotPasswordUseCase(instance()));
    // Forgot Password View
    instance.registerFactory(() => ForgotPasswordViewModel(instance()));
  }
}

Future<void> initRegisterModule() async {
  if (!Get.isRegistered<RegisterUseCase>()) {
    // Register UseCase
    instance.registerFactory(() => RegisterUseCase(instance()));
    // Register View
    instance.registerFactory(() => RegisterViewModel(instance()));
  }
}
