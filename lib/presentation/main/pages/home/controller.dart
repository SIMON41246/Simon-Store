import 'dart:core';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/data/network/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../../../app/constants.dart';
import '../../../../models/product.dart';

class DataController extends GetxController {
  var productlist = <Products>[].obs;
  var isDataLoading = false.obs;

  @override
  void onInit() {
    getApi();
    super.onInit();
  }

  getApi() async {


    try {
      isDataLoading(true);
      http.Response response = await http.get(
        Uri.tryParse(Constants.url)!,
      );
      if (response.statusCode == 200) {
        ///data successfully
        var res = response.body;
        var products = productsFromJson(res);
        productlist.value = products;
      } else {
        ///error
        return Lottie.asset("assets/json/error.json");
      }
    } catch (e) {
      log('Error while getting data is $e',name: "TAg");
      _handleErrorforMain(e);
    } finally {
      isDataLoading(false);
    }
  }

  void _handleErrorforMain(dynamic dioException) {
    final scaffoldMessenger = Get.isSnackbarOpen ? null : Get.snackbar;
    switch (dioException.type) {
      case DioErrorType.connectionTimeout:
        scaffoldMessenger!(DataSource.CONNECT_TIMEOUT.getFailure().massage,
            DataSource.CONNECT_TIMEOUT.getFailure().code.toString());
      case DioErrorType.sendTimeout:
        scaffoldMessenger!(DataSource.SEND_TIMEOUT.getFailure().massage,
            DataSource.SEND_TIMEOUT.getFailure().code.toString());
      case DioErrorType.receiveTimeout:
        scaffoldMessenger!(DataSource.RECIEVE_TIMEOUT.getFailure().massage,
            DataSource.RECIEVE_TIMEOUT.getFailure().code.toString());
      case DioErrorType.badCertificate:
        scaffoldMessenger!(DataSource.FORBBIDEN.getFailure().massage,
            DataSource.FORBBIDEN.getFailure().code.toString());
      case DioErrorType.badResponse:
        if (dioException.response?.statusMessage != null &&
            dioException.response?.statusCode != null) {
          scaffoldMessenger!(dioException.response?.statusCode.toString() ?? "",
              dioException.response?.statusMessage ?? "");
        } else {
          scaffoldMessenger!(DataSource.FORBBIDEN.getFailure().massage,
              DataSource.FORBBIDEN.getFailure().code.toString());
        }
      case DioErrorType.cancel:
        scaffoldMessenger!(DataSource.CANCEL.getFailure().massage,
            DataSource.CANCEL.getFailure().code.toString());
      case DioErrorType.connectionError:
        scaffoldMessenger!(DataSource.CONNECT_TIMEOUT.getFailure().massage,
            DataSource.CONNECT_TIMEOUT.getFailure().code.toString());

      case DioErrorType.unknown:
        scaffoldMessenger!(DataSource.DEFAULT.getFailure().massage,
            DataSource.DEFAULT.getFailure().code.toString());
    }
  }
}
