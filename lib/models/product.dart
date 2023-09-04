import 'category.dart';

class Product {
  final String id;
  final String productname;
  final String description;
  final double price;
  final String productimage;
  final String productType;
  final Category category;

  Product({
    required this.id,
    required this.productname,
    required this.description,
    required this.price,
    required this.productimage,
    required this.productType,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> json) {
    final categoryJson = json['category'] as Map<String, dynamic>;
    final category = Category.fromMap(categoryJson);

    return Product(
      id: json['productId'] as String,
      productname: json['productname'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      productimage: json['productimage'] as String,
      productType: json['productType'] as String,
      category: category,
    );
  }
}