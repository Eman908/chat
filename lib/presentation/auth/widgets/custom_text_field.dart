import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.prefix,
    this.suffix,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.controller,
    this.prefixText,
    this.enabled,
    this.autofillHints,
  });
  final String hintText;
  final bool isPassword;
  final IconData? prefix;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? suffix;
  final String? prefixText;
  final bool? enabled;
  final Iterable<String>? autofillHints;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      enableSuggestions: !isPassword,
      decoration: InputDecoration(
        prefixText: prefixText,
        prefixIcon: Icon(prefix),
        hintText: hintText,
        suffixIcon: suffix,
      ),
    );
  }
}
