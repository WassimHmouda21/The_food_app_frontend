import 'dart:convert';
import 'dart:html';
import 'package:foodapplication/features/auth/screens/product_screen.dart';
import 'package:foodapplication/features/auth/screens/productbycateg_screen.dart';
import 'package:foodapplication/features/auth/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../models/category.dart';
import 'dart:async';

import '../../../models/product.dart';

List<Category> parseCategories(String responseBody) {
  final parsed = json.decode(responseBody)['data'] as List<dynamic>;
  return parsed.map<Category>((json) => Category.fromMap(json)).toList();
}


Future<List<Category>> fetchCategories() async {
 
 final response = await http.get(Uri.parse('http://localhost:3000/api/category'));

if (response.statusCode == 200) {
  print(response.body); // Print the JSON data
  return parseCategories(response.body);
} else {
  throw Exception('Unable to fetch categories from the REST API');
}
}

class MyCategoryPage extends StatelessWidget {
  final String title;
  final Future<List<Category>> categories;

  MyCategoryPage({required this.categories, this.title = "", Key? key})
      : super(key: key);

  // final items = Category.getCategories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category Navigation")),
      body: Center(
        child: FutureBuilder<List<Category>>(
          future: categories,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("Error loading categories."));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final categoryList = snapshot.data!;
              return CategoryBoxList(items: categoryList);
            } else {
              return Center(child: Text("No categories available."));
            }
          },
        ),
      ),
    );
  }
}

class CategoryBoxList extends StatelessWidget {
  final List<Category> items;
  CategoryBoxList({Key? key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(

          child: CategoryBox(item: items[index], key: ValueKey(index)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPage(item: items[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class CategoryPage extends StatelessWidget {
  final _productFormKey = GlobalKey<FormState>();
  CategoryPage({Key? key, required this.item}) : super(key: key);
  final Category item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.categoryname),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(this.item.categoryimage),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Form(
                         key: _productFormKey, // Associate the form key with Form
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.categoryname,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 10),
 CustomButton(
  text: 'Products list',
  onTap: () async {
    if (_productFormKey.currentState!.validate()) {
      try {
        String categoryId = item.id.trim(); // Use the category ID here
        print("Category ID Value: $categoryId");

        List<Product> productList = await fetchProductsByCategoryId(categoryId);

        Navigator.pushNamed(
          context,
          MyHomePagebycat.routeName,
          arguments: productList,
        );
      } catch (e) {
        print('Error fetching products: $e');
      }
    }
  },
)








 

  
                          
                            //  RatingBox(),
                          ],
                        ),),),),
              ]),
        ),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  // final _productFormKey = GlobalKey<FormState>();
  CategoryBox({Key? key, required this.item}) : super(key: key);
  final Category item;

  Widget build(BuildContext context) {
    final int index = (key as ValueKey).value; // Retrieving index from key
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(child: Text('${index + 1}')),
                Image.asset(this.item.categoryimage),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.categoryname,
                                style: TextStyle(fontWeight: FontWeight.bold)),
              //                    const SizedBox(height: 10),
              //         CustomButton(
              // text: 'Sign in',
              // onTap: () {
              //   if (_productFormKey.currentState!.validate()) {
              //     // If validation passes, navigate to MyHomePage
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => MyHomePage(products: fetchProducts())),
              //       );
              //     } 
              //   }, 
              // ),
          ],
                         
                           
                          
                        )))
              ]),
        ));
  }
}
