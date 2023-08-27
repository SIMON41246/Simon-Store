import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

enum StateRendererType {
  //POPUP
  popUpLoadingState,
  popUpErrorState,

  //FullScreen
  fullScreenLoading,
  fullScreenErrorState,
  fullScreenEmptyState,

  //General
  contentState,
  sucessState
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryactionfunction;

  StateRenderer(
      {required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = "",
      required this.retryactionfunction});

  @override
  Widget build(BuildContext context) {
    return getContentState(context);
  }

  Widget getContentState(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popUpLoadingState:
        return getPopUpDialog(context, [getAnimatedJson(JsonAssets.loading)]);
      case StateRendererType.popUpErrorState:
        return getPopUpDialog(context, [
          getAnimatedJson(JsonAssets.error),
          getMessage(message),
          getTryButtonAction(AppStrings.ok.tr(), context)
        ]);
      case StateRendererType.fullScreenLoading:
        return getItemsColumn([
          getAnimatedJson(JsonAssets.loading),
          getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return getItemsColumn([
          getAnimatedJson(JsonAssets.error),
          getMessage(message),
          getTryButtonAction(AppStrings.retryAgain.tr(), context)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return getItemsColumn([
          getAnimatedJson(JsonAssets.empty),
          getMessage(message),
        ]);
      case StateRendererType.sucessState:
        return getPopUpDialog(context, [
          getAnimatedJson(JsonAssets.sucess),
          getMessage(message),
          getTryButtonAction(AppStrings.ok.tr(), context)
        ]);
      case StateRendererType.contentState:
        return Container();

      default:
        return Container();
    }
  }

  Widget getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: color_manager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [BoxShadow(color: Colors.black26)]),
        child: getDialoContent(context, children),
      ),
    );
  }

  Widget getDialoContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget getAnimatedJson(String animationName) {
    return SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: Lottie.asset(animationName));
  }

  Widget getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddingManager.p18),
        child: Text(
          message,
          style: getRegularStyle(
              color: color_manager.black, fontsize: FontSize.s16),
        ),
      ),
    );
  }

  Widget getTryButtonAction(String buttontitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddingManager.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.fullScreenErrorState) {
                  return retryactionfunction.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(buttontitle)),
        ),
      ),
    );
  }
}
