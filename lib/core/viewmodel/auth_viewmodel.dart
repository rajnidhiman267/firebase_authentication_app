import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_app/core/utils/validator.dart';
import 'package:flutter/material.dart';

class Authprovider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool _isValid = false;

  bool get isValid => _isValid;
  bool isLoading = false;

  void validateEmail(String value) {
    final error = FormValidators.emailValidator(value);
    final current = error == null;
    if (_isValid != current) {
      _isValid = current;
      notifyListeners();
    }
  }
  // Show loader

  onSignInAction(Function? callBack) async {
    setLoading(true);

    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      log('Sign In Error: $e');
      callBack?.call();
    } finally {
      setLoading(false); // Hide loader
    }
  }

  void disposeController() {
    emailController.dispose();
    passwordController.dispose();
  }

  bool _isObscure = true;

  bool get isObscure => _isObscure;

  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
