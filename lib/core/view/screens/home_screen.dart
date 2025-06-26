import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_app/core/utils/string_constants.dart';
import 'package:firebase_authentication_app/core/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String? email;
  const HomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(email ?? ''),
          CustomButton(
            text: StringConstants.logout,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
