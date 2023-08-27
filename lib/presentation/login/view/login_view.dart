import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart' hide Trans;

import '../../../app/app_preferences.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';
import '../viewModel/LoginViewModel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPrefrences _appPreferences = instance<AppPrefrences>();
  final TextEditingController _UserNameeditingController =
      TextEditingController();
  final TextEditingController _PasswordeditingController =
      TextEditingController();

  final _key = GlobalKey<FormState>();

  _Bind() {
    _viewModel.start();
    _PasswordeditingController.addListener(
        () => _viewModel.SetPassword(_PasswordeditingController.text));
    _UserNameeditingController.addListener(
        () => _viewModel.SetUserName(_UserNameeditingController.text));
    _viewModel.isUserNameLoggedSeccessFullystreamController.stream
        .listen((isLogged) {
      if (isLogged) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedInSuccesFully();
          Get.offNamed(Routes.mainRoute);
          ;
        });
      }
    });
  }

  @override
  void initState() {
    _Bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_manager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, getContentView(), () {
                _viewModel.login(context);
              }) ??
              getContentView();
        },
      ),
    );
  }

  Widget getContentView() {
    return Form(
      child: SingleChildScrollView(
        key: _key,
        child: Container(
          padding: const EdgeInsets.only(top: AppPaddingManager.p80),
          child: Column(
            children: [
              const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo))),
              Padding(
                padding: EdgeInsets.only(
                    right: AppPaddingManager.p28, left: AppPaddingManager.p28),
                child: StreamBuilder<bool>(
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _UserNameeditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: AppStrings.Username.tr(),
                          labelText: AppStrings.Username.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.UsernameError.tr()),
                    );
                  },
                  stream: _viewModel.IsUserNameValid,
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: AppPaddingManager.p28, left: AppPaddingManager.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.IsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _PasswordeditingController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: AppStrings.Password.tr(),
                          labelText: AppStrings.Password.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.PasswordError.tr()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: AppPaddingManager.p28, left: AppPaddingManager.p28),
                child: StreamBuilder<bool>(
                  builder: (context, snapshot) {
                    return ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.login(context);
                              }
                            : null,
                        child: Text(AppStrings.Login.tr()));
                  },
                  stream: _viewModel.IsAllValid,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppPaddingManager.p8,
                    right: AppPaddingManager.p28,
                    left: AppPaddingManager.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.ForgotPasswordRoute);
                        },
                        child: Text(
                          "Forgot Password",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.registerRoute);
                        },
                        child: Text(
                          "Not a member ? Sign up",
                          style: Theme.of(context).textTheme.titleMedium,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
