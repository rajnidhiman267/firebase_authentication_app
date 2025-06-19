import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;
  final double borderRadius;
  final double? width;
  final double? height;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.borderRadius = 30,
    this.width,
    this.height,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = (isEnabled && !isLoading)
        ? [const Color(0xFF00C9A7), const Color(0xFF0072FF)]
        : [Colors.grey.shade400, Colors.grey.shade500];

    return GestureDetector(
      onTap: (isEnabled && !isLoading) ? onPressed : null,
      child: Container(
        height: height ?? 45,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: (isEnabled && !isLoading)
              ? [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.6),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
