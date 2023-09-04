import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapplication/constants/error_handling.dart';
import 'package:foodapplication/constants/utils.dart';
import 'package:foodapplication/features/auth/screens/signin.dart';
import 'package:foodapplication/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:foodapplication/constants/global_variables.dart';
import 'package:foodapplication/models/user.dart';
import 'package:http/http.dart' as http;

import '../../../common/widgets/bottom_nav_bar.dart';
import '../../../models/product.dart';
import '../screens/product_screen.dart';

class AuthService {
  static const String baseUrl =
      'http://localhost:3000'; // Update with your server URL

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    required String birth,
    required String adress,
    required String token,
  }) async {
    try {
      User user = User(
          id: '',
          email: email,
          password: password,
          username: username,
          birth: birth,
          adress: adress,
          token: token);

      http.Response res = await http.post(
        Uri.parse(
            '$baseUrl/auth/api/signup'), // Update the route based on your backend API
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
            '$baseUrl/auth/api/signin'), // Update the route based on your backend API
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    BuildContext? context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context!, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context!, e.toString());
    }
  }
}


Future<List<Product>> getAllProducts() async {
 
 final response = await http.get(Uri.parse('http://localhost:3000/api/product'));

if (response.statusCode == 200) {
  print(response.body); // Print the JSON data
  return parseProducts(response.body);
} else {
  throw Exception('Unable to fetch products from the REST API');
}
}

Future<Product> addProduct(Product product) async {
  final Uri uri = Uri.parse('http://localhost:3000/api/product');

  final Map<String, dynamic> requestData = {
    'productname': product.productname,
    'category': product.category,
    'description': product.description,
    'price': product.price,
    'productType': product.productType,
    'productimage': product.productimage,
    // Add other properties as needed
  };

  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the response JSON into a Product object
    final parsedProduct = jsonDecode(response.body);
    return Product.fromMap(parsedProduct);
  } else {
    // If the server returns an error response, throw an exception to handle the error
    throw Exception('Failed to add product');
  }
}