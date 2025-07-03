import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final Function()? onTap;
  final String firstText;
  final String secondText;
  const RichTextWidget({
    super.key,
    this.onTap,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey, // Required but will be overridden by shader
          ),
        ),
        SizedBox(width: 5),
        InkWell(
          onTap: onTap,
          child: Text(
            secondText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}