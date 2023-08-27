import 'package:ecommerce_app/data/response/response.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CartList extends ChangeNotifier {
   RxList list = [].obs;

  void addToCart(dynamic products, int quantity) {
    for (int i = 0; i < quantity; i++) {
      list.add(products);
    }
    notifyListeners();
  }

  void removeFromCart(dynamic products) {
    list.remove(products);
    notifyListeners();
  }
}
