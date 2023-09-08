import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:foodapplication/features/auth/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import 'dart:async';
import '../../../models/category.dart' as AppCategory;
import '../../../providers/FavoriProduct.dart';
import '../../../providers/product_provider.dart';


List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody)['data'] as List<dynamic>;
  return parsed.map<Product>((json) {
    return Product(
      id: json['productId'] as String,
      productname: json['productname'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      productimage: json['productimage'] as String,
      productType: json['productType'] as String,
      category: AppCategory.Category( // Use the alias to avoid the conflict
        id: json['category'] as String,
        categoryname: '', // Set appropriate values if needed
        categorydescription: '', // Set appropriate values if needed
        categoryimage: '', // Set appropriate values if needed
      ),
    );
  }).toList();
}




// Corrected function name to fetchProductsByCategoryName
Future<List<Product>> fetchProductsByCategoryId(String categoryId) async {
  final response = await http.get(Uri.parse('http://localhost:3000/api/product/category/$categoryId'));
  print('Response Body: ${response.body}'); // Print the JSON data
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}






class MyHomePagebycat extends StatelessWidget {
  static const String routeName = '/productbycat-screen';
  final String title;
  final Future<List<Product>> products;

  MyHomePagebycat({required this.products, this.title = "", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...'); // Handle loading state
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Handle error state
            } else if (snapshot.hasData) {
              final productList = snapshot.data!;
              final categoryName = productList.isNotEmpty ? productList[0].category.categoryname : '';
              return Text('Products for $categoryName');
            } else {
              return Text('No products available.'); // Handle no data state
            }
          },
        ),
      ),
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



class ProductPage extends StatefulWidget {
  ProductPage({Key? key, required this.item}) : super(key: key);
  final Product item;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isFavorite = false; // Initially not favorited

  void toggleFavorite() {
    final favoriteProduct = Provider.of<FavoriteProduct>(context, listen: false);

    // Check if the product is in the list of favorite products
    final isCurrentlyFavorite = favoriteProduct.favoriteProducts.contains(widget.item);

    setState(() {
      if (isCurrentlyFavorite) {
        favoriteProduct.favoriteProducts.remove(widget.item); // Remove from favorites
      } else {
        favoriteProduct.favoriteProducts.add(widget.item); // Add to favorites
      }
      isFavorite = !isCurrentlyFavorite; // Toggle the favorite status
    });
  }

    @override
  void initState() {
    super.initState();
    // Check if the current product is in the list of favorite products when the widget initializes
    final favoriteProduct = Provider.of<FavoriteProduct>(context, listen: false);
    isFavorite = favoriteProduct.favoriteProducts.contains(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.productname),
        actions: [
          IconButton(
            icon: isFavorite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            onPressed: toggleFavorite,
          ),
        ],
      ),
       body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(this.widget.item.productimage),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(this.widget.item.productname,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(this.widget.item.description),
                      Text("Price: " + this.widget.item.price.toString()),
                      SizedBox(height: 5,),
                      Container(
                        height: 30,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 6, 45, 111),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.zero,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            final cart = context.read<Cart>();
                            cart.addToCart(widget.item); // Add the product to the cart
                          },
                          child: Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// // Rest of your code...
// class ProductPage extends StatelessWidget {
//   ProductPage({Key? key, required this.item}) : super(key: key);
//   final Product item;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(this.item.productname),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Image.asset(this.item.productimage),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Text(this.item.productname,
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text(this.item.description),
//                       Text("Price: " + this.item.price.toString()),
//                       SizedBox(height: 5,),
//                       Container(
//                         height: 30,
//                         width: 130,
//                         decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 6, 45, 111),
//                           borderRadius: BorderRadius.horizontal(
//                             right: Radius.zero,
//                           ),
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             final cart = context.read<Cart>();
//                             cart.addToCart(item); // Add the product to the cart
//                           },
//                           child: Text('Add to Cart'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

                      
      

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
