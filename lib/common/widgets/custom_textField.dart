import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hinText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hinText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.brown,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.brown,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hinText';
        }
        return null;
      },
    );
  }
}
