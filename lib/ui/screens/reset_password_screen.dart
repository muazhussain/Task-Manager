import 'package:flutter/material.dart';
import 'package:flutter_03/ui/screens/login_screen.dart';
import 'package:flutter_03/ui/widgets/app_elevated_button.dart';
import 'package:flutter_03/ui/widgets/app_text_form_field.dart';
import 'package:flutter_03/ui/widgets/login_singup_navigaton.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/utils/text_styles.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reset Password',
                  style: screenTitleTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Enter a password of 8 digit & letters',
                  style: subtitleTextStyle,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFieldWidget(
                  obscureText: true,
                  hintText: 'Password',
                  controller: TextEditingController(),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFieldWidget(
                  obscureText: true,
                  hintText: 'Conform Password',
                  controller: TextEditingController(),
                ),
                const SizedBox(
                  height: 24,
                ),
                AppElevatedButton(
                  child: const Text('Conform'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
                LoginSignupNavigation(
                  statement: 'Have account?',
                  buttonText: 'Log In',
                  function: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
