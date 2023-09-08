import 'dart:convert';
import 'dart:html';
import 'package:foodapplication/features/auth/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../models/product.dart';
import 'dart:async';

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody)['data'] as List<dynamic>;
  return parsed.map<Product>((json) => Product.fromMap(json)).toList();
}


Future<List<Product>> fetchProducts() async {
 
 final response = await http.get(Uri.parse('http://localhost:3000/api/product'));

if (response.statusCode == 200) {
  print(response.body); // Print the JSON data
  return parseProducts(response.body);
} else {
  throw Exception('Unable to fetch products from the REST API');
}
}

class MyHomePage extends StatelessWidget {
  static const String routeName = '/product-screen';
  final String title;
  final Future<List<Product>> products;

  MyHomePage({required this.products, this.title = "", Key? key})
      : super(key: key);

  // final items = Product.getProducts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Navigation")),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("Error loading products."));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final productList = snapshot.data!;
              return ProductBoxList(items: productList);
            } else {
              return Center(child: Text("No products available."));
            }
          },
        ),
      ),
    );
  }
}

class ProductBoxList extends StatelessWidget {
  final List<Product> items;
  ProductBoxList({Key? key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ProductBox(item: items[index], key: ValueKey(index)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(item: items[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ProductPage extends StatelessWidget {
  
  ProductPage({Key? key, required this.item}) : super(key: key);
  final Product item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.productname),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(this.item.productimage),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.productname,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                            Text("Price: " + this.item.price.toString()),
                            //  RatingBox(),
                          ],
                        )))
              ]),
        ),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key? key, required this.item}) : super(key: key);
  final Product item;

  Widget build(BuildContext context) {
    final int index = (key as ValueKey).value;
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               CircleAvatar(child: Text('${index + 1}')),
                Image.asset(this.item.productimage),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.productname,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                            Text("Price: " + this.item.price.toString()),
                           
                          ],
                        )))
              ]),
        ));
  }
}
