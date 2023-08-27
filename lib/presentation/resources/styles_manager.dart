import 'package:flutter/cupertino.dart';

import 'font_manager.dart';

TextStyle _getTextstyle(double fontsize, FontWeight fontWeight, Color color) {
  return TextStyle(
      color: color,
      fontFamily: FontConstants.fontFamily,
      fontSize: fontsize,
      fontWeight: fontWeight);
}

//regular style
TextStyle getRegularStyle(
    {double fontsize = FontSize.s12, required Color color}) {
  return _getTextstyle(fontsize, FontWeightManager.regular, color);
}

//Medium Style

TextStyle getMediumStyle(
    {double fontsize = FontSize.s12, required Color color}) {
  return _getTextstyle(fontsize, FontWeightManager.medium, color);
}


//Light Style

TextStyle getLightStyle(
    {double fontsize = FontSize.s12, required Color color}) {
  return _getTextstyle(fontsize, FontWeightManager.light, color);
}

//Bold Style

TextStyle getBoldStyle(
    {double fontsize = FontSize.s12, required Color color}) {
  return _getTextstyle(fontsize, FontWeightManager.bold, color);
}

//Semi Style

TextStyle getSemiBoldStyle(
    {double fontsize = FontSize.s12, required Color color}) {
  return _getTextstyle(fontsize, FontWeightManager.SemiBold, color);
}
