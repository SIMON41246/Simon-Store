import 'package:ecommerce_app/presentation/main/pages/cart_page/cart_page.dart';
import 'package:ecommerce_app/presentation/main/pages/main_view/main_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../app/binding.dart';
import '../Register/view/register_view.dart';
import '../forgot_password/forgot_password.dart';
import '../login/view/login_view.dart';
import '../onBoarding/view/onBoarding_view.dart';
import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String LoginRoute = "/login";
  static const String registerRoute = "/register";
  static const String ForgotPasswordRoute = "/forgotPassword";
  static const String OnBoardingRoute = "/OnBoardingRoute";
  static const String mainRoute = "/main";
  static const String cartRoute = "/cart";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteConstant {
  static List<GetPage> getPages = [
    GetPage(
        name: Routes.LoginRoute,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.ForgotPasswordRoute,
        page: () => const ForgotPasswordView(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: Routes.registerRoute,
        page: () => const RegisterView(),
        binding: RegisterBinding()),
    GetPage(
      name: Routes.splashRoute,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.OnBoardingRoute,
      page: () => const OnboardingView(),
    ),
    GetPage(
      name: Routes.mainRoute,
      page: () => const MainView(),
    ),
    GetPage(
      name: Routes.cartRoute,
      page: () => const CartPage(),
    ),
  ];
}
