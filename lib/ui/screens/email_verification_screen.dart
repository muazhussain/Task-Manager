import 'package:flutter/material.dart';
import 'package:flutter_03/ui/screens/otp_verification_screen.dart';
import 'package:flutter_03/ui/screens/sign_up_screen.dart';
import 'package:flutter_03/ui/widgets/app_elevated_button.dart';
import 'package:flutter_03/ui/widgets/app_text_form_field.dart';
import 'package:flutter_03/ui/widgets/login_singup_navigaton.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/utils/text_styles.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
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
                  'Enter Your Email',
                  style: screenTitleTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'A 6 digit verification pin will be send to your email address',
                  style: subtitleTextStyle,
                ),
                const SizedBox(
                  height: 24,
                ),
                AppTextFieldWidget(
                  hintText: 'Email',
                  controller: TextEditingController(),
                ),
                AppElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtpVerification(),
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
                const SizedBox(
                  height: 16,
                ),
                LoginSignupNavigation(
                  statement: 'Don\'t have an account?',
                  buttonText: 'Sign Up',
                  function: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
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
