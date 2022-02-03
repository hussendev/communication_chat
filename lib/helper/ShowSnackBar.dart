 import 'package:flutter/material.dart';
 void ShowMessage(BuildContext context, Color color, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(text),
    ),
  );
}
