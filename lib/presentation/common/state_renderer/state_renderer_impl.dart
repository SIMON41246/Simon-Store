import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/material.dart';

import '../../../app/constants.dart';
import '../../resources/string_manager.dart';

abstract class FlowState {
  StateRendererType getstateRendererType();

  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {required this.stateRendererType, String message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading.tr();

  @override
  StateRendererType getstateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message ?? AppStrings.retryAgain.tr();

  @override
  StateRendererType getstateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getstateRendererType() => StateRendererType.contentState;
}

class SucessState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  SucessState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getstateRendererType() => stateRendererType;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getstateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionDunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getstateRendererType() == StateRendererType.popUpLoadingState) {
            //ShowPopUp Loading
            showPopUp(context, getstateRendererType(), getMessage());
            // Show content of the screen
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getstateRendererType(),
              retryactionfunction: retryActionDunction,
              message: getMessage(),
            );
          }
        }

      case ErrorState:
        {
          dismissDialog(context);
          if (getstateRendererType() == StateRendererType.popUpErrorState) {
            //ShowPopUp Loading
            showPopUp(context, getstateRendererType(), getMessage());
            // Show content of the screen
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getstateRendererType(),
              retryactionfunction: retryActionDunction,
              message: getMessage(),
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getstateRendererType(),
            retryactionfunction: retryActionDunction,
            message: getMessage(),
          );
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case SucessState:
        {
          dismissDialog(context);
          showPopUp(context, StateRendererType.sucessState, getMessage());
          return contentScreenWidget;
        }

      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
                stateRendererType: stateRendererType,
                retryactionfunction: () {},
                message: message,
              ));
    });
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
