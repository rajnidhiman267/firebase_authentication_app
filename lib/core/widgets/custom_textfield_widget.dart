import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;
  final bool showSuccessIcon;
  final IconData prefixIcon;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.showSuccessIcon,
    required this.prefixIcon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            maxWidth: 200,
            minWidth: 60,
          ),

          contentPadding: EdgeInsets.symmetric(vertical: 5),
          prefixIcon: Icon(prefixIcon, color: Colors.grey, size: 20),
          suffixIcon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: showSuccessIcon
                ? const Icon(
                    Icons.check_circle_rounded,
                    size: 20,
                    color: Colors.green,
                    key: ValueKey('valid'),
                  )
                : const SizedBox(key: ValueKey('invalid'), width: 0, height: 0),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white70),
            borderRadius: BorderRadius.circular(40),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(40),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFF5448), width: 1),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFF5448), width: 1),
            borderRadius: BorderRadius.circular(40),
          ),
          helperText:
              ' ', // forces consistent space whether error is shown or not
          helperStyle: TextStyle(height: 1),

          errorStyle: const TextStyle(
            color: Color(0xFFFF5448),
            fontWeight: FontWeight.w400,
          ),

          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
