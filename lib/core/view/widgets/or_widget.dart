import 'package:firebase_authentication_app/core/utils/constants/string_constants.dart';
import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: Colors.grey, height: 5, thickness: 1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              StringConstants.orContinueWith,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey, // Required but will be overridden by shader
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: Colors.grey, height: 5, thickness: 1),
          ),
        ],
      ),
    );
  }
}