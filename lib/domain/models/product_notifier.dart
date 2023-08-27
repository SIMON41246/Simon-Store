import 'package:ecommerce_app/data/response/response.dart';
import 'package:flutter/cupertino.dart';

class Shop extends ChangeNotifier {
  List<Products> _cart = [];

  List<Products> get cart => _cart;

  void addToCart(Products products, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(products);
    }
    notifyListeners();
  }

  void removefromCart(Products products) {
    _cart.remove(products);
    notifyListeners();
  }
}
