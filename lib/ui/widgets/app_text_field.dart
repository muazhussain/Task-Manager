import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLines,
    this.obscureText,
    this.validator,
    this.readOnly,
  });

  final String hintText;
  final TextEditingController controller;
  final int? maxLines;
  final bool? obscureText;
  final bool? readOnly;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      validator: (value) {
        return validator!(value);
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
