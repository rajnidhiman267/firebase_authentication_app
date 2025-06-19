import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;
  final bool isObscure;
  final VoidCallback toggleObscure;
  final String hintText;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.isObscure,
    required this.toggleObscure,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        obscureText: isObscure,

        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            maxWidth: 200,
            minWidth: 60,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: const Icon(Icons.lock, color: Colors.grey, size: 20),
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(40),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(40),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),

          errorStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.normal,
          ),
          suffixIcon: InkWell(
            onTap: toggleObscure,
            child: Icon(
              size: 20,
              isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
