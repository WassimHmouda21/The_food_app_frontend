import 'package:flutter/material.dart';
import 'package:foodapplication/features/auth/screens/signin.dart';
// import 'package:myapp/basket/basket.dart';
// import 'package:myapp/home/home_screen.dart';
// import 'package:myapp/library/library.dart';
import 'package:foodapplication/common/widgets/bottom_nav_bar.dart';


import '../../features/auth/screens/Favorite_screen.dart';
import '../../features/auth/screens/cart_screen.dart';
import '../../features/auth/screens/category_screen.dart';
import '../../features/auth/screens/product_screen.dart';
import '../../library/library.dart';

class CustomTabbar extends StatefulWidget {
  static const String routeName = "/Tabbar";
  const CustomTabbar({super.key});

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food App"),
          bottom: const TabBar(tabs: [
            //1
            Tab(
              icon: Icon(Icons.storefront_outlined),
              text: "Store",
            ),
            //2
            Tab(
              icon: Icon(Icons.bookmark_add_outlined),
              text: "Library",
            ),
            //3
            Tab(
              icon: Icon(Icons.shopping_basket_outlined),
              text: "Basket",
            ),
          ]),
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
                      Navigator.pushNamed(context, BottomNavScreen.routeName);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        //1
                        Icon(Icons.border_bottom),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Navigation par BottomBar"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
            children: [ MyCategoryPage(categories: fetchCategories()), FavoriteProductsPage(), const CartPage()]),
      ),
    );
  }
}
