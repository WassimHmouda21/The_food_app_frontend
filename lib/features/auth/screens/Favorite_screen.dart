import 'package:flutter/material.dart';
import 'package:foodapplication/providers/FavoriProduct.dart';
import 'package:provider/provider.dart';
// Import your AppState class if needed
 // Import your FavoriteProduct class

class FavoriteProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProduct = Provider.of<FavoriteProduct>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: ListView.builder(
        itemCount: favoriteProduct.favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProduct.favoriteProducts[index];
          return ListTile(
            leading: Image.asset(product.productimage),
            title: Text(product.productname),
            subtitle: Text(product.description),
            trailing: Text("Price: ${product.price.toString()}"),
          );
        },
      ),
    );
  }
}
