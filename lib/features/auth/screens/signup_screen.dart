// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:foodapplication/common/widgets/custom_button.dart'
    show CustomButton;
import 'package:foodapplication/common/widgets/custom_textField.dart';
import 'package:foodapplication/constants/global_variables.dart';
import 'package:foodapplication/features/auth/screens/signin_screen.dart';
import 'package:foodapplication/features/auth/services/auth_service.dart';

enum Auth {
  signup,
  
}

class SignupAuthScreen extends StatefulWidget {
  static const String routeName = '/signnup-screen';
  const SignupAuthScreen({Key? key}) : super(key: key);

  @override
  State<SignupAuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<SignupAuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
   final AuthService authService = AuthService();



  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _birthController.dispose();
    _adressController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        birth: _birthController.text,
        adress: _adressController.text, 
        token: '');
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 236, 155),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
  mainAxisAlignment: MainAxisAlignment.start, // Align children to the top (left in a vertical context).
  crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left.
  children: [
    Text(
      '   welcome, get on board',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
    ),   const SizedBox(height: 45),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? const Color.fromARGB(255, 240, 239, 218)
                      : Color.fromRGBO(221, 214, 194, 0.922),
                  title: const Text(
                    "SIGN UP for your Account ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white54,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children:[   Row(
      children: [const Text(
                    'Email ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),],),
                  const SizedBox(height: 10),
                          CustomTextField(
                            controller: _emailController,
                            hinText: 'Email',
                          ),
                          const SizedBox(height: 10),
                         Row(
      children: [  const Text(
                    'Password ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),],),
                  const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passwordController,
                            hinText: 'Password',
                          ),
                          const SizedBox(height: 10),
                         Row(
      children: [  const Text(
                    'Username ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),],),
                  const SizedBox(height: 10),
                          CustomTextField(
                            controller: _usernameController,
                            hinText: 'Username',
                          ),
                          const SizedBox(height: 10),
                          Row(
      children: [ const Text(
                    'Birth ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),],),
                  const SizedBox(height: 10),
                          
                          CustomTextField(
                            controller: _birthController,
                            hinText: 'Birth',
                          ),
                          
                          const SizedBox(height: 10),
                          Row(
      children: [ const Text(
                    'Adress ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),],),
                  const SizedBox(height: 10),
                          CustomTextField(
                            controller: _adressController,
                            hinText: 'Adress',
                          ),
                          
                   ],
                      ),
                    ),
                  ),   const SizedBox(height: 55), // Add some vertical space here.
          Container(
            // Separate container for the CustomButton widget.
            child: CustomButton(
              text: 'Signup',
              onTap: () {
                if (_signUpFormKey.currentState!.validate()) {
                  signUpUser();
                }
                  },
                ),
              ),
              const SizedBox(height: 20), // Add some vertical space here.
Center(
  child: GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        SigninHomescreen.routeName,
      );
    },
    child: Text(
      'Already have an account? Sign in',
      style: TextStyle(
        color: Color.fromARGB(255, 28, 31, 16), // Customize the text color.
        decoration: TextDecoration.underline,
      ),
    ),
  ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
        