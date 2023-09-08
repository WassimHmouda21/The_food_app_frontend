import 'package:flutter/material.dart';
import 'package:foodapplication/features/auth/screens/category_screen.dart';
import 'package:foodapplication/features/auth/screens/signin.dart';

// import 'package:myapp/basket/basket.dart';
// import 'package:myapp/home/home_screen.dart';
// import 'package:myapp/library/library.dart';
import 'package:foodapplication/common/widgets/tab_bar.dart';


import '../../features/auth/screens/Favorite_screen.dart';
import '../../features/auth/screens/cart_screen.dart';
import '../../features/auth/screens/product_screen.dart';
import '../../features/auth/screens/productbycateg_screen.dart';
import '../../library/library.dart';

class BottomNavScreen extends StatefulWidget {
  static const String routeName = "/nav_bar";
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  //var
  int index = 0;
  List<Widget> interfaces = [ MyCategoryPage(categories: fetchCategories()), FavoriteProductsPage() , const CartPage()];
  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food App"),
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("WELCOME BACK"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //1
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      //1
                      Icon(Icons.edit),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Modifier profil"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //2
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, CustomTabbar.routeName);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      //1
                      Icon(Icons.navigation_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Navigation par Tabbar"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            //1
            BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined), label: "Store"),
            //2
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_added_outlined), label: "Library"),
            //3
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined), label: "Basket"),
          ]),
      body: interfaces[index],
    );
  }
}
