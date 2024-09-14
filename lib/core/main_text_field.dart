import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    this.hintText,
    this.maxLines,
    this.controller, // Add this line
  });

  final String? hintText;
  final int? maxLines;
  final TextEditingController? controller; // Add this line

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Add this line
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
