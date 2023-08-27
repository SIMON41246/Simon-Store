import 'package:get/get.dart';

import '../presentation/main/pages/home/controller.dart';
import 'di.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    initAppModule();
    initLoginModule();
    initForgotPasswordModule();
    initRegisterModule();
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize dependencies for the Login route
    initLoginModule();
  }
}

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize dependencies for the ForgotPassword route
    initForgotPasswordModule();
  }
}

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    initAppModule();
    // Initialize dependencies for the Register route
    initRegisterModule();
  }
}


class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataController>(
          () => DataController(),
    );
  }
}