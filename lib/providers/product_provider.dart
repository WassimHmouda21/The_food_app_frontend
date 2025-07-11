// This class tracks the products that 
// the user wants to buy, and it's a [ChangeNotifier]

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class Cart with ChangeNotifier {
  List<Product> products = [];

  double get total {
    return products.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.price;
    });
  }

  void addToCart(Product product) {
    products.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    products.remove(product);
    notifyListeners();
  }
}
