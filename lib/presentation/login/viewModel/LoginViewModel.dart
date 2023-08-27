import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../domain/use_case/login_use_case.dart';
import '../../base/baseviewmodel.dart';
import '../../common/frezzed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _UserNamestreamController =
      StreamController<String>.broadcast();
  final StreamController _PasswordstreamController =
      StreamController<String>.broadcast();
  final StreamController _AllValidstreamController =
      StreamController<void>.broadcast();
  final StreamController isUserNameLoggedSeccessFullystreamController =
      StreamController<bool>();

  LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase);

  var loginobject = LoginObject("", "");

  @override
  void dispose() {
    _AllValidstreamController.close();
    _UserNamestreamController.close();
    _PasswordstreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  bool _IsPasswordValid(String Password) {
    return Password.isNotEmpty;
  }

  bool _IsUserNameValid(String UserName) {
    return UserName.isNotEmpty;
  }

  // Outputs
  @override
  Stream<bool> get IsPasswordValid => _PasswordstreamController.stream
      .map((Password) => _IsPasswordValid(Password));

  @override
  Stream<bool> get IsUserNameValid => _UserNamestreamController.stream
      .map((UserName) => _IsUserNameValid(UserName));

  // Inputs

  @override
  SetPassword(String Password) {
    inputPassword.add(Password);
    loginobject = loginobject.copyWith(password: Password);
    inputAllValid.add(null);
  }

  @override
  SetUserName(String userName) {
    inputUserName.add(userName);
    loginobject = loginobject.copyWith(username: userName);
    inputAllValid.add(null);
  }

  @override
  Sink get inputPassword => _PasswordstreamController.sink;

  @override
  Sink get inputUserName => _UserNamestreamController.sink;

  @override
  login(BuildContext context) async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await loginUseCase.execute(
            LoginUseCaseInput(loginobject.username, loginobject.password)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      stateRendererType: StateRendererType.popUpErrorState,
                      message: failure.massage))
                }, (data) {
      inputState.add(ContentState());
      isUserNameLoggedSeccessFullystreamController.add(true);

      // right -> data (success)
      // content
    });
  }

  @override
  Stream<bool> get IsAllValid =>
      _AllValidstreamController.stream.map((_) => AreAllValid());

  @override
  Sink get inputAllValid => _AllValidstreamController.sink;

  bool AreAllValid() {
    return _IsPasswordValid(loginobject.password) &&
        _IsUserNameValid(loginobject.username);
  }
}

abstract class LoginViewModelInputs {
  SetUserName(String userName);

  SetPassword(String Password);

  login(BuildContext context);

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAllValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get IsUserNameValid;

  Stream<bool> get IsPasswordValid;

  Stream<bool> get IsAllValid;
}
