import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback? onTap;
  String text;
  CustomButton({
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        child: Center(child: Text('$text')),
      ),
    );
  }
}
