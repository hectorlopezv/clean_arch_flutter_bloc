import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final TextInputType? inputType;
  final Function(String)? onChanged;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.errorText,
    this.onChanged,
    this.inputType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style:
      Theme
          .of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Colors.black),
      obscureText: obscureText,
      keyboardType: inputType,
      onChanged: onChanged,

      decoration: InputDecoration(
        label: Text(labelText),
        errorText: errorText,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
