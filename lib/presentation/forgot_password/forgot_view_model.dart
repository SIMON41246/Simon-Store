import 'dart:async';

import 'package:flutter/scheduler.dart';

import '../../app/functions.dart';
import '../../domain/use_case/forgot_password_use_case.dart';
import '../base/baseviewmodel.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelOutput, ForgotPasswordViewModelInput {
  final StreamController _emailstreamController =
      StreamController<String>.broadcast();
  final StreamController _allValidstreamController =
      StreamController<void>.broadcast();
  ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _forgotPasswordUseCase.execute(email)).fold(
        (failure) => inputState.add(ErrorState(
            stateRendererType: StateRendererType.popUpErrorState,
            message: failure.massage)),
        (success) => {
              inputState.add(SucessState(StateRendererType.sucessState,success)),
              /*SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Fluttertoast.showToast(
                    msg:
                        "we have sent an email to you, if you need any help, contact us on mohammedezrouil@gmail.com ",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: color_manager.primary,
                    textColor: color_manager.black,
                    fontSize: 16.0);
              })*/
            });
  }

  @override
  Sink get inputEmail => _emailstreamController.sink;

  @override
  Sink get inputIsAllInputValid => _allValidstreamController.sink;

  @override
  Stream<bool> get outputIsAllInputValid =>
      _emailstreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsEmailValid =>
      _allValidstreamController.stream.map((_) => isAllValid());

  bool isAllValid() {
    return isEmailValid(email);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _Validate();
  }

  _Validate() {
    inputIsAllInputValid.add(null);
  }

  @override
  void start() {
    inputState.add(ContentState());
  }
}

abstract class ForgotPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
