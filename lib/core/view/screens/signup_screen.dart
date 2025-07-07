import 'package:firebase_authentication_app/core/utils/constants/string_constants.dart';
import 'package:firebase_authentication_app/core/utils/validator.dart';

import 'package:firebase_authentication_app/core/viewmodel/sign_up_provider.dart';
import 'package:firebase_authentication_app/core/widgets/custom_button_widget.dart';
import 'package:firebase_authentication_app/core/widgets/custom_password_widget.dart';
import 'package:firebase_authentication_app/core/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignupProvider>(
        builder: (childContext, provider, child) {
          return Form(
            key: provider.signupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: provider.emailCtrl,
                  validator: FormValidators.emailValidator,
                  onChanged: provider.validateEmail,
                  showSuccessIcon: provider.isValid,
                  prefixIcon: Icons.person,
                  hintText: StringConstants.enterEmail,
                ),
                const SizedBox(height: 15),
                CustomPasswordField(
                  controller: provider.passwordCtrl,
                  validator: FormValidators.passwordValidator,
                  onChanged: FormValidators.passwordValidator,
                  hintText: StringConstants.enterPassword,
                  isObscure: provider.isObscure,
                  toggleObscure: provider.toggleObscure,
                ),
                const SizedBox(height: 15),
                CustomPasswordField(
                  controller: provider.reEnterPasswordCtrl,
                  validator: (value) => FormValidators.validateResetPassword(
                    value,
                    provider.passwordCtrl.text,
                  ),
                  onChanged: FormValidators.passwordValidator,
                  hintText: StringConstants.reEnterPassword,
                  isObscure: provider.isObscure,
                  toggleObscure: provider.toggleObscure,
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: StringConstants.login,
                  onPressed: () async {
                    await provider.actionOnSignUp(parentContext: context);
                  },
                  isLoading: provider.isLoading,
                  isEnabled: !provider.isLoading,

                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
