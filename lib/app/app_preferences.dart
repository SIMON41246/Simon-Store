import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manager.dart';


const String APP_PREFS_KEY = "APP_PREFS_KEY";
const String ONBOARDINGVIEWSCREENVIEWED = "OnBoardingViewScreenViewed";
const String UserLoggedInSuccesFully = "UserLoggedInSuccesFully";

class AppPrefrences {
  final SharedPreferences _sharedPreferences;

  AppPrefrences(this._sharedPreferences);

  Future<String> getLanguage() async {
    String? language = _sharedPreferences.getString(APP_PREFS_KEY);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getLanguage();
    if (currentLang == LanguageType.ENGLISH.getValue()) {
      _sharedPreferences.setString(
          APP_PREFS_KEY, LanguageType.ARABIC.getValue());
    } else {
      _sharedPreferences.setString(
          APP_PREFS_KEY, LanguageType.ENGLISH.getValue());
    }
  }




  Future<Locale> getLocal() async {
    String currentLang = await getLanguage();
    if (currentLang == LanguageType.ENGLISH.getValue()) {
      return ENGLISH_LOCALE;
    } else {
      return ARABIC_LOCALE;
    }
  }

  Future<void> setOnBoardingViewScreenViewed() async {
    _sharedPreferences.setBool(ONBOARDINGVIEWSCREENVIEWED, true);
  }

  Future<bool> isOnBoardingViewScreenViewed() async {
    return _sharedPreferences.getBool(ONBOARDINGVIEWSCREENVIEWED) ?? false;
  }

  Future<void> setUserLoggedInSuccesFully() async {
    _sharedPreferences.setBool(UserLoggedInSuccesFully, true);
  }

  Future<bool> isUserLoggedInSuccesFully() async {
    return _sharedPreferences.getBool(UserLoggedInSuccesFully) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(UserLoggedInSuccesFully);
  }
}
