
import 'package:ecommerce_app/presentation/resources/color_manager.dart';
import 'package:ecommerce_app/presentation/resources/styles_manager.dart';
import 'package:ecommerce_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main Colors
    primaryColor: color_manager.primary,
    primaryColorLight: color_manager.Lightprimary,
    primaryColorDark: color_manager.darkprimary,
    disabledColor: color_manager.grey1,
    splashColor: color_manager.Lightprimary,

    // Cardview theme
    cardTheme: CardTheme(
        color: color_manager.white,
        shadowColor: color_manager.grey,
        elevation: AppSize.s4),

    //app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: color_manager.primary,
        elevation: AppSize.s4,
        shadowColor: color_manager.Lightprimary,
        titleTextStyle: getRegularStyle(
            fontsize: FontSize.s16, color: color_manager.white)),

    // button theme
    buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: color_manager.error,
        buttonColor: color_manager.primary,
        splashColor: color_manager.Lightprimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getRegularStyle(color: color_manager.white, fontsize: FontSize.s18),
        primary: color_manager.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    // texttheme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: color_manager.darkgrey, fontsize: FontSize.s16),
      headlineLarge: getSemiBoldStyle(
          color: color_manager.darkgrey, fontsize: FontSize.s16),
      titleMedium:
          getMediumStyle(color: color_manager.primary, fontsize: FontSize.s16),
      titleSmall:
          getRegularStyle(color: color_manager.white, fontsize: FontSize.s16),
      labelSmall:
          getRegularStyle(color: color_manager.primary, fontsize: FontSize.s12),
      bodyMedium: getBoldStyle(color: color_manager.grey2, fontsize: FontSize.s12),
      headlineMedium: getRegularStyle(
          color: color_manager.darkgrey, fontsize: FontSize.s14),
      bodyLarge: getRegularStyle(
        color: color_manager.grey1,
      ),
      bodySmall: getRegularStyle(color: color_manager.grey),
    ),

    // input decoration theme[text form field]
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        AppPaddingManager.p8,
      ),
      hintStyle:
          getRegularStyle(color: color_manager.grey, fontsize: FontSize.s14),

      labelStyle:
          getMediumStyle(color: color_manager.grey, fontsize: FontSize.s14),
      errorStyle: getRegularStyle(
        color: color_manager.error,
      ),

      // focused border
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color_manager.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color_manager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // Error border style
      errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: color_manager.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    ),

    //label style
  );
}
