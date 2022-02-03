import 'package:flutter/material.dart';

class CoustomFormTextField extends StatelessWidget {
  String? hintText;
  Function(String)? onChange;
  bool? scure;

  CoustomFormTextField(
      {required this.hintText, this.onChange, this.scure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: scure!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: '$hintText',
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
      ),
    );
  }
}
