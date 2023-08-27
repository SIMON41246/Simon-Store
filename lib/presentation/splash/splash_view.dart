import 'dart:async';

import 'package:ecommerce_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_preferences.dart';
import '../../app/di.dart';
import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPrefrences _appPreferences = instance<AppPrefrences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedInSuccesFully().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              Get.offNamed(Routes.mainRoute)
            }
          else
            {
              _appPreferences
                  .isOnBoardingViewScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            // navigate to login screen

                            Get.offNamed(Routes.LoginRoute)
                          }
                        else
                          {
                            // navigate to onboarding screen

                            Get.toNamed(Routes.OnBoardingRoute)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_manager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
