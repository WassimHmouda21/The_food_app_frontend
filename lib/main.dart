import 'package:flutter/material.dart';
import 'package:foodapplication/features/auth/screens/signin.dart';
import 'package:foodapplication/features/auth/services/auth_service.dart';
import 'package:foodapplication/providers/product_provider.dart';
import 'package:foodapplication/providers/user_provider.dart';
import 'package:foodapplication/router.dart';
import 'package:foodapplication/features/auth/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:foodapplication/providers/product_provider.dart';
import 'common/widgets/bottom_nav_bar.dart';
import 'features/auth/screens/signup_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
        ),
        
     ChangeNotifierProvider.value(value: Cart()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black38,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ?const BottomNavScreen() :const SignupAuthScreen(),
      // home: AuthScreen(),
      // // Set AuthScreen as the home screen
      // routes: {'/home': (context) => Signin()},
    );
  }
}
