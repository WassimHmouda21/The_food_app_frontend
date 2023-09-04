import 'package:flutter/material.dart';
import 'package:foodapplication/features/auth/screens/auth_screen.dart';
import 'package:foodapplication/features/auth/screens/productbycateg_screen.dart';
import 'package:foodapplication/features/auth/screens/signin.dart';
import 'package:foodapplication/features/auth/screens/signup_screen.dart';
import '../../../models/category.dart';
import 'common/widgets/bottom_nav_bar.dart';
import 'features/auth/screens/cart_screen.dart';
import 'features/auth/screens/product_screen.dart';
import 'features/auth/screens/signin_screen.dart';
import 'models/product.dart';


// Route<dynamic> generateRoute(RouteSettings routeSettings) {
//   switch (routeSettings.name) {
//     case AuthScreen.routeName:
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const AuthScreen(),
//       );
 // Handle other cases if necessary
Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

        case SignupAuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupAuthScreen(),
      );

        case SigninHomescreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SigninHomescreen(),
      );

            case CartPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  const CartPage(),
      );

    case MyHomePagebycat.routeName:
      final args = routeSettings.arguments;
      if (args is List<Product>) {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => MyHomePagebycat(products: Future.value(args)),
        );
      }
      // Handle the case where args is not of the expected type
      // You might want to return a different route or show an error screen
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Signin(),
      );
      
        case BottomNavScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(child: Text('Screen does not exist'),
          ),
        ),
      );
  }
}
