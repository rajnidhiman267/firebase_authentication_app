

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_app/core/utils/validator.dart';
import 'package:flutter/material.dart';

class Loginprovider with ChangeNotifier {
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

  Future<void> onSignInAction(
    Function? callBack, {
    required BuildContext parentContext,
  }) async {
    // Check if the form is valid
    if (loginFormKey.currentState?.validate() ?? false) {
      // Hide keyboard
      FocusScope.of(parentContext).unfocus();

      setLoading(true); // Show loading indicator

      try {
        // Attempt Firebase sign-in
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        callBack?.call();
        if (e.code == 'user-not-found') {
          debugPrint('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          debugPrint('Wrong password provided for that user.');
        }
      } finally {
        setLoading(false); // Always hide loader
        // Notify after loading change
      }
    }
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
