import 'package:firebase_authentication_app/core/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';

class HeaderTextWidget extends StatelessWidget {
  final String title;
  const HeaderTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          ColorConstants.lightSeagreen,
          ColorConstants.lightNavyBlue,
        ], // Sea Green to Blue
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: ColorConstants
              .whiteColor, // Required but will be overridden by shader
        ),
      ),
    );
  }
}