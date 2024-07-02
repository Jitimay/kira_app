import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator; // Add validator
  final int maxLines; // Add maxLines

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator, // Initialize validator
    this.maxLines = 1, // Initialize maxLines with default value
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField( // Change TextField to TextFormField
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: validator, // Add validator
      maxLines: maxLines, // Add maxLines
    );
  }
}
