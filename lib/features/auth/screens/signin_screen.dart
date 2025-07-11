import 'package:flutter/material.dart';
import 'package:foodapplication/features/auth/screens/signup_screen.dart';
import 'package:foodapplication/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textField.dart';
import '../../../constants/global_variables.dart';
import '../services/auth_service.dart';
enum Auth {
 
  signin,
}
class SigninHomescreen extends StatefulWidget {
  static const String routeName = '/signin_screen';
  const SigninHomescreen({Key? key}) : super(key: key);

  @override
  State<SigninHomescreen> createState() => _SigninHomescreen();
}

class _SigninHomescreen extends State<SigninHomescreen> {
  Auth _auth = Auth.signin;

  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

  }



  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: Color.fromARGB(255, 210, 236, 155),
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
                  tileColor: _auth == Auth.signin
                      ? const Color.fromARGB(255, 240, 239, 218)
                      : Color.fromRGBO(221, 214, 194, 0.922),
                  title: const Text(
                    'Please Login to continue ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white54,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [Row(
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
                          const SizedBox(height: 10),Row(
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
                        
                        ],
                      ),
                    ),),
                    const SizedBox(height: 55), // Add some vertical space here.
          Container(
            // Separate container for the CustomButton widget.
            child:   CustomButton(
                            text: 'Signin',
                            onTap: () { if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }},
                          )
              ),
              const SizedBox(height: 20), // Add some vertical space here.
Center(
  child: GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        SignupAuthScreen.routeName,
      );
    },
    child: Text(
      "don't have an account? Sign up",
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
