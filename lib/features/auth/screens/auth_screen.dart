// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:foodapplication/common/widgets/custom_button.dart'
    show CustomButton;
import 'package:foodapplication/common/widgets/custom_textField.dart';
import 'package:foodapplication/constants/global_variables.dart';
import 'package:foodapplication/features/auth/services/auth_service.dart';

enum Auth {
  signup,
  signin,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
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
        token: '',
       );
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('welcome',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? const Color.fromARGB(255, 240, 239, 218)
                      : Color.fromRGBO(221, 214, 194, 0.922),
                  title: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                      activeColor: Colors.blueAccent,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white54,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hinText: 'Email',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passwordController,
                            hinText: 'Password',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _usernameController,
                            hinText: 'Username',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _birthController,
                            hinText: 'Birth',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _adressController,
                            hinText: 'Adress',
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Signup',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? const Color.fromARGB(255, 240, 239, 218)
                      : Color.fromRGBO(221, 214, 194, 0.922),
                  title: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                      activeColor: Colors.blueAccent,
                      value: Auth.signin,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white54,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hinText: 'Email',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passwordController,
                            hinText: 'Password',
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Signin',
                            onTap: () { if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }},
                          )
                        ],
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
