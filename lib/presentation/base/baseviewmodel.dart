import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {
  // Shared variables and functions used through any viewModel
  StreamController inputStateConroller =
      BehaviorSubject<FlowState>();

  @override
  void dispose() {
    inputStateConroller.close();
  }

  @override
  Sink get inputState => inputStateConroller.sink;

  @override
  Stream<FlowState> get outputState =>
      inputStateConroller.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start(); // View model start job

  void dispose(); // ViewModel end job
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
