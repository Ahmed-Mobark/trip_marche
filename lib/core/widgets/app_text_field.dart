import 'package:flutter/material.dart';
import 'package:trip_marche/core/widgets/app_text_form_field.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixWidget,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      label: label,
      hintText: hint,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      prefixWidget: prefixWidget,
      suffixWidget: suffixIcon,
    );
  }
}

