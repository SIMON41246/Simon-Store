import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import '../../../domain/models/models.dart';
import '../../base/baseviewmodel.dart';
import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';

class OnboardingViewModel extends BaseViewModel
    implements OnboardingViewModelInputs, OnboardingViewModelOutputs {
  // Declare Stream Controller
  StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SlideObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
    // TODO: implement dispose
  }

  @override
  void start() {
    _list = _getSlideObject();
    postDataToview();
  }

  @override
  int goNext() {
    int nextindex = ++_currentIndex;
    if (nextindex == _list.length) {
      nextindex = 0;
    }
    return nextindex;
  }

  @override
  int goPrevious() {
    int previousindex = --_currentIndex;
    if (previousindex == -1) {
      previousindex = _list.length - 1;
    }
    return previousindex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    postDataToview();
  }

  @override
  Sink get inputslideViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSlideViewObject =>
      _streamController.stream.map((event) => event);

  void postDataToview() {
    inputslideViewObject.add(
        SliderViewObject(_list[_currentIndex], _currentIndex, _list.length));
  }

  // Onboarding page
  List<SlideObject> _getSlideObject() => [
        SlideObject(
            AppStrings.onboardingTitle.tr(),
            AppStrings.onboardingsubtitle.tr(),
            ImageAssets.Onboardinglogo1),
        SlideObject(
            AppStrings.onboardingTitle2.tr(),
            AppStrings.onboardingsubtitle2.tr(),
            ImageAssets.Onboardinglogo2),
        SlideObject(
            AppStrings.onboardingTitle3.tr(),
            AppStrings.onboardingsubtitle3.tr(),
            ImageAssets.Onboardinglogo3),
        SlideObject(
            AppStrings.onboardingTitle4.tr(),
            AppStrings.onboardingsubtitle4.tr(),
            ImageAssets.Onboardinglogo4)
      ];
}

abstract class OnboardingViewModelInputs {
  // Orders taked from view
  int goNext(); // Go to next page in vieW

  int goPrevious(); // Go to previous page

  void onPageChanged(int index); // Change page

  // InputStream put data in sink
  Sink get inputslideViewObject;
}

abstract class OnboardingViewModelOutputs {
  // OutputStream get data from streamcontroller
  Stream<SliderViewObject> get outputSlideViewObject;
}
