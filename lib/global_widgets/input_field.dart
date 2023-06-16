import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.isObscured,
    required this.label,
    required this.validator,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObscured;
  final String label;
  final String? Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscured,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Theme.of(context).colorScheme.primary,
      decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          filled: true,
          fillColor: Theme.of(context).colorScheme.tertiary,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8))),
    );
  }
}
