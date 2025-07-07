import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_app/core/utils/validator.dart';
import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  final signupFormKey = GlobalKey<FormState>();

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController reEnterPasswordCtrl = TextEditingController();
  bool _isValid = false;

  bool get isValid => _isValid;

  bool _isObscure = true;

  bool get isObscure => _isObscure;

  bool isLoading = false;

  void validateEmail(String value) {
    final error = FormValidators.emailValidator(value);
    final current = error == null;
    if (_isValid != current) {
      _isValid = current;
      notifyListeners();
    }
  }

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
    emailCtrl.dispose();
    passwordCtrl.dispose();
    reEnterPasswordCtrl.dispose();
    super.dispose();
  }

  actionOnSignUp({required BuildContext parentContext}) async {
    if (signupFormKey.currentState?.validate() ?? false) {
      // Hide keyboard
      FocusScope.of(parentContext).unfocus();
      setLoading(true);
      try {
        final result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailCtrl.text.trim(),
              password: reEnterPasswordCtrl.text.trim(),
            );
        // ✅ Check if user was successfully created
        if (result.user != null) {
          debugPrint('Signup successful for: ${result.user!.email}');

          // ✅ You can send email verification (optional)
          // await result.user!.sendEmailVerification();

          // ✅ Show a success snackbar or dialog
          ScaffoldMessenger.of(parentContext).showSnackBar(
            SnackBar(content: Text('Account created successfully!')),
          );

          // ✅ Navigate to login or home screen
          Navigator.pop(parentContext);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _showErrorSnackbar(
            parentContext,
            'The account already exists for that email.',
          );
          debugPrint('The account already exists for that email.');
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        setLoading(false);
      }
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
