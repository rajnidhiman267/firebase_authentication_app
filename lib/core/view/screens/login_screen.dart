import 'package:firebase_authentication_app/core/utils/assets_constants.dart';
import 'package:firebase_authentication_app/core/utils/string_constants.dart';
import 'package:firebase_authentication_app/core/utils/validator.dart';
import 'package:firebase_authentication_app/core/viewmodel/auth_viewmodel.dart';
import 'package:firebase_authentication_app/core/widgets/custom_button_widget.dart';
import 'package:firebase_authentication_app/core/widgets/custom_password_widget.dart';
import 'package:firebase_authentication_app/core/widgets/custom_textfield_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.read<Authprovider>().loginFormKey;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFEAEAEA),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 80),
                _loginHeader(),
                SizedBox(height: 40),
                _authSection(formKey, context),
                SizedBox(height: 40),
                _orSection(),
                SizedBox(height: 30),
                _otherAuthOptionSection(),
                SizedBox(height: 20),
                _signupSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _signupSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringConstants.dontHaveAccount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey, // Required but will be overridden by shader
          ),
        ),
        SizedBox(width: 5),
        InkWell(
          onTap: () {},
          child: Text(
            StringConstants.signUp,
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

  Widget _otherAuthOptionSection() {
    return Consumer<Authprovider>(
      builder: (context, provider, _) {
        return AbsorbPointer(
          absorbing: provider.isLoading,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AssetsConstants.googleIcon,
                    height: 30,
                    width: 30,
                    semanticsLabel: 'Logo',
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AssetsConstants.facebookImage,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),

              InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AssetsConstants.twitterImage,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _orSection() {
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

  Container _authSection(
    GlobalKey<FormState> formKey,
    BuildContext parentContext,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      // padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFB9F8ED), const Color(0xFFC0DCFF)],
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
                      if (formKey.currentState?.validate() ?? false) {
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
            );
          },
        ),
      ),
    );
  }

  ShaderMask _loginHeader() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF00C9A7), Color(0xFF0072FF)], // Sea Green to Blue
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: const Text(
        StringConstants.login,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Required but will be overridden by shader
        ),
      ),
    );
  }

  callBackFunction(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(StringConstants.loginFailed)));
  }
}
