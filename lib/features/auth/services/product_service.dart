// import 'dart:convert';
// import 'dart:html';
// import 'package:foodapplication/features/auth/services/config.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import '../../../models/product.dart';
// import 'dart:async'; 

// List<Product> parseProducts(String responseBody) { 
//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
//    return parsed.map<Product>((json) => Product.fromMap(json)).toList(); 
// } 
// Future<List<Product>> fetchProducts() async { 
//    final response = await http.get('http://192.168.1.2:8000/products.json'); 
//    if (response.statusCode == 200) { 
//       return parseProducts(response.body); 
//    } else { 
//       throw Exception('Unable to fetch products from the REST API'); 
//    } 
// }