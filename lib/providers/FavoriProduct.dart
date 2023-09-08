import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';



class FavoriteProduct with ChangeNotifier {
  List<Product> favoriteProducts = [];

  void toggleFavorite(Product product) {
    // Check if the product is in the list of favorite products
    final isFavorite = favoriteProducts.contains(product);

    if (isFavorite) {
      favoriteProducts.remove(product); // Remove from favorites
    } else {
      favoriteProducts.add(product); // Add to favorites
    }

    // Notify listeners that the state has changed
    notifyListeners();
  }
}

