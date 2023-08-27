import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_preferences.dart';
import '../../app/constants.dart';


const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const AUTHORIZATION = "autorization";
const String DEFAULT_LANGUAGE = "language";
class DioFactory{
  AppPrefrences appPrefrences;
  DioFactory(this.appPrefrences);
  Future<Dio> getDio() async {
    String language=await appPrefrences.getLanguage();
    Duration timeout=Duration(seconds: 30);
    Dio dio=Dio();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "SEND TOKEN HERE",
      DEFAULT_LANGUAGE: language // todo we will get lang from prefs
    };
    dio.options=BaseOptions(
      baseUrl: Constants.baseurl,
      sendTimeout: timeout,
      headers: headers,
      receiveTimeout: timeout,
    );
    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}