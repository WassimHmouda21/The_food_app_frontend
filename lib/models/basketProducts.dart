import 'package:flutter/cupertino.dart';
import 'package:foodapplication/models/product.dart';
import 'category.dart';

class BasketProduct {
  final String id;
  final String productId; // If you want to keep a reference to the original product's ID
  final String productName; // Renamed for consistency
  final String description;
  final double price;
  final String productImage; // Renamed for consistency
  final String productType;
  final Category category;

  BasketProduct({
    required this.id,
    required this.productId,
    required this.productName,
    required this.description,
    required this.price,
    required this.productImage,
    required this.productType,
    required this.category,
  });

  factory BasketProduct.fromMap(Map<dynamic, dynamic> res) {
    return BasketProduct(
      id: res['id'] as String, // Assuming 'id' is the key for the basket product's ID
      productId: res['productId'] as String, // Assuming 'productId' is the key for the original product's ID
      productName: res['productName'] as String,
      description: res['description'] as String,
      price: (res['price'] as num).toDouble(),
      productImage: res['productImage'] as String,
      productType: res['productType'] as String,
      category: Category.fromMap(res['category'] as Map<String, dynamic>),
    );
  }
}

