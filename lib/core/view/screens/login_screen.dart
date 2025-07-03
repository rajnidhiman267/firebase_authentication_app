import 'package:firebase_authentication_app/core/utils/constants/color_constant.dart';
import 'package:firebase_authentication_app/core/utils/constants/string_constants.dart';
import 'package:firebase_authentication_app/core/utils/helpers/helper_utils.dart';
import 'package:firebase_authentication_app/core/utils/validator.dart';
import 'package:firebase_authentication_app/core/view/widgets/heading_text_widget.dart';
import 'package:firebase_authentication_app/core/view/widgets/or_widget.dart';
import 'package:firebase_authentication_app/core/view/widgets/other_auth_options_widget.dart';
import 'package:firebase_authentication_app/core/viewmodel/auth_viewmodel.dart';
import 'package:firebase_authentication_app/core/widgets/custom_button_widget.dart';
import 'package:firebase_authentication_app/core/widgets/custom_password_widget.dart';
import 'package:firebase_authentication_app/core/widgets/custom_textfield_widget.dart';
import 'package:firebase_authentication_app/core/widgets/rich_text_widget.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFEAEAEA),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              HeaderTextWidget(title: StringConstants.login),
              SizedBox(height: 40),
              _authSection(context),
              SizedBox(height: 40),
              OrWidget(),
              SizedBox(height: 30),
              _otherAuthOptionSection(),
              SizedBox(height: 20),
              RichTextWidget(
                onTap: () {},
                firstText: StringConstants.alreadyHaveAccount,
                secondText: StringConstants.signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otherAuthOptionSection() {
    return Consumer<Authprovider>(
      builder: (context, provider, _) {
        return OtherAuthOptionsWidget(
          isAbsorbing: provider.isLoading,
          onFaceBookTap: () {},
          onGoogleTap: () {},
          onTwitterTap: () {},
        );
      },
    );
  }

  _authSection(BuildContext parentContext) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstants.lightestSeagreen,
            ColorConstants.lightestNavyBlue,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Consumer<Authprovider>(
          builder: (context, provider, _) {
            return AbsorbPointer(
              absorbing: provider.isLoading,
              child: Form(
                key: provider.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: provider.emailController,
                      validator: FormValidators.emailValidator,
                      onChanged: provider.validateEmail,
                      showSuccessIcon: provider.isValid,
                      prefixIcon: Icons.person,
                      hintText: StringConstants.enterEmail,
                    ),
                    const SizedBox(height: 15),
                    CustomPasswordField(
                      controller: provider.passwordController,
                      validator: FormValidators.passwordValidator,
                      onChanged: FormValidators.passwordValidator,
                      hintText: StringConstants.enterPassword,
                      isObscure: provider.isObscure,
                      toggleObscure: provider.toggleObscure,
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      text: StringConstants.login,
                      onPressed: () async {
                        if (provider.loginFormKey.currentState?.validate() ??
                            false) {
                          FocusScope.of(parentContext).unfocus();
                          provider.onSignInAction(
                            () => callBackFunction(context),
                          );
                        }
                      },
                      isLoading: provider.isLoading,
                      isEnabled: !provider.isLoading,

                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      StringConstants.forgotPassword,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  callBackFunction(BuildContext context) {
    HelperUtils.showToast(
      context: context,
      headingTitle: StringConstants.loginFailed,
      backgroundColor: Colors.red,
    );
  }
}
